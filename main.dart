import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "⌫") {
      if (_output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else {
        _output = "0";
      }
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      _output += buttonText;
    }

    setState(() {
      output = double.parse(_output).toString();
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4), // gap between buttons
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // slight curve
              side: const BorderSide(color: Colors.white, width: 1), // solid border
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const Expanded(child: Divider(color: Colors.white)),
          Column(
            children: [
              Row(children: [
                buildButton("7", Colors.grey.shade800),
                buildButton("8", Colors.grey.shade800),
                buildButton("9", Colors.grey.shade800),
                buildButton("÷", Colors.orange),
              ]),
              Row(children: [
                buildButton("4", Colors.grey.shade800),
                buildButton("5", Colors.grey.shade800),
                buildButton("6", Colors.grey.shade800),
                buildButton("×", Colors.orange),
              ]),
              Row(children: [
                buildButton("1", Colors.grey.shade800),
                buildButton("2", Colors.grey.shade800),
                buildButton("3", Colors.grey.shade800),
                buildButton("-", Colors.orange),
              ]),
              Row(children: [
                buildButton(".", Colors.grey.shade800),
                buildButton("0", Colors.grey.shade800),
                buildButton("00", Colors.grey.shade800),
                buildButton("+", Colors.orange),
              ]),
              Row(children: [
                buildButton("CLEAR", Colors.red),
                buildButton("⌫", Colors.grey.shade600),
                buildButton("=", Colors.green),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
