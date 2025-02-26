import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: FadingTextAnimation(),
        );
      },
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  const FadingTextAnimation({super.key});

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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Fading Text'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
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
                  border: _showFrame ? Border.all(color: Colors.blue, width: 2) : null,
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
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

// Theme Provider for managing light/dark mode
class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
