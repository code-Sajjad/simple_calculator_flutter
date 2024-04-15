import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator_day1/constant/const.dart';
import 'package:simple_calculator_day1/widgets/button_widget.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String userInput = '';
  String result = '';

  @override
  Widget build(BuildContext context) {
    final calculatorData = CalculatorData();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Color(0xffC0DD0E),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: calculatorData.buttonList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                final button = calculatorData.buttonList[index];
                if (button == 'AC') {
                  return ButtonWidget(
                    buttonPressed: () {
                      setState(() {
                        userInput = '';
                        result = '';
                      });
                    },
                    text: button,
                  );
                } else if (button == 'DEL') {
                  return ButtonWidget(
                    buttonPressed: () {
                      setState(() {
                        userInput = userInput.isEmpty
                            ? ''
                            : userInput.substring(0, userInput.length - 1);
                      });
                    },
                    text: button,
                  );
                } else {
                  return ButtonWidget(
                    buttonPressed: button == '='
                        ? equalPressed
                        : () {
                            setState(() {
                              userInput += button;
                            });
                          },
                    text: button,
                    buttonColor:
                        isOperator(button) ? Color(0xffC0DD0E) : Colors.white,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void equalPressed() {
    final input = userInput;
    Parser p = Parser();
    Expression exp = p.parse(input);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      result = eval.toString();
    });
  }

  bool isOperator(String x) {
    if (x == '=' || x == '/' || x == '*' || x == '-' || x == '+') {
      return true;
    }
    return false;
  }
}
