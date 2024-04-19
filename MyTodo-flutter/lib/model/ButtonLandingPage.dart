import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final Function onTap;
  final Color color;

  const CustomButton(
      {required this.buttonText, required this.onTap, required this.color});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      borderRadius: BorderRadius.circular(13),
      child: Container(
        width: 241,
        height: 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Open Sans',
            color: Colors.blue[900],
          ),
        ),
      ),
    );
  }
}
