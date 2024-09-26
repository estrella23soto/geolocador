
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const MyApp());
 
 
 class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: _darkTheme(),
      home:HomePage()
    );
  }
  // Función que devuelve el tema oscuro
  ThemeData _darkTheme() {
    return ThemeData.dark();
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 Future<Position> determinePosition() async {
  LocationPermission permission;

  // Verifica el estado actual del permiso
  permission = await Geolocator.checkPermission();

  // Si el permiso fue denegado
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    // Si el permiso es denegado nuevamente
    if (permission == LocationPermission.denied) {
      return Future.error('Permiso denegado');
    }
  }

  // Si el permiso es denegado de forma permanente
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Permiso denegado permanentemente');
  }

  // Si todo está bien, retorna la posición actual
  return await Geolocator.getCurrentPosition();
}

void getCurrentLocation() async {
  Position position = await determinePosition();
  print(position.longitude);
  print(position.longitude);
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator'),
        backgroundColor: Colors.blue,
        centerTitle: true,

      ),
      body: Center(
        child: ElevatedButton(onPressed: () {
          getCurrentLocation();
        }, child: const Text('Tomar Location')),
      ),
    );
  }
}