import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  bool isLoading;
  Color clr;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.isLoading = false,
    this.clr=const Color(0xffB83446)
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // shape:OutlinedBorder(side: BorderSide.) ,
          backgroundColor: clr, // Background color
          // Text Color (Foreground color)
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
