//Nico Garay
//
//Quiz timer that if timer goes to 0 the quiz question ends,
// sends you to the next page, and all unanswered questions are marked incorrect.

import 'dart:async';
import 'package:flutter/material.dart';

class QuizTimer extends StatefulWidget {
  final int totalTime; // Total time in seconds for the timer
  final ValueChanged<int> onTimeUpdate; // Callback to send remaining time
  final VoidCallback onTimeEnd; // Callback when the timer reaches zero

  const QuizTimer({
    super.key,
    required this.totalTime,
    required this.onTimeUpdate,
    required this.onTimeEnd,
  });

  @override
  _QuizTimerState createState() => _QuizTimerState();
}

class _QuizTimerState extends State<QuizTimer> {
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.totalTime;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Method to start the countdown timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        widget.onTimeUpdate(_remainingTime); // Update parent widget
      } else {
        _timer?.cancel();
        widget.onTimeEnd(); // Notify parent when the timer reaches zero
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time Remaining: $_remainingTime seconds',
      style: TextStyle(
          fontSize: 20,
          color: _remainingTime <= 10 ? Colors.red : Colors.black),
    );
  }
}
