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
            return ListView.builder(
              scrollDirection: Axis.horizontal, // 스크롤 수평으로
              itemCount: snapshot.data!.length,
              itemBuilder:(context, index) { // 화면에 보여지는 부분의 아이템을 정할 수 있음
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
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
