import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ColorProvider()),
      ],
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
          theme:
              themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: FadingAnimationPageView(),
        );
      },
    );
  }
}

class FadingAnimationPageView extends StatelessWidget {
  const FadingAnimationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interactive Fading Text"),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
            onPressed: themeProvider.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              _showColorPickerDialog(context);
            },
          ),
        ],
      ),
      body: PageView(
        children: const [
          FadingTextAnimationScreen1(),
          FadingTextAnimationScreen2(),
        ],
      ),
    );
  }
}

void _showColorPickerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Pick a Text Color"),
        content: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildColorOption(context, Colors.black),
              _buildColorOption(context, Colors.red),
              _buildColorOption(context, Colors.green),
              _buildColorOption(context, Colors.blue),
              _buildColorOption(context, Colors.orange),
              _buildColorOption(context, Colors.purple),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildColorOption(BuildContext context, Color color) {
  final colorProvider = Provider.of<ColorProvider>(context, listen: false);
  return GestureDetector(
    onTap: () {
      colorProvider.updateColor(color);
      Navigator.of(context).pop();
    },
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 1),
      ),
    ),
  );
}

class FadingTextAnimationScreen1 extends StatefulWidget {
  const FadingTextAnimationScreen1({super.key});

  @override
  _FadingTextAnimationScreen1State createState() =>
      _FadingTextAnimationScreen1State();
}

class _FadingTextAnimationScreen1State
    extends State<FadingTextAnimationScreen1> {
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
    final colorProvider = Provider.of<ColorProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: toggleVisibility,
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1), // 1-second duration
              curve: Curves.easeInOut,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: _showFrame
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Hello, Flutter!',
                  style:
                      TextStyle(fontSize: 24, color: colorProvider.textColor),
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: toggleVisibility,
            child: Icon(_isVisible ? Icons.pause : Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}

class FadingTextAnimationScreen2 extends StatefulWidget {
  const FadingTextAnimationScreen2({super.key});

  @override
  _FadingTextAnimationScreen2State createState() =>
      _FadingTextAnimationScreen2State();
}

class _FadingTextAnimationScreen2State
    extends State<FadingTextAnimationScreen2> {
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
    final colorProvider = Provider.of<ColorProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: toggleVisibility,
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 2), // 2-second duration
              curve: Curves.easeInOut,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: _showFrame
                      ? Border.all(color: Colors.green, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Welcome to Flutter!',
                  style:
                      TextStyle(fontSize: 24, color: colorProvider.textColor),
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: toggleVisibility,
            child: Icon(_isVisible ? Icons.pause : Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class ColorProvider extends ChangeNotifier {
  Color _textColor = Colors.black;
  Color get textColor => _textColor;

  void updateColor(Color newColor) {
    _textColor = newColor;
    notifyListeners();
  }
}
