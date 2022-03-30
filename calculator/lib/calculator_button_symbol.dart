abstract class Buttons {
  //Operators
  static CalculatorButtonSymbol add = const CalculatorButtonSymbol('+','Operator');
  static CalculatorButtonSymbol subtract = const CalculatorButtonSymbol('-','Operator');
  static CalculatorButtonSymbol divide = const CalculatorButtonSymbol('÷','Operator');
  static CalculatorButtonSymbol multiply = const CalculatorButtonSymbol('x','Operator');
  //Parentheses
  static CalculatorButtonSymbol parentheses = const CalculatorButtonSymbol('( )','Parentheses');
  static CalculatorButtonSymbol openParentheses = const CalculatorButtonSymbol('(','Parentheses');
  static CalculatorButtonSymbol closedParentheses = const CalculatorButtonSymbol(')','Parentheses');
  //Clean
  static CalculatorButtonSymbol clean = const CalculatorButtonSymbol('⌫','Clean');
  //Delete
  static CalculatorButtonSymbol delete = const CalculatorButtonSymbol('C','Delete');
  //Equals
  static CalculatorButtonSymbol equals = const CalculatorButtonSymbol('=','Equals');
  //Sign
  static CalculatorButtonSymbol sign = const CalculatorButtonSymbol('+/-','Sign');
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
}

class CalculatorButtonSymbol {

  const CalculatorButtonSymbol(this.value, this.type);
  final String value;
  final String type;

  @override
  String toString() => value;

  String getType() => type;

}