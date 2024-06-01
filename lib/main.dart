import 'package:flutter/material.dart';

void main() {
  runApp(IMCCalculatorApp());
}

class IMCCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IMCCalculator(),
    );
  }
}

class IMCCalculator extends StatefulWidget {
  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _result = "";
  String _selectedGender = "Masculino";

  void _calculateIMC() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      final double imc = weight / (height * height);

      String category;
      if (_selectedGender == "Masculino") {
        category = _getMaleCategory(imc);
      } else {
        category = _getFemaleCategory(imc);
      }

      setState(() {
        _result = "IMC: ${imc.toStringAsFixed(2)}\nCategoria: $category";
      });
    }
  }

  String _getMaleCategory(double imc) {
    if (imc < 20.7) return "Abaixo do peso";
    if (imc < 26.4) return "Peso normal";
    if (imc < 27.8) return "Pouco acima do peso";
    if (imc < 31.1) return "Acima do peso";
    return "Obeso";
  }

  String _getFemaleCategory(double imc) {
    if (imc < 19.1) return "Abaixo do peso";
    if (imc < 25.8) return "Peso normal";
    if (imc < 27.3) return "Pouco acima do peso";
    if (imc < 32.3) return "Acima do peso";
    return "Obesa";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
      ),
      body: Container(
        color: Colors.lightGreenAccent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: "Altura (m)",
                    hintText: "Formato: 0.00",
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [],
                ),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    hintText: "Formato: 0.00",
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [],
                ),
                DropdownButton<String>(
                  value: _selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                  items: <String>["Masculino", "Feminino"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateIMC,
                  child: Text("Calcular"),
                ),
                SizedBox(height: 20),
                Text(
                  _result,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
