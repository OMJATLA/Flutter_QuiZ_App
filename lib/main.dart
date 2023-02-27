import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './question.dart';
import './quiz_brain.dart';

Quiz_brain qb = Quiz_brain();
void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: quiz_page(),
        ),
      ),
    ),
  );
}

class quiz_page extends StatefulWidget {
  const quiz_page({super.key});

  @override
  State<quiz_page> createState() => _quiz_pageState();
}

class _quiz_pageState extends State<quiz_page> {
  List<Widget> scoreKeeper = [];
  var correctCount = 0;
  var wrongCount = 0;
  //checkans
  void checkAnswer(bool userInput) {
    bool correctans = qb.getAnswerText();

    setState(() {
      if (qb.isFinsihed() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          content: Column(
            children: [
              Text('Correct Answers :$correctCount'),
              Text('Wrong Answers :$wrongCount'),
            ],
          ),
        ).show();
        scoreKeeper = [];
        qb.reset();
        correctCount = 0;
        wrongCount = 0;
      } else {
        if (correctans == userInput) {
          correctCount++;
          print('Correct Ans');
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          wrongCount++;
          print('Wrong Ans');
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }

        qb.nextQuestion();
      }
    });
  }

//   List questions = [
//     'You can lead a cow down stairs but not up stairs.',
//     'Approximately one quarter of human bones are in the feet.',
//     'A slug\'s blood is green.'
//   ];

//   List<bool> answers = [false, true, true];

// //creating object of class Question
//   Question q1 = Question(
//       q: 'You can lead a cow down stairs but not up stairs.', a: false);

  // List<Question> questionbank = [
  //   new Question(
  //       q: 'You can lead a cow down stairs but not up stairs.', a: false),
  //   new Question(
  //       q: 'Approximately one quarter of human bones are in the feet.',
  //       a: true),
  //   new Question(q: 'A slug\'s blood is green.', a: true)
  // ];

  // int questionindex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qb.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}



// question1: 'You can lead a cow down stairs but not up stairs.', false,
// question2: 'Approximately one quarter of human bones are in the feet.', true,
// question3: 'A slug\'s blood is green.', true,