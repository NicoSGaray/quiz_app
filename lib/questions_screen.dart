import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/upgrades/quiz_progress_bar.dart';
import 'package:quiz_app/upgrades/quiz_timer.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
   final int totalTimePerQuestion = 10; // Set time per question in seconds
  final GlobalKey<QuizTimerState> _quizTimerKey =
      GlobalKey<QuizTimerState>(); // Key to control the QuizTimer

  // Method to handle answer selection
  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    moveToNextQuestion();
  }

  // Method to move to the next question
  void moveToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      _quizTimerKey.currentState?.restartTimer(); // Restart the timer
    }
  }

  // Method to handle when the timer reaches zero
  void handleTimeEnd() {
    // Automatically move to the next question
    moveToNextQuestion();
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Implement the QuizTimer widget
            Center(
              child: QuizTimer(
                key: _quizTimerKey,
                totalTime: totalTimePerQuestion,
                onTimeUpdate: (remainingTime) {},
                onTimeEnd: handleTimeEnd,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 133, 114, 235),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  answerQuestion(answer);
                },
              );
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: QuizProgressBar(
                // Added for progress bar
                currentQuestionIndex: currentQuestionIndex,
                totalQuestions: questions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

