// Arturo Valle
// Question Progress Bar

import 'package:flutter/material.dart';

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    super.key,
    required this.currentQuestionIndex,
    required this.totalQuestions,
  });

  final int currentQuestionIndex;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(8.0), // Adds padding around the progress bar
      child: SizedBox(
        height: 7.5, //Adds height to the progress bar
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(10),
          // Progress value based on current question index and total questions
          value: (currentQuestionIndex + 1) / totalQuestions,

          // Background for the unfilled progress bar
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),

          // filled portion of the progress bar
          valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 132, 63, 172)),
        ),
      ),
    );
  }
}
