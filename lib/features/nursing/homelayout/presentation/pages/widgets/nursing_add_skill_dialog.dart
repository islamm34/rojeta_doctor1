import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';

class NursingAddSkillDialog extends StatefulWidget {
  final ValueChanged<String> onSkillAdded;

  const NursingAddSkillDialog({
    super.key,
    required this.onSkillAdded,
  });

  @override
  State<NursingAddSkillDialog> createState() => _NursingAddSkillDialogState();
}

class _NursingAddSkillDialogState extends State<NursingAddSkillDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return AlertDialog(
      title: Text(s.addSkill),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: s.skillsSpecialty,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(s.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final text = _controller.text.trim();
            if (text.isNotEmpty) {
              widget.onSkillAdded(text);
            }
            context.pop();
          },
          child: Text(s.add),
        ),
      ],
    );
  }
}
