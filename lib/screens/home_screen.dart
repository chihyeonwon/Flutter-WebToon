import 'package:flutter/material.dart';
import '../models/webtoon_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    );
  }
}
