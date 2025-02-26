import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  bool _showFrame = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleFrame(bool value) {
    setState(() {
      _showFrame = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Fading Text')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: toggleVisibility,
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: _showFrame
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Show Frame'),
              Switch(
                value: _showFrame,
                onChanged: toggleFrame,
              ),
            ],
          ),
        ],
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleVisibility,
          child: Icon(_isVisible ? Icons.play_arrow : Icons.pause),
        ),
    );
  }
}

