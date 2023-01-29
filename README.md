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

## 요청의 응답을 콘솔에 뿌리기
```
get메서드를 사용해서 요청한 응답을 response 변수에 담고 response의 상태코드가 200일때(요청성공일때)
response.body 즉 데이터 부분을 콘솔에 print 하도록 하고 실패할 경우 Error를 반환하도록 하였습니다.

메인 함수에서 ApiServices 클래스의 getTodaysToons 메서드를 호출하여 콘솔에서 데이터를 잘 가져오는 지 확인하였습니다.
이후에 가져온 데이터를 활용하여 앱을 만들어보겠습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215240962-54f49cec-c5a0-4368-84d6-aa17ad12f983.png)

## JSON데이터를 클래스 리스트로 변환하기
```
lib 아래 models 폴더를 만들고 webtoon_model.dart 파일을 생성합니다.
요청에 대한 응답의 키 문자열은 title, thumb, id 세 가지 입니다.

응답의 문자열을 JSON 데이터로 먼저 변환해줘야 합니다.
jsonDecode를 사용해서 문자열을 JSON으로 변환해 주었습니다.
콘솔에 웹툰을 하나씩 출력합니다.
```
![image](https://user-images.githubusercontent.com/58906858/215299805-2286e3ec-7ad8-43ac-8e26-35c778a18425.png)

## named Constructor로 title, thumb, id를 Json의 title, thumb, id로 변환
```
이름 생성자로 fromJson이라는 생성자를 만든 후에 각 문자열을 Json의 데이터와 대응시킵니다.
이렇게 생성된 모델을 toon 변수에 담고 title을 콘솔에 출력하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215300224-61e1aeb9-8019-42e2-a5cf-0b11d1ff4581.png)
![image](https://user-images.githubusercontent.com/58906858/215300215-06b84453-67fd-4777-96b3-528e3544203b.png)
![image](https://user-images.githubusercontent.com/58906858/215300243-b9a95d24-d74d-4a1e-a0f7-bee8700400c8.png)

## 리스트 생성하고 Json 데이터 넣기
```
빈 리스트 webtoonInstances를 생성하고 add 메서드로 webtoon Json 데이터를 넣어준 뒤 return 합니다.
```
![image](https://user-images.githubusercontent.com/58906858/215300411-8f2a8846-7b68-493d-a749-0fd465734892.png)


