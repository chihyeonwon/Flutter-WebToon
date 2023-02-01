import 'package:http/http.dart' as http; // namespace를 http로 지정
import 'dart:convert'; // jsonDecode 메서드를 사용하기 위함

import '../models/webtoon_model.dart';
import '../models/webtoon_detail_model.dart';

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

    static Future<List<WebtoonModel>> getTodaysToons() async {
      List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today'); // 요청을 보낼 url
    final response = await http.get(url); // api에 get 방식으로 요청
    if(response.statusCode == 200) { // 200: 요청성공 
      final List<dynamic> webtoons = jsonDecode(response.body); // 응답의 데이터 부분을 콘솔에 출력
      for(var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error(); // 아니라면 에러 발생
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
      final url = Uri.parse("$baseUrl/$id");
      final response = await http.get(url);
      if(response.statusCode == 200) {
        final webtoon = jsonDecode(response.body);
        return WebtoonDetailModel.fromJson(webtoon);
      }
      throw Error();
  }
}