import 'package:flutter/material.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({
    Key? key,
    required this.textColor,
    required this.backgroundColor,
    required this.onCalendarPressed,
  }) : super(key: key);

  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onCalendarPressed;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: (height / 100) * 10,
      color: backgroundColor,
      child: IconButton(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        icon: Icon(
          Icons.calendar_today,
          color: textColor,
          size: 20.0,
        ),
        onPressed: onCalendarPressed,
      ),
    );
  }
}
