import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sub_editor/components/auth_button.dart';
import 'package:sub_editor/components/auth_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool passwordIsStrong(String password) {
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  //register user in method
  void registerUser() async {
    try{

      if (passwordController.text != confirmPasswordController.text) {
        //Navigator.pop(context);
        showMessage('Passwords don\'t match.');
        passwordController.clear();
        confirmPasswordController.clear();
      } else if (!passwordIsStrong(passwordController.text)) {
        showMessage('Password is too weak.');
        passwordController.clear();
        confirmPasswordController.clear();
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text, 
        password: passwordController.text,);

              
        final user = FirebaseAuth.instance.currentUser!;
        CollectionReference users = firestore.collection('users');
        await users.doc(user.uid).set({
        'UID':user.uid,
        'mail':user.email
        });
      }

      //Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      //Navigator.pop(context);

      if (e.message.toString().contains('email-already-in-use')) {
        showMessage('This email is already taken.');
        usernameController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
      } 
      
      else if (e.message.toString().contains('invalid-email')){
        showMessage('Invalid email.');
        usernameController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
      } 
      
      else if (e.message.toString().contains('weak-password')){
        showMessage('Weak password.');
        passwordController.clear();
        confirmPasswordController.clear();
      }

      else {
        showMessage('Registration temporarly disabeled.');
        usernameController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
      }
    }
  }

  //Error message popup
  void showMessage(String errorMessage) {
    showDialog(context: context, builder: ((context) {
      return AlertDialog(title: Center(child: Text(errorMessage)),
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 214, 214),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [          
                // Logo text
                const SizedBox(height: 50),
                const Icon(Icons.account_circle,
                size: 100,),
                   
                //welcome back
                const SizedBox(height: 50),
                const Text(
                  'Let\'s make an account!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    fontSize: 16,
                  ),
                ),
                   
                //username textfield
                const SizedBox(height: 25),
                AuthTextField(
                  controller: usernameController,
                  hintText: 'Enter email',
                  obscureText: false,),
           
                //password textfield
                const SizedBox(height: 10),
                AuthTextField(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: true,
                ),

                //confirm password textfield
                const SizedBox(height: 10),
                AuthTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
          
                //sign in button
                const SizedBox(height: 25),
                AuthButton(
                  onTap: registerUser,
                  buttonText: 'Register',
                ),
          
                //register button
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}