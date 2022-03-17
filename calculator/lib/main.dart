import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:spannable_grid/spannable_grid.dart';
import 'package:calculator/calculator_button.dart';

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
                  children: [
                  SizedBox(
                      height: 140,
                      child: Column(children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  mathOperation,
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 30,
                                  ),
                                );
                              }),
                        )
                      ])),

                    Container(
                      color: Colors.black,
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
            child: SpannableGrid(
              columns: 4,
              rows: 5,
              cells: [
                SpannableGridCellData(
                    id: 0,
                    column: 1,
                    row: 1,
                    child: CalculatorButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      buttonText: 'C',
                    )
                ),
                SpannableGridCellData(
                    id: 1,
                    column: 1,
                    row: 2,
                    child: CalculatorButton(
                      color: Color(0xFF212121),
                      textColor: Colors.white,
                      buttonText: '7',
                    )
                ),
                SpannableGridCellData(
                    id: 2,
                    column: 1,
                    row: 3,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '4',
                    )
                ),
                SpannableGridCellData(
                    id: 3,
                    column: 1,
                    row: 4,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '1',
                    )
                ),
                SpannableGridCellData(
                    id: 15,
                    column: 1,
                    row: 5,
                    columnSpan: 2,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '0',
                    )
                ),
                SpannableGridCellData(
                    id: 4,
                    column: 2,
                    row: 1,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.green,
                      buttonText: '/',
                    )
                ),
                SpannableGridCellData(
                    id: 5,
                    column: 2,
                    row: 2,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '8',
                    )
                ),
                SpannableGridCellData(
                    id: 6,
                    column: 2,
                    row: 3,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '5',
                    )
                ),
                SpannableGridCellData(
                    id: 7,
                    column: 2,
                    row: 4,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '2',
                    )
                ),
                SpannableGridCellData(
                    id: 8,
                    column: 3,
                    row: 1,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.green,
                      buttonText: 'X',
                    )
                ),
                SpannableGridCellData(
                    id: 9,
                    column: 3,
                    row: 2,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '9',
                    )
                ),
                SpannableGridCellData(
                    id: 10,
                    column: 3,
                    row: 3,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '6',
                    )
                ),
                SpannableGridCellData(
                    id: 11,
                    column: 3,
                    row: 4,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '3',
                    )
                ),
                SpannableGridCellData(
                    id: 12,
                    column: 3,
                    row: 5,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      buttonText: '+/-',
                    )
                ),
                SpannableGridCellData(
                    id: 13,
                    column: 4,
                    row: 1,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.green,
                      buttonText: '<x=',
                    )
                ),
                SpannableGridCellData(
                    id: 14,
                    column: 4,
                    row: 2,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.green,
                      buttonText: '-',
                    )
                ),
                SpannableGridCellData(
                    id: 16,
                    column: 4,
                    row: 3,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.green,
                      buttonText: '+',
                    )
                ),
                SpannableGridCellData(
                    id: 17,
                    column: 4,
                    row: 4,
                    child: CalculatorButton(
                      color: Colors.grey,
                      textColor: Colors.green,
                      buttonText: '()',
                    )
                ),
                SpannableGridCellData(
                    id: 18,
                    column: 4,
                    row: 5,
                    child: CalculatorButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      buttonText: '=',
                    )
                )
              ],
            ),
          )
        ])
    );
  }
}

