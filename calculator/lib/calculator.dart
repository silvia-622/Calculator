import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/calculator_button.dart';
import 'package:calculator/calculator_button_symbol.dart';
import 'package:calculator/history.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  final ScrollController _controller = ScrollController();
  List<CalculatorButtonSymbol> queue = [];
  var mathOperation = '';
  var result = '';
  int numberOpenParentheses = 0;
  int numberClosedParentheses = 0;

  // ****************************************************************************************************************
  // This adjusts the font size of the operation result, so when there are many digits, decrease the font size a little
  // ****************************************************************************************************************
  double get fontSizeResult {
    if (result == '=Incorrect format.' || result.length > 15) { return 25; }
    else { return 40; }
  }

  // ****************************************************************************************************************
  // Scroll down in the display where the mathOperation is show
  // This is necessary so that, when the operation is very long, it always shows the user the last symbols he has typed
  // ****************************************************************************************************************
  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 50), () {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
  }

  // ****************************************************************************************************************
  // Updates the state of the calculator, according to the button that was clicked
  // At the end, a scroll is made in the display where the mathOperation is shown
  // ****************************************************************************************************************
  void update(CalculatorButtonSymbol symbol){
    if (result.isNotEmpty) { result = ''; }
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
        parentheses();
        break;
      case 'Operator':
        operator(symbol);
        break;
      case 'Sign':
        sign();
        break;
      default:
        number(symbol);
        break;
    }
    _scrollDown();
  }

  // ****************************************************************************************************************
  // Remove the last symbol from mathOperation and queue
  // If the last symbol is open parentheses or closed parentheses, update the respective number
  // ****************************************************************************************************************
  void removeLastCharacter(){
    mathOperation = mathOperation.substring(0, mathOperation.length - 1);
    if (queue.last == Buttons.openParentheses) { numberOpenParentheses -= 1; }
    if (queue.last == Buttons.closedParentheses) { numberClosedParentheses -= 1; }
    queue.removeLast();
  }

  void reset() {
    mathOperation = '';
    result = '';
    numberOpenParentheses = 0;
    numberClosedParentheses = 0;
    queue.clear();
  }

  // ****************************************************************************************************************
  // Add calculator symbol to mathOperation and queue
  // If the last symbol is open parentheses or closed parentheses, update the respective number
  // ****************************************************************************************************************
  void addToMathOperation(CalculatorButtonSymbol symbol){
    mathOperation += symbol.value;
    queue.add(symbol);
    if (symbol == Buttons.openParentheses) { numberOpenParentheses += 1; }
    if (symbol == Buttons.closedParentheses) { numberClosedParentheses += 1; }
  }

  // ****************************************************************************************************************
  // Checks if the number of open parentheses is equal to the number of closed parentheses
  // If the numbers are different, the number of missing closed parentheses is automatically added
  // This is necessary, if the user forgets to close any parentheses, the system closes them to avoid errors
  // ****************************************************************************************************************
  void verifyParentheses() {
    if (numberOpenParentheses != numberClosedParentheses) {
      int difference = numberOpenParentheses - numberClosedParentheses;
      for(var i = 0; i < difference; i++) {
        addToMathOperation(Buttons.closedParentheses);
      }
    }
  }

  // ****************************************************************************************************************
  // Solve the math operation
  // If the math operation is in an incorrect format, the result will be '=Incorrect format.'
  // ****************************************************************************************************************
  void checked() {
    verifyParentheses();
    String finalQuestion = mathOperation;
    finalQuestion = finalQuestion.replaceAll('×', '*');
    finalQuestion = finalQuestion.replaceAll('÷', '/');
    try {
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      String auxResult = eval.toString();
      (auxResult.substring(auxResult.length - 2, auxResult.length) == '.0') ?
      result = '=' + auxResult.substring(0, auxResult.length - 2) : result = '=' + auxResult ;
      if(result == '=-0'){ result = '=0';}
      History.addToHistory(mathOperation, result);
    } catch (e) {
      result = '=Incorrect format.';
    }
  }

  // ****************************************************************************************************************
  // Add the open or closed parentheses according to the current state of mathOperation

  // The OPEN parentheses are added in any of the following situations:
  //    * The last symbol entered is of type Number and the number of open and closed parentheses is EQUAL
  //          (in this case also add the multiplication symbol before the parentheses)
  //    * The last symbol entered is a closed parentheses and the number of open and closed parentheses is EQUAL
  //          (in this case also add the multiplication symbol before the parentheses)
  //    * The last symbol entered is an open parentheses
  //    * The last symbol entered is of type Operator (+;-;x;/)
  //    * The math operation is empty

  // The CLOSED parentheses are added in any of the following situations:
  //    * The last symbol entered is of type Number and the number of open and closed parentheses is DIFFERENT
  //    * The last symbol entered is a closed parentheses and the number of open and closed parenthesis is DIFFERENT
  // ****************************************************************************************************************
  void parentheses() {
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

  // ****************************************************************************************************************
  // Add an operator (+;-;x;/) to math operation
  // ****************************************************************************************************************
  void operator(CalculatorButtonSymbol symbol) {
    if (queue.isNotEmpty){
      switch (queue.last.type) {
        // if last symbol entered was an operator:
        // if the penultimate symbol entered was not a open parentheses OR
        // the penultimate symbol entered was an open parentheses and the symbol to be entered is a subtract
        // replace the last operator with the new
        case 'Operator':
          CalculatorButtonSymbol penultimateSymbol = queue[queue.length - 2];
          if (penultimateSymbol != Buttons.openParentheses || (penultimateSymbol == Buttons.openParentheses && symbol == Buttons.subtract)){
            removeLastCharacter();
            addToMathOperation(symbol);
          }
          break;
        // if last symbol entered was an Parentheses:
        // only add the operator if the last symbol is a open parentheses and the symbol to be entered is a subtract OR
        // if the last symbol is a closed parentheses
        case 'Parentheses':
          if ((queue.last == Buttons.openParentheses && symbol == Buttons.subtract) || queue.last == Buttons.closedParentheses) {
            addToMathOperation(symbol);
          }
          break;
        // if the last symbol is a Number, just add the operator:
        default:
          addToMathOperation(symbol);
          break;
      }
    }
  }

  // ****************************************************************************************************************
  // Change the sign of the last number entered on the math operation - AUX METHOD
  // ****************************************************************************************************************
  void changeSignOfLastNumber (bool positiveSign, List<CalculatorButtonSymbol> number) {
    // 1st remove the last number (without sign) from mathOperation
    for(var j=number.length-1; j >= 0; j--) {
      removeLastCharacter();
    }
    // If the current number is positive, add to mathOperation open parentheses and the subtract operator to make the number negative
    if (positiveSign) {
      addToMathOperation(Buttons.openParentheses);
      addToMathOperation(Buttons.subtract);
    }
    // If the current number is negative, remove the open parentheses and the subtract operator from mathOperation (last two symbols)
    else {
      removeLastCharacter();
      removeLastCharacter();
    }
    // At the end, re-enter the number in mathOperation
    for(var j=number.length-1; j >= 0; j--) {
      addToMathOperation(number[j]);
    }
  }

  // ****************************************************************************************************************
  // Change the sign of the last number entered on the math operation
  // A number is considered negative if in its left have the symbols: open parentheses and the operator subtract
  // If the mathOperation is empty OR the last symbol entered was an open parentheses, just add open parentheses and subtract, because when there is no number, the number is considered positive
  // If the last symbol entered was a closed parentheses the result will be automatically '=Incorrect format.'
  // ****************************************************************************************************************
  void sign () {
    if (queue.isEmpty || queue.last == Buttons.openParentheses){
      addToMathOperation(Buttons.openParentheses);
      addToMathOperation(Buttons.subtract);
    } else if (queue.last == Buttons.closedParentheses) {
      result = '=Incorrect format.';
    } else {
      List<CalculatorButtonSymbol> number = [];
      var index = 0;
      for(var i=queue.length-1; i >= 0; i--) {
        if (queue[i].type == 'Number') {
          number.add(queue[i]);
        } else {
          index = i;
          break;
        }
      }
      if (queue[index] == Buttons.subtract && queue[index-1] == Buttons.openParentheses) {
        changeSignOfLastNumber(false, number);
      } else {
        changeSignOfLastNumber(true, number);
      }
    }
  }

  // ****************************************************************************************************************
  // Add a number to math operation
  // If the last symbol entered was a closed parentheses, also add the multiply operator
  // (because when the operator is not specified, it is assumed that the operator is a multiplication operator)
  // Otherwise, just add the number
  // ****************************************************************************************************************
  void number (CalculatorButtonSymbol symbol) {
    if (queue.isNotEmpty && queue.last == Buttons.closedParentheses) {
      addToMathOperation(Buttons.multiply);
      addToMathOperation(symbol);
    } else {
      addToMathOperation(symbol);
    }
  }

  goToHistory(BuildContext context) async {
    await Navigator.push( context, MaterialPageRoute(builder: (context) => const History()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'images/calculator.png',
                height: 32,
              ),
              const Text(' Calculator')
            ],
          ),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => {goToHistory(context)},
            ),
            // add more IconButton
          ],
        ),
        backgroundColor: Colors.black,
        body: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(children: [
                    Expanded(
                      flex: 4,
                      child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          controller: _controller,
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              mathOperation,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            );
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      alignment: Alignment.centerRight,
                      child: Text(result,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeResult,
                          )),
                    ),
                  ])
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
}