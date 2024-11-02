import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarjeta de Presentación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BusinessCard(),
    );
  }
}

class BusinessCard extends StatefulWidget {
  const BusinessCard({super.key});

  @override
  _BusinessCardState createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  int likeCount = 22;

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjeta de Presentación'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Foto de perfil
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/fdp.jpg'),
                ),
                const SizedBox(height: 16.0),
                // Texto debajo de la foto
                const Text(
                  'Joel Reyes Betances',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Programador',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8.0),
                // Contador de likes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          likeCount++;
                        });
                      },
                    ),
                    Text(
                      '$likeCount',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Lista de rectángulos con lenguajes de programación
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.blueAccent,
                      child: const Text(
                        'Python',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.green,
                      child: const Text(
                        'Dart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Iconos con redirección
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.facebook),
                      onPressed: () =>
                          _showMessage(context, 'Redirigiendo a Facebook'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          _showMessage(context, 'Redirigiendo a Twitter (X)'),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Botón de contacto y descarga
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          _showMessage(context, 'Redirigiendo a Gmail'),
                      child: const Text('Contactar'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _showMessage(context, 'Descargando CVC'),
                      child: const Text('Descargar CVC'),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Sección de Proyectos, Seguidores y Calificación
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          '17',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text('Proyectos',
                            style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          '98',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text('Seguidores',
                            style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          '4.6',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text('Calificación',
                            style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
