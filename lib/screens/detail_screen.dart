import 'package:flutter/material.dart';

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;


  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white,
        appBar:AppBar(
          centerTitle:true,
        elevation:2, // 음영 테두리 조절
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          widget.title,
          style:const TextStyle(fontSize:24,),
        ),
        ),
      body: Column(
        children: [
          const SizedBox(
            height:50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag:widget.id,
                child: Container(
                    clipBehavior:Clip.hardEdge, // 자식의 부모 영역 침범을 제어
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius:15, // 그림자의 범위 지정
                            offset: const Offset(10, 10), // 그림자의 위치 지정
                            color:Colors.black.withOpacity(0.5),
                          )
                        ]
                    ),
                    width:200,
                    child: Image.network(widget.thumb)
                ),
              ),
            ],
          ),
          const SizedBox(
            height:25,
          ),
          FutureBuilder(
            future:webtoon,
            builder:(context, snapshot) {
              if(snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Text(snapshot.data!.about,
                       style: const TextStyle(
                         fontSize: 15
                       ),
                      ),
                      Text(snapshot.data!.genre,
                        style: const TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Text("...");
            }
          )
        ],
      )
    );
  }
}
