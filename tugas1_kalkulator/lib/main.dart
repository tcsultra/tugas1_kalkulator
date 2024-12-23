import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0";
  String _input = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  bool isDecimal = false;

  // Format number to remove trailing zeros after decimal
  String formatNumber(double number) {
    String numberStr = number.toString();
    if (numberStr.contains('.')) {
      // Remove trailing zeros after decimal
      numberStr = numberStr.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
    }
    return numberStr;
  }

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _input = "";
      num1 = 0;
      num2 = 0;
      operand = "";
      isDecimal = false;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      num1 = double.parse(_output);
      operand = buttonText;
      _input = formatNumber(num1) + buttonText;
      _output = "0";
      isDecimal = false;
    } else if (buttonText == ".") {
      if (!isDecimal) {
        if (_output == "0") {
          _output = "0.";
        } else {
          _output = _output + ".";
        }
        isDecimal = true;
        _input = _input + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      double result = 0;

      if (operand == "+") {
        result = num1 + num2;
      } else if (operand == "-") {
        result = num1 - num2;
      } else if (operand == "×") {
        result = num1 * num2;
      } else if (operand == "÷") {
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          _output = "Error";
          _input = "";
          num1 = 0;
          num2 = 0;
          operand = "";
          isDecimal = false;
          setState(() {});
          return;
        }
      }

      _output = formatNumber(result);
      _input = "";
      num1 = result;
      num2 = 0;
      operand = "";
      isDecimal = _output.contains('.');
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
      _input = _input + buttonText;
    }

    setState(() {});
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                numberButton(buttonText) ? Colors.white : Colors.orange,
            padding: EdgeInsets.all(24.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              color: numberButton(buttonText) ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  bool numberButton(String x) {
    if (x == "+" || x == "-" || x == "×" || x == "÷" || x == "=") {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Flutter'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                _input,
                style: TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("÷"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("×"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("."),
                    buildButton("0"),
                    buildButton("C"),
                    buildButton("+"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("="),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
