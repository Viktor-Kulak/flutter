import 'package:first_flutter/model/question.dart';
import 'package:flutter/material.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _currentQuestionsIndex = 0;
  List questionBank = [
    Question.name(" На території США знаходяться шість часових поясів.", true),
    Question.name(
        "  США — третя за розмірами країна. Перевершують її "
        "\n лише сусідка — Канада і, зрозуміло, Росія.",
        true),
    Question.name("США гірша за Україну", false),
    Question.name("I like dance", false),
    Question.name(
        " Національна тварина Сполучених Штатів Америки — птах. Це Білоголовий Орел.",
        true),
    Question.name(
        "Корінне населення США — індіанці, не були громадянами цієї країни до 1924 року.",
        true),
    Question.name(
        "На 100-доларовій купюрі зображений Бенджамін Франклін – людина, "
        "\n який не був президентом США.",
        true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("True Citizen",style: TextStyle(fontFamily: "Rowdies"),),
        centerTitle: true,
       // backgroundColor: Colors.blueGrey,
      ),
      //backgroundColor: Colors.blueGrey,
      body: Builder(
        builder: (BuildContext context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "images/flag.png",
                  width: 250,
                  height: 180,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14.5),
                      border: Border.all(
                          color: Colors.blueGrey.shade400,
                          style: BorderStyle.solid)),
                  height: 120,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      questionBank[_currentQuestionsIndex].questionText,
                     // style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      onPressed: () => _prewQuestions(),
                      color: Colors.blueGrey.shade900,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  RaisedButton(
                    onPressed: () => _checkAnswer(true, context),
                    color: Colors.blueGrey.shade900,
                    child: const Text(
                      "True",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _checkAnswer(false, context),
                    color: Colors.blueGrey.shade900,
                    child: const Text(
                      "False",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                      onPressed: () => _nextQuestions(),
                      color: Colors.blueGrey.shade900,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ))
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  _checkAnswer(bool userChoise, BuildContext context) {
    if (userChoise == questionBank[_currentQuestionsIndex].isCorrect) {
      final snackBar = SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
          content: const Text("Correct"));
      Scaffold.of(context).showSnackBar(snackBar);
      _updateQuestions();
      setState(() {
        _currentQuestionsIndex++;
      });

      debugPrint("Yes Correct");
    } else {
      final snackBar = const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 500),
          content: Text("Incorrect"));
      Scaffold.of(context).showSnackBar(snackBar);
      debugPrint("Incorrect");
      _updateQuestions();
    }
  }
  _updateQuestions(){
    setState(() {
      _currentQuestionsIndex =
          (_currentQuestionsIndex + 1) % questionBank.length;
    });
  }

  _nextQuestions() {
   _updateQuestions();
  }

  _prewQuestions() {
    setState(() {
      _currentQuestionsIndex =
          (_currentQuestionsIndex - 1) % questionBank.length;
    });

  }
}
