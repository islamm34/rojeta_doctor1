import 'package:flutter/material.dart';

class SettingsTileDivider extends StatelessWidget {
  const SettingsTileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: Colors.grey.shade100, height: 1),
    );
  }
}
