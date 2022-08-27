import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String heading;
  final double paddingHorizontal;
  final double paddingVertical;
  final double? headingSize;
  final Color? headingColor;
  final IconData? headingIcon;
  final double? headingIconSize;
  final Color? headingIconColor;
  const CustomHeading(
      {Key? key,
      required this.heading,
      required this.paddingHorizontal,
      required this.paddingVertical,
      this.headingSize,
      this.headingColor,
      this.headingIcon,
      this.headingIconSize,
      this.headingIconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: headingColor ?? Colors.black,
              fontSize: headingSize ?? 22,
            ),
          ),
          Icon(
            headingIcon,
            size: headingIconSize,
            color: headingIconColor,
          ),
        ],
      ),
    );
  }
}
