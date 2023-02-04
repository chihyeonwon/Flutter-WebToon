import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  // 에피소드 버튼을 탭했을 때 호출되는 함수
  onButtonTap() async {
    await launchUrlString("https://google.com");
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
                          Episode(episode: episode)
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

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final WebtoonEpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom:10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.green.shade400,
        boxShadow: [
          BoxShadow(
            blurRadius:5,
            offset:const Offset(5, 5),
            color:Colors.black.withOpacity(0.2),
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical:20,
          horizontal:20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text(episode.title,
              style:const TextStyle(
                color:Colors.white,
                fontSize:16,
              )
            ),
            const Icon(Icons.chevron_right_rounded,
              color:Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
