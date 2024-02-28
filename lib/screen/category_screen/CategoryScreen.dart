import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar/constant/const.dart';
import 'package:khabar/screen/category_screen/c_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: ()async {
          Navigator.pop(context);
        },icon: Icon(Icons.keyboard_arrow_left_outlined),),
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
                  text: "BaaR", style: TextStyle(color: Const.secondaryColor)),
                  TextSpan(
                  text: "(${widget.category})", style: TextStyle(color: Const.primaryColor))
            ],
          ),
        ),
      ),
      body: Cscreen(),
    );
  }
}
