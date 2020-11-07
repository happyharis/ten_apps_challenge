import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final Question question;

  const QuestionScreen({Key key, this.question}) : super(key: key);
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentOptionId;
  bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final isCompleted = isCorrect != null;
    // final _question = Provider.of<QuizNotifier>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 15),
            for (var option in question.options)
              RadioListTile<int>(
                title: Text(option.text),
                groupValue: currentOptionId,
                value: option.id,
                onChanged: (value) {
                  if (!isCompleted)
                    setState(() {
                      currentOptionId = value;
                    });
                },
              ),
            Spacer(),
            if (isCorrect != null)
              Text(isCorrect ? 'You are correct! ✅' : 'You are wrong! ❌'),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(isCompleted ? 'Continue' : 'Submit'),
                onPressed: () {
                  if (isCompleted)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => QuestionScreen(),
                      ),
                    );
                  if (currentOptionId != null)
                    setState(() {
                      isCorrect = currentOptionId == question.correctAnswerId;
                    });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final questions = [question, question2];

final question = Question(
  text: 'What is Flutter?',
  correctAnswerId: 3,
  options: [
    Option(id: 1, text: 'Wings flapping'),
    Option(id: 2, text: 'Programming language'),
    Option(id: 3, text: 'Multi Platform UI Kit'),
    Option(id: 4, text: 'Word'),
  ],
);
final question2 = Question(
  text: 'What is Dart?',
  correctAnswerId: 2,
  options: [
    Option(id: 1, text: 'Wings flapping'),
    Option(id: 2, text: 'Programming language'),
    Option(id: 3, text: 'Multi Platform UI Kit'),
    Option(id: 4, text: 'Word'),
  ],
);

class Question {
  final String text;
  final int correctAnswerId;
  final List<Option> options;

  Question({this.text, this.correctAnswerId, this.options});
}

class Option {
  final int id;
  final String text;

  Option({this.id, this.text});
}

class QuizNotifier extends ChangeNotifier {
  final List<Question> questions;
  QuizNotifier(this.questions)
      : currentQuestion = questions.first,
        progress = 0;

  Question currentQuestion;

  int progress;

  bool isFinished = false;

  int score;

  void updateProgress() {
    progress++;
    currentQuestion = questions[progress];

    if (currentQuestion == questions.last) isFinished = true;
  }
}
