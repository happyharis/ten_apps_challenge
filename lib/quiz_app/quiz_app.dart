import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ten_apps_challenge/quiz_app/question_screen.dart';

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              'Flutter Quiz',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 50),
            FlutterLogo(size: 350),
            Spacer(),
            ChangeNotifierProvider(
              create: (context) => QuizNotifier(questions),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Start Quiz'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return QuestionScreen();
                    }));
                  },
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
