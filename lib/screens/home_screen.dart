import 'package:flutter/material.dart';
import '../models/webtoon_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        elevation:2, // 음영 테두리 조절
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title:const Center(
          child:Text(
            "오늘의 웹툰",
            style:TextStyle(fontSize:24,),
        ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons, // await webtoons
        builder: (context, snapshot) { //snapshot : future's status
          if(snapshot.hasData) {
            return Column(
              children:[
                SizedBox(
                  height:50,
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal, // 스크롤 수평으로
                     itemCount: snapshot.data!.length,
                     itemBuilder:(context, index) { // 화면에 보여지는 부분의 아이템을 정할 수 있음
                    var webtoon = snapshot.data![index];
                     return Column(
                       children: [
                         Container(
                           width: 250,
                             child: Image.network(webtoon.thumb)
                         ),
                         const SizedBox(
                           height:10,
                         ),
                         Text(webtoon.title,
                         style:const TextStyle(
                           fontSize:22,
                         )),
                       ],
                     );
                },
                separatorBuilder: (context, index) { // data 간 구분자 설정
                  return const SizedBox(width:40); // 너비 20의 Sizedbox로 구분
                }
            ),
          )
              ]
            );
          }
          return Center(
            child:CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
