import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/api_services/cubit/news_cubit.dart';
import 'package:khabar/api_services/cubit/news_state.dart';
import 'package:khabar/constant/const.dart';
import 'package:khabar/screen/web/web_news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlideSection extends StatefulWidget {
  final String category;
  const SlideSection({required this.category, super.key});

  @override
  State<SlideSection> createState() => _SlideSectionState();
}

class _SlideSectionState extends State<SlideSection> {
 

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, CommonState>(
      builder: (context, state) {
         if (state is CommonLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CommonErrorState) {
          return Center(
            child: Text("Something went wrong"),
          );
        } else if (state is CommonSuccessState) {
          final news = state.newsModel;
          return Column(
            children: [
              CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index, realIndex) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return WebNews(url: news[index]!.url);
                          },
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: news[index]!.urlToImage != null
                                ? Image.network(
                                    news[index]!.urlToImage.toString(),
                                    height: 250,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  )
                                : Image.asset(Const.general),
                          ),
                          Container(
                            height: 250,
                            padding: EdgeInsets.only(left: 10),
                            margin: EdgeInsets.only(top: 130),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: news[index]!.title != null
                                ? Text(
                                    news[index]!.title.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text("..."),
                          )
                        ]),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      })),
              SizedBox(
                height: 15,
              ),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 5,
                effect: SlideEffect(
                    dotWidth: 10, dotHeight: 10, activeDotColor: Colors.blue),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
