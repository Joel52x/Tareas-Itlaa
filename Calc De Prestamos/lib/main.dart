import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoanCalculatorPage(),
    );
  }
}

class LoanCalculatorPage extends StatefulWidget {
  @override
  _LoanCalculatorPageState createState() => _LoanCalculatorPageState();
}

class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _installmentsController = TextEditingController();
  final TextEditingController _annualInterestController =
      TextEditingController();

  double _monthlyInstallment = 0.0;
  List<Map<String, dynamic>> _amortizationTable = [];

  void _calculate() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    int installments = int.tryParse(_installmentsController.text) ?? 0;
    double annualInterest =
        double.tryParse(_annualInterestController.text) ?? 0.0;

    if (amount > 0 && installments > 0 && annualInterest >= 0) {
      double monthlyInterest = annualInterest / 12 / 100;
      _monthlyInstallment = (amount * monthlyInterest) /
          (1 - 1 / pow(1 + monthlyInterest, installments));

      double remainingBalance = amount;
      _amortizationTable.clear();

      for (int i = 1; i <= installments; i++) {
        double interestPayment = remainingBalance * monthlyInterest;
        double principalPayment = _monthlyInstallment - interestPayment;
        remainingBalance -= principalPayment;

        _amortizationTable.add({
          'Cuota': i,
          'Interés': interestPayment,
          'Capital': principalPayment,
          'Saldo': remainingBalance > 0 ? remainingBalance : 0.0,
        });
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Préstamos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Monto del Préstamo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _installmentsController,
              decoration: InputDecoration(
                labelText: 'Número de Cuotas',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _annualInterestController,
              decoration: InputDecoration(
                labelText: 'Tasa de Interés Anual (%)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            if (_monthlyInstallment > 0)
              Text(
                'Cuota Mensual: ${_monthlyInstallment.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
            if (_amortizationTable.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Cuota')),
                      DataColumn(label: Text('Interés')),
                      DataColumn(label: Text('Capital')),
                      DataColumn(label: Text('Saldo')),
                    ],
                    rows: _amortizationTable.map((entry) {
                      return DataRow(cells: [
                        DataCell(Text(entry['Cuota'].toString())),
                        DataCell(Text(entry['Interés'].toStringAsFixed(2))),
                        DataCell(Text(entry['Capital'].toStringAsFixed(2))),
                        DataCell(Text(entry['Saldo'].toStringAsFixed(2))),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
