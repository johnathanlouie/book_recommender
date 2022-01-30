import 'dart:convert';

import 'package:book_recommender/common.dart';
import 'package:book_recommender/screens.dart';
import 'package:book_recommender/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textBlock = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 1000,
                controller: _textBlock,
                autocorrect: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description required.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Describe your book.',
                ),
              ),
            ),
            Consumer<SearchResults>(
              builder: (context, results, child) {
                return ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Understanding your request....'),
                          ),
                        );
                        http.Response response = await http.post(
                          Uri.parse(
                              'https://api.smmry.com?SM_API_KEY=9DAE6B59C3&SM_KEYWORD_COUNT=5'),
                          body: {'sm_api_input': _textBlock.text},
                        );
                        var responseBody = jsonDecode(response.body);
                        var keywords = List<String>.from(
                            responseBody['sm_api_keyword_array']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Finding books....'),
                          ),
                        );
                        response = await http.get(Uri.parse(
                            'https://www.googleapis.com/books/v1/volumes?q=${keywords.join('+')}'));
                        responseBody = jsonDecode(response.body);
                        // TODO: What if there are no books?
                        for (var item in responseBody['items']) {
                          results.add(Book.fromGoogle(item));
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ResultsScreen(),
                        ));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error: Try again later.'),
                          ),
                        );
                        print(e);
                      }
                    }
                  },
                  child: const Text('Find'),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomBar(MyBottomBar.search),
    );
  }
}
