import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/calculator_button.dart';
import 'package:calculator/calculator_buttons_symbols.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var mathOperation = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [



                  Container(
                      height: 140,
                      child: Column(children: [
                        Expanded(
                          child: ListView.builder(
                              //controller: _controller,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  "question",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 60,
                                  ),
                                );
                              }
                          ),
                        )
                      ]
                      )),

                  Container(
                    //color: Colors.green,
                    alignment: Alignment.centerRight,
                    child: Text("answers",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                        )),
                  ),
                ],
              ),
            ),


            Expanded(
              child: Row(
                children: [
                  Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.delete),),
                  Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.divide),),
                  Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.multiply),),
                  Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.clean),),
                ]),
            ),


            Expanded(
              child: Row(
                  children: [
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.seven),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.eight),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.nine),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.subtract),),
                  ]),
            ),

            Expanded(
              child: Row(
                  children: [
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.four),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.five),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.six),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.add),),
                  ]),
            ),

            Expanded(
              child: Row(
                  children: [
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.one),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.two),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.three),),
                    Expanded(child: CalculatorButton(symbol: CalculatorButtonsSymbols.parentheses),),
                  ]),
            ),
            Expanded(
              child: Row(
                  children: [
                    Expanded(flex: 50, child: CalculatorButton(symbol: CalculatorButtonsSymbols.zero),),
                    Expanded(flex: 25, child: CalculatorButton(symbol: CalculatorButtonsSymbols.sign),),
                    Expanded(flex: 25, child: CalculatorButton(symbol: CalculatorButtonsSymbols.equals),),
                  ]),
            ),
          ]
        )
    );
  }
}

