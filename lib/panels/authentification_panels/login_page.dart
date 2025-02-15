import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sub_editor/components/auth_button.dart';
import 'package:sub_editor/components/auth_textfield.dart';


class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context, 
      builder: (context){
        return const Center(
          child: CircularProgressIndicator()
        );
      }
    );
    //try login 
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usernameController.text, 
      password: passwordController.text,);

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      Navigator.pop(context);

      if (e.message.toString().contains('invalid-email')) {
        showMessage('Invalid email.');
        usernameController.clear();
        passwordController.clear();
      } 
      
      else if (e.message.toString().contains('user-not-found')){
        showMessage('No user with such email.');
        usernameController.clear();
        passwordController.clear();
      } 
      
      else if (e.message.toString().contains('wrong-password')){
        showMessage('Wrong password.');
        passwordController.clear();
      }

      else {
        showMessage('Too many requests. Try again later.');
        usernameController.clear();
        passwordController.clear();
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
                  'Welcome back you\'ve been missed!',
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
          
                //sign in button
                const SizedBox(height: 25),
                AuthButton(
                  onTap: signUserIn,
                  buttonText: 'Sign in',
                ),
          
                //register button
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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