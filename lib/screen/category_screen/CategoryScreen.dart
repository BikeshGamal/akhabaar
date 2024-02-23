import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar/constant/const.dart';
import 'package:khabar/screen/category_screen/c_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: "AkhA",
            style: GoogleFonts.pacifico(
                color: Const.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: "BaaR", style: TextStyle(color: Const.secondaryColor))
            ],
          ),
        ),
      ),
      body: Cscreen(),
    );
  }
}
