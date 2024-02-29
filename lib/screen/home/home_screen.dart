import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar/api_services/cubit/news_cubit.dart';
import 'package:khabar/api_services/repository/news_repostiory.dart';
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
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Text(
                      "Breaking News",
                      style: GoogleFonts.lacquer(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(child: Builder(builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          NewsCubit(repository: context.read<NewsRepository>())
                            ..getNews(true, "science"),
                      child: SlideSection(
                        category: "science",
                      ),
                    );
                  })),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(child: Builder(builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          NewsCubit(repository: context.read<NewsRepository>())
                            ..getNews(false, "technology"),
                      child: TrendingSection(category: "technology"),
                    );
                  }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
