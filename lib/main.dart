import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<PanoramaState> _panoKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PanoramaViewer(
            key: _panoKey,
            child: Image.asset('assets/images/theta_x_car.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: IconButton.filledTonal(
                    onPressed: () {
                      final currentState = _panoKey.currentState;
                      if (currentState != null) {
                        final currentZoom = currentState.scene!.camera.zoom;
                        currentState.setZoom(currentZoom + 0.3);
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: IconButton.filledTonal(
                    onPressed: () {
                      final currentState = _panoKey.currentState;
                      if (currentState != null) {
                        final currentZoom = currentState.scene!.camera.zoom;
                        currentState.setZoom(currentZoom - 0.3);
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
