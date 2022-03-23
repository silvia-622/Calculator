import 'package:flutter/material.dart';
import 'package:calculator/calculator_button_symbol.dart';

class CalculatorButton extends StatelessWidget {

  const CalculatorButton({
    Key? key,
    required this.symbol,
    this.onTap
  }) : super(key: key);

  final CalculatorButtonSymbol symbol;
  final onTap;


  Color get color {
    switch (symbol.type) {
      case 'Equals':
        return Colors.green;
      default:
        return const Color(0xFF212121);
    }
  }

  Color get textColor {
    switch (symbol.type) {
      case 'Number':
        return Colors.white;
      case 'Operation':
        return Colors.green;
      case 'Delete':
        return Colors.red;
      default:
        return Colors.white;
    }
  }


  @override
  Widget build(BuildContext context) {
    //double size = MediaQuery.of(context).size.width / 4;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                symbol.toString(),
                style: TextStyle(
                    color: textColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
