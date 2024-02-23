import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar/api_services/cubit/news_state.dart';
import 'package:khabar/api_services/cubit/tnews_cubit.dart';
import 'package:khabar/constant/const.dart';
import 'package:khabar/screen/web/web_news.dart';

class TrendingSection extends StatefulWidget {
  const TrendingSection({super.key});

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TnewsCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoadingState) {
          return CircularProgressIndicator();
        } else if (state is CommonErrorState) {
          return Center(
            child: Text("Something went wrong"),
          );
        } else if (state is NoNetworkState) {
          return Center(
            child: Text("no connection avalable"),
          );
        } else if (state is CommonSuccessState) {
          final news = state.newsModel;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                    "Technical News",
                    style: GoogleFonts.lacquer(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
              ListView.builder(
                itemCount: news.articles?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder:(context) {
                          return WebNews(url: news.articles![index].url!);
                        },));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: news.articles![index].urlToImage != null
                                    ? Image.network(
                                        news.articles![index].urlToImage.toString(),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          Const.general,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        news.articles![index].title.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Const.fontColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        news.articles![index].description.toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Const.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
