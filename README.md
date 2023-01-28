# TodayWebToon (오늘의 웹툰 앱 프로젝트)

```
개발 툴 : Flutter
개발 언어 : Dart
개발 일시 : 2023-01-28 ~
개발자 : Won Chi Hyeon
```

## AppBar 생성
```
screens 폴더 안에 화면의 위젯들을 보여주는 home_screen.dart 파일을 만들고 그 안에 위젯들을 배치하였습니다.
앱 바는 배경색을 하얀색, 폰트색을 검은색으로 하고 Scaffold 위젯에 하얀색 바탕색을 주었습니다.
텍스트는 오늘의 웹툰을 작성하고 폰트크기를 24로 지정하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215239472-96d910a7-6e45-4c06-ae5b-0cd9c7b7bd37.png)

## 데이터 가져오기 (Data Fetching)
```
lib 폴더 안에 services 폴더를 만들고 그 안에 ApiService 클래스를 만들어줍니다.
이 클래스는 baseUrl 프로퍼티를 가지고 있고 값으로 https://webtoon-crawler.nomadcoders.workers.dev/ url을 가집니다.
또 하나의 today 프로퍼티로 값으로 today를 가지고 있습니다.
```
baseUrl = [네이버 웹툰 Unofficial API](https://webtoon-crawler.nomadcoders.workers.dev/)

## 필요한 패키지(http) 추가
```
서버에서 데이터를 가져오기 위해서는 http 라이브러리 설치가 필요합니다.
flutter pub add http 명령어를 사용하여 설치한 후에 프로젝트에 사용하였습니다.

그냥 http의 get메서드를 사용해도 되지만 namespace를 사용하기 위해 
import 문 뒤에 as http 를 사용하여 http.get의 형식으로 사용하였습니다.
```

## 비동기 함수 getTodaysToons 로 데이터 가져오기
```
url을 Uri 메서드로 파싱해서 가져온 다음 get 메서드로 넘겨줍니다.
get 방식으로 요청을 처리할 때는 요청의 결과인 응답 결과가 중요한 데이터이면서 future타입(미래에 완료)을
반환한다는 것을 알 수 있습니다. 이런 함수는 비동기 함수 async로 만들어서 요청의 결과가 끝난 후에
진행되어야 하므로 await 구문을 사용하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215240400-1bfa6fac-4969-4a9e-aa25-65e4b90efee1.png)
