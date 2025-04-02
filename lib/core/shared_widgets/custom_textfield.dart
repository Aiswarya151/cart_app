import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final IconButton? suffixIcon;

  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return  // Matches Figma height
       TextField(
        controller: controller,
        obscureText: obscureText,
        
        
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          suffixIcon:suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Border radius from Figma
            borderSide: BorderSide(
              color: Color(0xFFE1E1E1), // Border color
              width: 2, // Border width from Figma
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.blue, // Color when focused
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      )
    ;
  }
}
