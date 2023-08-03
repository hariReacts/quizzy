import 'package:flutter/material.dart';
import 'package:quizzy/questionBank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(const Quizzler());
QuestionBank questionBank = QuestionBank();

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreCheckList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState(() {
                  if (questionBank.isFinished() == true) {
                    Alert(
                        context: context,
                        title: 'Finished',
                        desc: 'You\'ve reached the end of the quiz',
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            color: Colors.purple,
                            radius: BorderRadius.circular(0.0),
                            child: const Text(
                              "Restart the Quiz",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ]).show();

                    questionBank.reset();
                    scoreCheckList = [];
                  } else {
                    if (questionBank.getQuestionAnswer() == true) {
                      scoreCheckList
                          .add(const Icon(Icons.check, color: Colors.green));
                    } else {
                      scoreCheckList
                          .add(const Icon(Icons.close, color: Colors.red));
                    }
                    questionBank.nextQuestion();
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                setState(() {
                  if (questionBank.isFinished() == true) {
                    Alert(
                      context: context,
                      title: 'Finished',
                      desc: 'You\'ve reached the end of the quiz',
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          color: Colors.purple,
                          radius: BorderRadius.circular(0.0),
                          child: const Text(
                            "Restart the Quiz",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ).show();

                    questionBank.reset();
                    scoreCheckList = [];
                  } else {
                    if (questionBank.getQuestionAnswer() == false) {
                      scoreCheckList
                          .add(const Icon(Icons.check, color: Colors.green));
                    } else {
                      scoreCheckList
                          .add(const Icon(Icons.close, color: Colors.red));
                    }
                  }
                  questionBank.nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreCheckList,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
