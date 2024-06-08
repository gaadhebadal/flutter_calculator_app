import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _result = "0";
  String? _operation;
  double? _num1;
  double? _num2;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        _output = "0";
        _result = "0";
        _num1 = null;
        _num2 = null;
        _operation = null;
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "*" || buttonText == "%") {
        if (_output.isNotEmpty) {
          _num1 = double.tryParse(_output);
        }
        _operation = buttonText;
        _output = "0";
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output += buttonText;
        }
      } else if (buttonText == "=") {
        if (_operation != null && _output.isNotEmpty) {
          _num2 = double.tryParse(_output);

          if (_num1 != null && _num2 != null) {
            switch (_operation) {
              case "+":
                _result = (_num1! + _num2!).toString();
                break;
              case "-":
                _result = (_num1! - _num2!).toString();
                break;
              case "*":
                _result = (_num1! * _num2!).toString();
                break;
              case "/":
                if (_num2 != 0) {
                  _result = (_num1! / _num2!).toString();
                } else {
                  _result = "Error";
                }
                break;
              case "%":
                _result = (_num1! % _num2!).toString();
                break;
            }
            _output = _result;
            _num1 = null;
            _num2 = null;
            _operation = null;
          }
        }
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }

      _result = _output;
    });
  }

  Widget buildButton(String buttonText, {Color? color, Color textColor = Colors.white}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[800],
            padding: EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 10.0,
            shadowColor: Colors.black45,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                _result,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: Colors.white),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("/", color: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("*", color: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-", color: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("."),
                    buildButton("0"),
                    buildButton("00"),
                    buildButton("+", color: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("CLEAR", color: Colors.red),
                    buildButton("=", color: Colors.green),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
