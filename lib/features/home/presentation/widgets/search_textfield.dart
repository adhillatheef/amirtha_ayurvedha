import 'package:flutter/material.dart';

class SearchTexField extends StatelessWidget {
  const SearchTexField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search for treatment',
      ),
    );
  }
}
