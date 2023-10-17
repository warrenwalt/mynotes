// REGISTER VIEW HERE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

 late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform
              ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
          children: [
            TextField(
              controller: _email,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email here',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password here',
              ),
            ),
            TextButton(onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              print('attempting to send authentication credentialsneu😑😑😑');
              try{
              final userCredental = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
              print(userCredental);
              } on FirebaseAuthException catch (e){
                if (e.code == 'weak-password'){
                print('weak passwordy');
                } else if (e.code == 'email-already-in-use'){
                  print('$email email is already in use');
                } else {
                  print(e.code);
                }
              }
            },
            child: const Text('Register')),
          ],
        );
        default:
        print('we are loading firebase...👍');
        return const Text('loading...');
          }
        },
      ),
    );
  }
}
