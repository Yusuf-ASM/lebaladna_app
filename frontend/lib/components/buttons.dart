import 'package:flutter/material.dart';

import '../../backend/shared_variables.dart';

class AboutUsButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback pressFunction;
  const AboutUsButton({
    super.key,
    required this.text,
    required this.icon,
    required this.pressFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ElevatedButton(
        onPressed: pressFunction,
        style: const ButtonStyle(
          alignment: Alignment.centerLeft,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: MediumTextSize,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: SemiTextSize),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AboutUsButtonV2 extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback pressFunction;
  final VoidCallback longPressFunction;
  const AboutUsButtonV2(
      {super.key,
      required this.text,
      required this.icon,
      required this.pressFunction,
      required this.longPressFunction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onLongPress: longPressFunction,
        onPressed: pressFunction,
        style: const ButtonStyle(
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Icon(
                color: Colors.lightBlue[500],
                icon,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                text,
                style: const TextStyle(color: Color.fromARGB(255, 6, 115, 179)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback pressFunction;
  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    required this.pressFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressFunction,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 15),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
