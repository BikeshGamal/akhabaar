import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/api_services/cubit/cnews_cubit.dart';
import 'package:khabar/constant/const.dart';
import 'package:khabar/screen/category_screen/CategoryScreen.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Const.categoryName.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async{
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Loading ${Const.categoryName[index]} news...")),
              );
              await context.read<CnewsCubit>()..getNews(false, Const.categoryName[index]).then((_){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return CategoryScreen();
                },
              ));
              });
              
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: Stack(
                children: [
                  ClipRRect(
                    child: Image.asset(Const.categoryImage[index],
                        width: 115, height: 70, fit: BoxFit.cover),
                  ),
                  Container(
                    width: 115,
                    height: 70,
                    color: Colors.black45,
                    child: Center(
                        child: Text(
                      Const.categoryName[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
