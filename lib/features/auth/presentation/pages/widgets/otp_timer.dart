import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class OtpTimer extends StatefulWidget {
  final VoidCallback onResend;

  const OtpTimer({
    super.key,
    required this.onResend,
  });

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  int _secondsRemaining = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final strings = context.strings;

    if (_secondsRemaining > 0) {
      final minutesStr = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
      final secondsStr = (_secondsRemaining % 60).toString().padLeft(2, '0');
      return Center(
        child: Text(
          '$minutesStr:$secondsStr',
          style: textTheme.bodyLarge?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Center(
        child: TextButton(
          onPressed: () {
            widget.onResend();
            setState(() {
              _startTimer();
            });
          },
          child: Text(
            strings.resendCode,
            style: textTheme.bodyLarge?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }
  }
}
