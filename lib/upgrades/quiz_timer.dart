//Nico Garay
//This method creates a timer that sends you to the next question if you run out of time

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
        widget.onTimeUpdate(_remainingTime); // Update widget
      } else {
        _timer?.cancel();
        widget.onTimeEnd(); // Notify widget when the timer reaches zero
      }
    });
  }

  //Restart the timer from the widget
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
              style: GoogleFonts.lato(
                fontSize: 35,
                color: _remainingTime <= 5
                    ? Colors.red
                    : Colors.white, //Colored change to insentivise picking a answer
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
