import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sub_editor/panels/homepage_panels/home_button.dart';
import 'package:sub_editor/components/name_row.dart';

import '../../logic/models/side_layout_model.dart';

class SideLayout  extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Function changePanel;
  final List<SideLayoutButton> menuButtons;

  SideLayout ({super.key, required this.changePanel, required this.menuButtons});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red
                ]
              ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 70),

            // App Name
            const Text(
              'SubEdit',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            
            // Icon and mail
            NameRow(userEmail: user.email ?? 'default'),

            const SizedBox(height: 15),

            for (int i = 0; i < menuButtons.length; i++)
            HomeButton(
              buttonText: menuButtons[i].buttonText,
              buttonIcon: menuButtons[i].buttonIcon,
              buttonColor: menuButtons[i].buttonColor,
              onTap: () => changePanel(i),
            ),

            HomeButton(
              buttonText: 'Sign out', 
              buttonIcon: Icons.exit_to_app, 
              buttonColor: Colors.red, 
              onTap: signUserOut
            )
          ],
        ),
      ),
    );
  }
}