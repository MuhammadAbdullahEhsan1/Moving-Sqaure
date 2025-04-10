import 'package:flutter/material.dart';

// The app starts here
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: Padding(padding: EdgeInsets.all(32.0), child: SquareAnimation()),
    );
  }
}

// This widget contains our moving square and buttons
class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() => SquareAnimationState();
}

class SquareAnimationState extends State<SquareAnimation> {
  // The size of our red square
  static const _squareSize = 50.0;

  // Tracks that square is in center
  Alignment _alignment = Alignment.center;

  // Boolean for animation
    bool _animating = false;

  // Makes the square bounce
  final Curve _curve = Curves.elasticInOut;

  // The square's color
  final MaterialColor _colors = Colors.red;

  // Moves the square left 
  void _movingLeft() {
    // Logic to check if already left or currently moving
    if (_alignment == Alignment.centerLeft || _animating) return;

    // update the state
    setState(() {
      _animating = true;
      _alignment = Alignment.centerLeft;
    });
  }

  // Moves the square right
  void _movingRight() {
    // Logic to check if already right or currently moving
    if (_alignment == Alignment.centerRight || _animating) return;

    // Start moving right
    setState(() {
      _animating = true;
      _alignment = Alignment.centerRight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedAlign(
          duration: const Duration(seconds: 1), // Movement takes 1 second
          alignment: _alignment, // Where to move
          curve: _curve, // Makes it bounce little
          onEnd: () => setState(() => _animating = false), // Done moving
          child: Container(
            width: _squareSize,
            height: _squareSize,
            color: _colors,
          ),
        ),

        // Some space between square and buttons
        const SizedBox(height: 16),

        // Our control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Left button
            ElevatedButton(
              onPressed:
                  // Disable button if already left or moving(null)
                  _alignment == Alignment.centerLeft || _animating
                      ? null
                      : _movingLeft,
              child: const Text('To Left'),
            ),
            // Right button
            ElevatedButton(
              onPressed:
                  // Disable button if already right or moving(null)
                  _alignment == Alignment.centerRight || _animating
                      ? null
                      : _movingRight,
              child: const Text('To Right'),
            ),
          ],
        ),
      ],
    );
  }
}
