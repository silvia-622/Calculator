import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/calculator_button.dart';
import 'package:calculator/calculator_button_symbol.dart';


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

  final ScrollController _controller = ScrollController();
  List<CalculatorButtonSymbol> queue = [];
  var mathOperation = '';
  var result = '';
  int numberOpenParentheses = 0;
  int numberClosedParentheses = 0;


  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text(widget.title),
        ),*/
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
                              controller: _controller,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  mathOperation,
                                  style: const TextStyle(
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
                    child: Text(result,
                        style: const TextStyle(
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
                  Expanded(child: CalculatorButton(symbol: Buttons.delete, onTap:(){ setState(() => update(Buttons.delete)); })),
                  Expanded(child: CalculatorButton(symbol: Buttons.divide, onTap:(){ setState(() => update(Buttons.divide)); })),
                  Expanded(child: CalculatorButton(symbol: Buttons.multiply, onTap:(){ setState(() => update(Buttons.multiply)); })),
                  Expanded(child: CalculatorButton(symbol: Buttons.clean, onTap:(){ setState(() => update(Buttons.clean)); })),
                ]),
            ),


            Expanded(
              child: Row(
                  children: [
                    Expanded(child: CalculatorButton(symbol: Buttons.seven, onTap:(){ setState(() => update(Buttons.seven)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.eight, onTap:(){ setState(() => update(Buttons.eight)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.nine, onTap:(){ setState(() => update(Buttons.nine)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.subtract, onTap:(){ setState(() => update(Buttons.subtract)); })),
                  ]),
            ),

            Expanded(
              child: Row(
                  children: [
                    Expanded(child: CalculatorButton(symbol: Buttons.four, onTap:(){ setState(() => update(Buttons.four)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.five, onTap:(){ setState(() => update(Buttons.five)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.six, onTap:(){ setState(() => update(Buttons.six)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.add, onTap:(){ setState(() => update(Buttons.add)); })),
                  ]),
            ),

            Expanded(
              child: Row(
                  children: [
                    Expanded(child: CalculatorButton(symbol: Buttons.one, onTap:(){ setState(() => update(Buttons.one)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.two, onTap:(){ setState(() => update(Buttons.two)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.three, onTap:(){ setState(() => update(Buttons.three)); })),
                    Expanded(child: CalculatorButton(symbol: Buttons.parentheses, onTap:(){ setState(() => update(Buttons.parentheses)); })),
                  ]),
            ),
            Expanded(
              child: Row(
                  children: [
                    Expanded(flex: 50, child: CalculatorButton(symbol: Buttons.zero, onTap:(){ setState(() => update(Buttons.zero)); })),
                    Expanded(flex: 25, child: CalculatorButton(symbol: Buttons.sign, onTap:(){ setState(() => update(Buttons.sign)); })),
                    Expanded(flex: 25, child: CalculatorButton(symbol: Buttons.equals, onTap:(){ setState(() => update(Buttons.equals)); })),
                  ]),
            ),
          ]
        )
    );
  }

  void update(CalculatorButtonSymbol symbol){
    switch (symbol.type) {
      case 'Clean':
        removeLastCharacter();
        break;
      case 'Delete':
        reset();
        break;
      case 'Equals':
        checked();
        break;
      case 'Parentheses':
        parentheses(symbol);
        break;
      case 'Operator':
        operator(symbol);
        break;
      default:
        number(symbol);
        break;
    }
    print(queue);
    print('OPEN: ' + numberOpenParentheses.toString());
    print('CLOSED: ' + numberClosedParentheses.toString());
    _scrollDown();
  }

  void number (CalculatorButtonSymbol symbol) {
    if (queue.isNotEmpty && queue.last == Buttons.closedParentheses) {
      addToMathOperation(Buttons.multiply);
      addToMathOperation(symbol);
    } else {
      addToMathOperation(symbol);
    }
  }

  void parentheses(CalculatorButtonSymbol symbol) {
    // If the type of the last symbol is 'Number':
    if (queue.isNotEmpty && queue.last.type == 'Number') {
      if (numberOpenParentheses == numberClosedParentheses) {
        addToMathOperation(Buttons.multiply);
        addToMathOperation(Buttons.openParentheses);
      }
      else {
        addToMathOperation(Buttons.closedParentheses);
      }
    }
    // If the type of the last symbol is 'Parentheses':
    else if (queue.isNotEmpty && queue.last.type == 'Parentheses') {
      if (queue.last == Buttons.openParentheses) {
        addToMathOperation(Buttons.openParentheses);
      } else {
        if (numberOpenParentheses > numberClosedParentheses) {
          addToMathOperation(Buttons.closedParentheses);
        } else {
          addToMathOperation(Buttons.multiply);
          addToMathOperation(Buttons.openParentheses);
        }
      }
    }
    // If the queue is empty or if the type of the last symbol is 'Operator':
    else {
      addToMathOperation(Buttons.openParentheses);
    }
  }

  void operator(CalculatorButtonSymbol symbol) {
    if (queue.isNotEmpty){
      switch (queue.last.type) {
        case 'Operator':
          CalculatorButtonSymbol penultimateSymbol = queue[queue.length - 2];
          if (penultimateSymbol != Buttons.openParentheses || (penultimateSymbol == Buttons.openParentheses && symbol == Buttons.subtract)){
            removeLastCharacter();
            addToMathOperation(symbol);
          }
          break;
        case 'Parentheses':
          if ((queue.last == Buttons.openParentheses && symbol == Buttons.subtract) || queue.last == Buttons.closedParentheses) {
            addToMathOperation(symbol);
          }
          break;
        default:
          addToMathOperation(symbol);
          break;
      }
    }
  }

  void removeLastCharacter(){
    mathOperation = mathOperation.substring(0, mathOperation.length - 1);
    if (queue.last == Buttons.openParentheses) { numberOpenParentheses -= 1; }
    if (queue.last == Buttons.closedParentheses) { numberClosedParentheses -= 1; }
    queue.removeLast();
  }

  void addToMathOperation(CalculatorButtonSymbol symbol){
    mathOperation += symbol.value;
    queue.add(symbol);
    if (symbol == Buttons.openParentheses) { numberOpenParentheses += 1; }
    if (symbol == Buttons.closedParentheses) { numberClosedParentheses += 1; }
  }

  void verifyParentheses() {
    if (numberOpenParentheses != numberClosedParentheses) {
      int difference = numberOpenParentheses - numberClosedParentheses;
      for(var i = 0; i < difference; i++) {
        addToMathOperation(Buttons.closedParentheses);
      }
    }
  }

  void reset() {
    mathOperation = '';
    result = '';
    numberOpenParentheses = 0;
    numberClosedParentheses = 0;
    queue.clear();
  }

  void checked() {
    verifyParentheses();
    String finalQuestion = mathOperation;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    String auxResult = eval.toString();
    (auxResult.substring(auxResult.length - 2, auxResult.length) == '.0') ?
    result = auxResult.substring(0, auxResult.length - 2) : result = auxResult;
  }
}

