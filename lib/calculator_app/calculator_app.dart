import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorNotifier>(
      create: (context) => CalculatorNotifier(),
      child: Builder(
        builder: (context) {
          final calculatorNotifier = Provider.of<CalculatorNotifier>(context);
          return Scaffold(
            appBar: AppBar(title: Text('Calculator')),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    calculatorNotifier.currentNumber,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Spacer(),
                  SizedBox(
                    height: 400,
                    child: GridView.count(
                      crossAxisCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        for (var button in calculatorButtons)
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              button.value,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

abstract class CalculatorVariable {
  CalculatorVariable({this.value});

  final String value;
}

abstract class MathOperator {}

class CalculatorNumber extends CalculatorVariable {
  final String value;
  CalculatorNumber(this.value);
}

class CalculatorAdd extends CalculatorVariable with MathOperator {
  String value = '+';
}

class CalculatorSubtract extends CalculatorVariable with MathOperator {
  String value = '-';
}

class CalculatorDivide extends CalculatorVariable with MathOperator {
  String value = '/';
}

class CalculatorMultiply extends CalculatorVariable with MathOperator {
  String value = '*';
}

final calculatorButtons = [
  CalculatorNumber('1'),
  CalculatorNumber('2'),
  CalculatorNumber('3'),
  CalculatorDivide(),
  CalculatorNumber('4'),
  CalculatorNumber('5'),
  CalculatorNumber('6'),
  CalculatorMultiply(),
  CalculatorNumber('7'),
  CalculatorNumber('8'),
  CalculatorNumber('9'),
  CalculatorSubtract(),
  CalculatorNumber('.'),
  CalculatorNumber('0'),
  CalculatorNumber('='),
  CalculatorAdd(),
];

class CalculatorNotifier extends ChangeNotifier {
  int firstNumber;
  MathOperator mathOperator;
  int secondNumber;
  String currentNumber = '0';
  handleCalculatorUpdate(List<CalculatorVariable> actions) {}
}
