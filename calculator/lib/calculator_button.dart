import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {

  const CalculatorButton({
    Key? key,
    this.color,
    this.textColor,
    this.buttonText,
    this.onTap
  }) : super(key: key);


  final color;
  final textColor;
  final  buttonText;
  final onTap;
  final border = 50.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(border),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
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
