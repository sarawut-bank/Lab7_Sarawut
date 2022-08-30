import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = "0";
  String expression = "";
  buttonPressed(String value) {
    print(value);

    setState(() {
      if (value == "CLEAR") {
        result = "0";
      } else if (value == ".") {
        if (result.contains(".")) {
          return;
        } else {
          result = result + value;
        }
      } else if (value == "=") {
        expression = result.replaceAll("x", "*");

        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        dynamic calculate = exp.evaluate(EvaluationType.REAL, cm);

        result = "$calculate";
      } else {
        if (result == "0") {
          result = value;
        } else {
          result = result + value;
        }
      }
    });
  }

  Widget myButton(String buttonLabel) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonLabel),
        child: Text(
          buttonLabel,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Simple Calculator"),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              alignment: Alignment.center,
              child: Text(
                result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Image(
                    image: NetworkImage(
                        'https://teen.mthai.com/app/uploads/2018/07/%E0%B8%81%E0%B8%A7%E0%B8%B4%E0%B8%99-%E0%B9%82%E0%B8%97%E0%B8%A1%E0%B8%B1%E0%B8%AA-14.jpg'))),
            Column(
              children: [
                Row(
                  children: [
                    myButton("7"),
                    myButton("8"),
                    myButton("9"),
                    myButton("/"),
                  ],
                ),
                Row(
                  children: [
                    myButton("4"),
                    myButton("5"),
                    myButton("6"),
                    myButton("x"),
                  ],
                ),
                Row(
                  children: [
                    myButton("1"),
                    myButton("2"),
                    myButton("3"),
                    myButton("-"),
                  ],
                ),
                Row(
                  children: [
                    myButton("."),
                    myButton("0"),
                    myButton("00"),
                    myButton("+"),
                  ],
                ),
                Row(
                  children: [
                    myButton("CLEAR"),
                    myButton("="),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
