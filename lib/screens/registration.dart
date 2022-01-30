import 'package:book_recommender/common.dart' as common;
import 'package:book_recommender/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isToSAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _signUpKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Personal Info',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const Divider(
                thickness: 2.0,
                color: Colors.deepPurple,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _firstName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your first name.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'First Name',
                  ),
                  autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _lastName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your last name.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Last Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Security',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const Divider(
                thickness: 2.0,
                color: Colors.deepPurple,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your email.';
                    }
                    return null;
                  },
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Enter your password.';
                    }
                    return null;
                  },
                  autocorrect: false,
                  obscureText: true,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Terms',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const Divider(
                thickness: 2.0,
                color: Colors.deepPurple,
              ),
              CheckboxListTile(
                value: _isToSAccepted,
                onChanged: (isChecked) {
                  setState(() {
                    _isToSAccepted = isChecked!;
                  });
                },
                title: const Text('I accept the Terms of Use.'),
                subtitle:
                    const Text('By joining, I agree to the Application Terms.'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<common.User>(
                  builder: (context, user, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_isToSAccepted) {
                          if (_signUpKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registering the user....'),
                              ),
                            );
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _email.text,
                                password: _password.text,
                              );
                              user.register(_firstName.text, _lastName.text);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LibraryScreen()),
                              );
                            } catch (e) {
                              // TODO: Add real error handling.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error registering new user.'),
                                ),
                              );
                              print(e);
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Accept the Terms of Use.')),
                          );
                        }
                      },
                      child: const Text('Join Now'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
