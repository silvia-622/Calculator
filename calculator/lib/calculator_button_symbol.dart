import 'package:flutter/material.dart';

class CalculatorButtonSymbol {

  const CalculatorButtonSymbol(this.value, this.type);
  final String value;
  final String type;

  @override
  String toString() => value;

  String getType() => type;

}