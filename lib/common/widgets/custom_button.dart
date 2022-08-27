import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double? width;
  final double? height;
  final bool? isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.width,
    this.height,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width == null ? double.infinity : width!,
          height == null ? 50 : height!,
        ),
        primary: color,
      ),
      child: isLoading == true
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
    );
  }
}
