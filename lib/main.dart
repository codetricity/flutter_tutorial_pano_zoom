import 'package:flutter/gestures.dart';
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

  void zoomIn() {
    final currentState = _panoKey.currentState;
    if (currentState != null) {
      final currentZoom = currentState.scene!.camera.zoom;
      currentState.setZoom(currentZoom + 0.3);
    }
  }

  void zoomOut() {
    final currentState = _panoKey.currentState;
    if (currentState != null) {
      final currentZoom = currentState.scene!.camera.zoom;
      currentState.setZoom(currentZoom - 0.3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Listener(
            onPointerSignal: (event) {
              if (event is PointerScrollEvent) {
                double yScroll = event.scrollDelta.dy;
                if (yScroll <= 0) {
                  zoomIn();
                }
                if (yScroll > 0) {
                  zoomOut();
                }
              }
            },
            child: PanoramaViewer(
              key: _panoKey,
              animSpeed: 0.1,
              child: Image.asset('assets/images/theta_x_car.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: IconButton.filledTonal(
                    onPressed: zoomIn,
                    icon: const Icon(Icons.add),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: IconButton.filledTonal(
                    onPressed: zoomOut,
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
