import 'package:flutter/material.dart';
import 'package:calculator/calculator_button_symbol.dart';

class CalculatorButton extends StatelessWidget {

  const CalculatorButton({
    Key? key,
    required this.symbol,
    required this.onTap
  }) : super(key: key);

  final CalculatorButtonSymbol symbol;
  final dynamic onTap;

  Color get textColor {

    if (symbol.type == 'Number' || symbol.type == 'Equals' || symbol.type == 'Sign'){
      return Colors.white;
    } else if (symbol.type == 'Delete') {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      hoverColor: (symbol.type == 'Equals') ? Colors.green : const Color(0xFF212121),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            color: (symbol.type == 'Equals') ? Colors.green : const Color(0xFF212121),
            child: Center(
              child: Text(
                symbol.toString(),
                style: TextStyle(
                    color: textColor,
                    fontSize: (symbol.type == 'Operator' || symbol.type == 'Equals') ? 34 : 28,
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

