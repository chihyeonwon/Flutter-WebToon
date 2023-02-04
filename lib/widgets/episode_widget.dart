import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episode,
    required this.webtoonId,
  }) : super(key: key);

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  // 에피소드 버튼을 탭했을 때 호출되는 함수
  onButtonTap() async {
    await launchUrlString("https://comic.naver.com/webtoon/detail?titleId=${webtoonId}&no=${episode.id}"); // titleId : webtoonId, no : episodeId
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
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
      ),
    );
  }
}