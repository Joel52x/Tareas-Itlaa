import 'package:flutter/material.dart';

void main() {
  runApp(InventoryDashboard());
}

class InventoryDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> inventory = [
    {'name': 'Peras', 'quantity': 154, 'price': 35.0, 'color': Colors.white},
    {
      'name': 'Zanahorias',
      'quantity': 673,
      'price': 25.0,
      'color': Colors.white
    },
    {'name': 'Manzanas', 'quantity': 999, 'price': 45.0, 'color': Colors.white},
  ];

  void _addItem(String name, int quantity, double price) {
    setState(() {
      inventory.add({
        'name': name,
        'quantity': quantity,
        'price': price,
        'color': Colors.white,
      });
    });
  }

  void _editItem(
      int index, String name, int quantity, double price, Color color) {
    setState(() {
      inventory[index] = {
        'name': name,
        'quantity': quantity,
        'price': price,
        'color': color,
      };
    });
  }

  void _deleteItem(int index) {
    setState(() {
      inventory.removeAt(index);
    });
  }

  void _showAddItemDialog() {
    String name = '';
    int quantity = 0;
    double price = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                onChanged: (value) => quantity = int.parse(value),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = double.parse(value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _addItem(name, quantity, price);
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInventoryList() {
    return ListView.builder(
      itemCount: inventory.length,
      itemBuilder: (context, index) {
        final item = inventory[index];
        return Card(
          color: item['color'],
          child: ListTile(
            title: Text(item['name']),
            subtitle: Text(
                'Cantidad: ${item['quantity']} - Precio: \$${item['price']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditItemDialog(index, item);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteItem(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditItemDialog(int index, Map<String, dynamic> currentItem) {
    String name = currentItem['name'];
    int quantity = currentItem['quantity'];
    double price = currentItem['price'];
    Color selectedColor = currentItem['color'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre'),
                controller: TextEditingController(text: name),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: quantity.toString()),
                onChanged: (value) => quantity = int.parse(value),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: price.toString()),
                onChanged: (value) => price = double.parse(value),
              ),
              DropdownButton<Color>(
                value: selectedColor,
                items: [
                  DropdownMenuItem(
                    value: Colors.red,
                    child: Text('Rojo'),
                  ),
                  DropdownMenuItem(
                    value: Colors.yellow,
                    child: Text('Amarillo'),
                  ),
                  DropdownMenuItem(
                    value: Colors.green,
                    child: Text('Verde'),
                  ),
                  DropdownMenuItem(
                    value: Colors.white,
                    child: Text('Blanco'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedColor = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _editItem(index, name, quantity, price, selectedColor);
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard de Inventario'),
      ),
      body: _buildInventoryList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddItemDialog,
      ),
    );
  }
}
