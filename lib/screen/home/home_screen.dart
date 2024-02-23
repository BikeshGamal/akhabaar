import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar/constant/const.dart';
import 'package:khabar/screen/home/category_section.dart';
import 'package:khabar/screen/home/slide_section.dart';
import 'package:khabar/screen/home/trending_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CategorySection(),
            Expanded(
              flex: 7,
              child: ListView(
                children: [
                  Text(
                    "science News",
                    style: GoogleFonts.lacquer(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SlideSection(),
                  SizedBox(
                    height: 20,
                  ),
                  
                  TrendingSection()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
