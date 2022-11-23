import 'package:flutter/material.dart';

class OutputPage extends StatelessWidget {
  final String sentence;
  const OutputPage({super.key, required this.sentence});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is Output Page"),
      ),
      body: Center(
        child: Text(
          sentence.toString(),
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
