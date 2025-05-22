
// Flutter BMI Calculator: Complete copy-paste code

import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.indigo[50],
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo, width: 2),
          ),
        ),

      ),
      home: BMICalculatorPage(),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _bmi;
  String _category = '';

  void _calculateBMI() {
    final String weightText = _weightController.text;
    final String heightText = _heightController.text;

    if (weightText.isEmpty || heightText.isEmpty) {
      _showErrorDialog('Please enter both weight and height.');
      return;
    }

    final double? weight = double.tryParse(weightText);
    final double? heightCm = double.tryParse(heightText);

    if (weight == null || heightCm == null || weight <= 0 || heightCm <= 0) {
      _showErrorDialog('Please enter valid positive numbers for weight and height.');
      return;
    }

    final heightM = heightCm / 100;
    final bmi = weight / (heightM * heightM);

    String category;
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 24.9) {
      category = 'Normal weight';
    } else if (bmi < 29.9) {
      category = 'Overweight';
    } else {
      category = 'Obesity';
    }

    setState(() {
      _bmi = bmi;
      _category = category;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Input Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Calculate Your Body Mass Index',
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                prefixIcon: Icon(Icons.fitness_center),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                prefixIcon: Icon(Icons.height),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('Calculate'),
            ),
            SizedBox(height: 40),
            if (_bmi != null)
              Column(
                children: [
                  Text(
                    'Your BMI is',
                    style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _bmi!.toStringAsFixed(2),
                    style: textTheme.headlineMedium!.copyWith(
                      color: Colors.indigo[700],
                      fontSize: 48,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    _category,
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _categoryColor(_category),
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.orange;
      case 'Normal weight':
        return Colors.green;
      case 'Overweight':
        return Colors.amber;
      case 'Obesity':
        return Colors.redAccent;
      default:
        return Colors.black;
    }
  }
}