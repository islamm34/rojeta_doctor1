import 'package:flutter/material.dart';

class FakeAuthWidget extends StatefulWidget {
  const FakeAuthWidget({super.key});

  @override
  State<FakeAuthWidget> createState() => _FakeAuthWidgetState();
}

class _FakeAuthWidgetState extends State<FakeAuthWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Fake Auth Widget: counter = \$counter'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => setState(() => counter++),
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
