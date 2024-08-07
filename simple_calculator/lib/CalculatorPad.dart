import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class CalculatorPad extends StatefulWidget {
  @override
  State<CalculatorPad> createState() => _CalculatorPadState();
}

class _CalculatorPadState extends State<CalculatorPad> {
  String currentEquation = '';
  String previousEquation = '';

  void updateEquation(String text) {
    setState(() {
      currentEquation += text;
    });
  }

  void calculateResult() {
    try {
      final expression = Expression.parse(currentEquation);
      const evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      setState(() {
        previousEquation = currentEquation;
        currentEquation = result.toString();
      });
    } catch (e) {
      setState(() {
        currentEquation = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Calculator',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.grey[900],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      previousEquation,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentEquation,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Table(
                border: TableBorder.all(color: Colors.white, width: 2),
                children: [
                  TableRow(
                    children: [
                      _buildButton('AC', Colors.yellow, Colors.black, () {
                        setState(() {
                          currentEquation = '';
                          previousEquation = '';
                        });
                      }),
                      _buildButton('C', Colors.limeAccent, Colors.black, () {
                        setState(() {
                          previousEquation = '';
                        });
                      }),
                      _buildIconButton(CupertinoIcons.divide, Colors.white, Colors.deepPurple, () {
                        updateEquation('/');
                      }),
                      _buildIconButton(CupertinoIcons.multiply, Colors.white, Colors.deepPurple, () {
                        updateEquation('*');
                      }),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton('7', Colors.white, Colors.black, () {
                        updateEquation('7');
                      }),
                      _buildButton('8', Colors.white, Colors.black, () {
                        updateEquation('8');
                      }),
                      _buildButton('9', Colors.white, Colors.black, () {
                        updateEquation('9');
                      }),
                      _buildIconButton(CupertinoIcons.minus, Colors.white, Colors.deepPurple, () {
                        updateEquation('-');
                      }),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton('4', Colors.white, Colors.black, () {
                        updateEquation('4');
                      }),
                      _buildButton('5', Colors.white, Colors.black, () {
                        updateEquation('5');
                      }),
                      _buildButton('6', Colors.white, Colors.black, () {
                        updateEquation('6');
                      }),
                      _buildIconButton(CupertinoIcons.add, Colors.white, Colors.deepPurple, () {
                        updateEquation('+');
                      }),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton('1', Colors.white, Colors.black, () {
                        updateEquation('1');
                      }),
                      _buildButton('2', Colors.white, Colors.black, () {
                        updateEquation('2');
                      }),
                      _buildButton('3', Colors.white, Colors.black, () {
                        updateEquation('3');
                      }),
                      _buildIconButton(Icons.backspace_outlined, Colors.white, Colors.deepPurple, () {
                        if (currentEquation.isNotEmpty) {
                          setState(() {
                            currentEquation = currentEquation.substring(0, currentEquation.length - 1);
                          });
                        }
                      }),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton('%', Colors.white, Colors.black, () {
                        updateEquation('%');
                      }),
                      _buildButton('0', Colors.white, Colors.black, () {
                        updateEquation('0');
                      }),
                      _buildButton('.', Colors.white, Colors.black, () {
                        updateEquation('.');
                      }),
                      _buildIconButton(CupertinoIcons.equal, Colors.deepPurple, Colors.white, () {
                        calculateResult();
                      })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 40,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color bgColor, Color iconColor, VoidCallback onPressed) {
    return SizedBox(
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 40,
        ),
      ),
    );
  }
}