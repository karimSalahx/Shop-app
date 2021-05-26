import 'package:flutter/material.dart';

class AnimatedObacityLoginRegisterText extends StatefulWidget {
  final String text;
  final void Function() onClick;
  AnimatedObacityLoginRegisterText({
    @required this.text,
    @required this.onClick,
  });

  @override
  _AnimatedObacityLoginRegisterTextState createState() =>
      _AnimatedObacityLoginRegisterTextState();
}

class _AnimatedObacityLoginRegisterTextState
    extends State<AnimatedObacityLoginRegisterText> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        widget.onClick();
        setState(() {
          _isVisible = true;
        });
      },
      onTapDown: (_) {
        setState(() {
          _isVisible = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isVisible = true;
        });
      },
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.4,
        duration: Duration(milliseconds: 200),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.blue.shade300,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
