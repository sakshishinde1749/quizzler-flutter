import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const Padding(
          padding: EdgeInsets.all(25.0),
          child: SafeArea(
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if(quizBrain.isFinished() == true){
        Alert(context: context, title: "Finished!", desc: "You\'ve reached the end of the quiz.").show();

        quizBrain.resetQuestionNumber();

        scoreKeeper = [];
      }
      else{
        if(userPickedAnswer == correctAnswer){
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        }
        else{
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }

        quizBrain.nextQuestion();
      }

    });
  }

  List<Icon> scoreKeeper = [];

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 6,
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
        ),

        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text(
                  'True',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: (){
                  checkAnswer(true);
                },
              ),
            ),
        ),

        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: (){
                  checkAnswer(false);
                },
              ),
            ),
        ),

        Row(
          children: scoreKeeper,
        ),
      ],
    );


  }
}

