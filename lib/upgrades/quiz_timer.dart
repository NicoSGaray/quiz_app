//Nico Garay
//
//Quiz timer that if timer goes to 0 the quiz question ends,
// sends you to the next page, and all unanswered questions are marked incorrect.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizTimer extends StatefulWidget {
  final int totalTime; // Total time in seconds for each question
  final ValueChanged<int> onTimeUpdate; // Callback to send remaining time
  final VoidCallback onTimeEnd; // Callback when the timer reaches zero

  const QuizTimer({
    super.key,
    required this.totalTime,
    required this.onTimeUpdate,
    required this.onTimeEnd,
  });

  @override
  QuizTimerState createState() => QuizTimerState();
}

class QuizTimerState extends State<QuizTimer> {
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

  // Method to start or restart the timer
  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer before starting a new one
    _remainingTime = widget.totalTime; // Reset the remaining time

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

  // Expose a method to restart the timer from the parent widget
  void restartTimer() {
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: '$_remainingTime seconds',
              style: TextStyle(
                fontSize: 35,
                color: _remainingTime <= 5
                    ? Colors.red
                    : Colors.white, // White initially, then red when <= 10
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
