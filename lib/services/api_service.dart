import 'package:http/http.dart' as http; // namespace를 http로 지정

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

    void getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today'); // 요청을 보낼 url
    final response = await http.get(url); // api에 get 방식으로 요청
    if(response.statusCode == 200) { // 200: 요청성공 
      print(response.body); // 응답의 데이터 부분을 콘솔에 출력
      return; // 아무것도 반환하지 않음
    }
    throw Error(); // 아니라면 에러 발생
  }
}