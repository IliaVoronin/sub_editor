import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search for a project...'
            ),
          ),
        ),
      ),
    );
  }
}