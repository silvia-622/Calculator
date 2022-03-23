import 'package:calculator/calculator_button_symbol.dart';

abstract class Buttons {

  //Operations
  static CalculatorButtonSymbol add = const CalculatorButtonSymbol('+','Operation');
  static CalculatorButtonSymbol subtract = const CalculatorButtonSymbol('-','Operation');
  static CalculatorButtonSymbol divide = const CalculatorButtonSymbol('/','Operation');
  static CalculatorButtonSymbol multiply = const CalculatorButtonSymbol('x','Operation');
  static CalculatorButtonSymbol parentheses = const CalculatorButtonSymbol('( )','Operation');
  static CalculatorButtonSymbol clean = const CalculatorButtonSymbol('<=','Operation');

  //Delete
  static CalculatorButtonSymbol delete = const CalculatorButtonSymbol('C','Delete');

  //Equals
  static CalculatorButtonSymbol equals = const CalculatorButtonSymbol('=','Equals');

  //Numbers
  static CalculatorButtonSymbol zero = const CalculatorButtonSymbol('0','Number');
  static CalculatorButtonSymbol one = const CalculatorButtonSymbol('1','Number');
  static CalculatorButtonSymbol two = const CalculatorButtonSymbol('2','Number');
  static CalculatorButtonSymbol three = const CalculatorButtonSymbol('3','Number');
  static CalculatorButtonSymbol four = const CalculatorButtonSymbol('4','Number');
  static CalculatorButtonSymbol five = const CalculatorButtonSymbol('5','Number');
  static CalculatorButtonSymbol six = const CalculatorButtonSymbol('6','Number');
  static CalculatorButtonSymbol seven = const CalculatorButtonSymbol('7','Number');
  static CalculatorButtonSymbol eight = const CalculatorButtonSymbol('8','Number');
  static CalculatorButtonSymbol nine = const CalculatorButtonSymbol('9','Number');
  static CalculatorButtonSymbol sign = const CalculatorButtonSymbol('+/-','Number');
}