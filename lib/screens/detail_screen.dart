import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../services/api_service.dart';
import '../widgets/episode_widget.dart';

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
  late SharedPreferences prefs;
  bool isLiked = false; // 좋아요 false로 선언

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance(); // 사용자의 저장소에 connection

    final likedToons = prefs.getStringList('likedToons'); // Tring read Data in likedToons
    if(likedToons != null) {
      if(likedToons.contains(widget.id) == true) { // 웹툰의 id를 가지고 있다면
        setState(() {
          isLiked = true;
        }); // 좋아요 true
      }
    } else {
      prefs.setStringList('likedToons', []); // write Data in likedToons
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if(likedToons != null) {
      if(isLiked) {
        likedToons.remove(widget.id); // 이미 좋아요 누른 상태라면 좋아요 삭제
      } else{
        likedToons.add(widget.id); // 좋아요가 아니라면 좋아요 추가
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
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
          actions:[
            IconButton(
                onPressed: onHeartTap,
                icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline),
            ),
          ],
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
          children: [
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
                  return Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.about,
                       style: const TextStyle(
                         fontSize: 15
                       ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('${snapshot.data!.genre} / ${snapshot.data!.age}',
                        style: const TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ],
                  );
                }
                return Text("...");
              }
            ),
            const SizedBox(
              height:25,
            ),
            FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Column(
                      children: [
                        for(var episode in snapshot.data!)
                          Episode(episode: episode, webtoonId:widget.id,)
                      ],
                    );
                  }
                  return Container();
                }
            )
          ],
            ),
        ),
      )
    );
  }
}
