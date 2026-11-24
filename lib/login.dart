import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider; // Hide EmailAuthProvider from firebase_auth to avoid conflict with firebase_ui_auth
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(), //AnonymousProvider()
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to your app! Please sign in.')
                    : const Text('Welcome! Please create an account.'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                // Navigate to your home screen when signed in
                Navigator.pushReplacementNamed(context, '/home');
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
                // Navigate to your home screen when a new user is created
                Navigator.pushReplacementNamed(context, '/home');
              }),
            ],
          );
        }

        // If the user is signed in, show your application's home screen
        return const HomePage(); // Your actual home screen widget
      },
    );
  }
}
