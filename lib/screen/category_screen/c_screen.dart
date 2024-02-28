import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/api_services/cubit/news_cubit.dart';
import 'package:khabar/api_services/cubit/news_state.dart';
import 'package:khabar/constant/const.dart';
import 'package:khabar/screen/web/web_news.dart';
import 'package:shimmer/shimmer.dart';

class Cscreen extends StatefulWidget {
  const Cscreen();

  @override
  State<Cscreen> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<Cscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoadingState) {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 20,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 15,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
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
          return CustomScrollView(slivers: [
            SliverList.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return WebNews(url: news.articles![index].url);
                          },
                        ));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child:
                                      news.articles![index].urlToImage != null
                                          ? Image.network(
                                              news.articles![index].urlToImage
                                                  .toString(),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.asset(
                                                Const.general,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                news.articles![index].title != null
                                    ? Text(
                                        news.articles![index].title.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Const.fontColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : Text("..."),
                                SizedBox(
                                  height: 5,
                                ),
                                news.articles![index].description != null
                                    ? Text(
                                        news.articles![index].description
                                            .toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Const.grey, fontSize: 12),
                                      )
                                    : Text("..."),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: news.articles!.length)
          ]);
        } else {
          return Container();
        }
      },
    );
  }
}
