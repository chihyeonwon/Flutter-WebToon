# TodayWebToon (오늘의 웹툰 앱 프로젝트)

```
개발 툴 : Flutter
개발 언어 : Dart
개발 일시 : 2023-01-28 ~ 2023-02-05
개발자 : Won Chi Hyeon
```

## 사용한 패키지
```
https
url_launcher
shared_preferences
```

## 최종 화면 및 기능 소개

### [메인 페이지 : 요일에 따라 변경되는 웹툰 리스트를 확인할 수 있습니다.]
![image](https://user-images.githubusercontent.com/58906858/216799853-3e2ad17e-6ecf-4e66-9637-1e61ac34e807.png)
### [상세 페이지 : 웹툰에 대한 상세 페이지를 보여주는 화면으로 줄거리, 장르, 이용 연령대, 에피소드회차 바로가기 기능이 있습니다.]
![image](https://user-images.githubusercontent.com/58906858/216799864-e4efceeb-c565-495c-957e-9464c5f3426c.png)
### [에피소드 회차를 클릭하면 해당하는 회차의 웹툰을 바로 볼 수 있습니다.]
![image](https://user-images.githubusercontent.com/58906858/216799888-707b0fc6-c802-40e8-953d-554d82c35380.png)
### 웹툰 좋아요 기능(좋아요를 누르기 전)
![image](https://user-images.githubusercontent.com/58906858/216799910-e9069784-ea7b-42eb-8bfc-63569531fdac.png)
### 웹툰 좋아요 기능(좋아요를 누른 후)
![image](https://user-images.githubusercontent.com/58906858/216799920-2c3fb433-d500-4c81-a649-0f1a65354dca.png)


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
![image](https://user-images.githubusercontent.com/58906858/215301606-305e8558-6ae6-4d27-96b5-0c40822efdad.png)

## 화면 위젯 수정
```
위젯의 화면을 나타내는 home_screen.dart 파일의 stless 클래스를 stateful 클래스로 바꾼 뒤
웹툰을 받아오는 함수를 비동기 함수 안에 넣고 initState()에서 호출하도록 하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215302220-7e1c6dbe-148b-4dff-b151-f756e16e77f0.png)

## futureBuilder를 사용하여 데이터 가져오기
```
state를 사용해서 데이터를 가져오는 방법은 선호되지 않기에 home_screen.dart 파일의
stateful클래스를 다시 stless로 변경 후 위에서 작업한 initState()와 비동기 함수는 지워줍니다.

후에 webtoons를 통해서 getTodaysToons함수를 호출한 다음 
Scaffold의 바디에 FutureBuilder를 사용합니다.
FutureBuilder는 future와 builder를 사용합니다.
future는 위에서 만든 webtoons를 주고
builder는 context와 snapshot을 가집니다.
snapshot이란 future 데이터의 상태를 나타내고 
hasData 메서드를 통해서 데이터의 유무 상태를 조작할 수 있습니다.(isLoading 조작 x)

state를 사용하기보다 futureBuilder를 사용하면 setState, isLoading 조작이 필요업다는 장점이 있습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215302741-0d32ba51-e57c-4de0-b4df-d063ae9755d2.png)
![image](https://user-images.githubusercontent.com/58906858/215302862-45b15572-803d-45c1-9498-a825d9bbcb23.png)

## 로딩 중 기능 구현
```
데이터를 가져올 때 (hasData ? false일 때) 로딩 Indicator가 나타나도록 수정하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215406265-523de24d-292a-4794-88b2-6962abd4269d.png)

## 웹툰의 제목을 ListView로 구현
```
여러 항목들을 나열하기 위해서는 ListView 위젯을 사용합니다. for 구문을 사용해서 future의 데이터
중 웹툰의 제목들을 하나씩 나열하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215407432-7f6cd6f2-e94a-4147-aa3b-353f4682fdf8.png)

## 좀 더 최적화 된 ListView.builder로 구현
```
ListView를 사용하면 한 번에 데이터를 다 로딩하기 때문에 메모리 사용 측면에서 굉장히 부정적인 영향을 끼칩니다.
따라서 좀 더 전문적이고 많은 아이템에 최적화된 ListView.builder를 사용하였습니다.

ListView를 사용하면 화면에 보이는 아이템만 로딩해서 보여주는 itemBuilder를 사용할 수 있고 
메모리의 재활용을 하거나 낭비를 줄일 수 있습니다.

데이터를 인덱스 번호에 매칭해서 화면에 보이는 아이템만 로딩합니다.
```
![image](https://user-images.githubusercontent.com/58906858/215409841-e950ef0d-fb5e-4bbf-b58c-2fca157d4ec7.png)

## ListView.separated로 데이터 간 구분자 생성하기
```
ListView.builder에서 builder를 separated로 수정합니다.
separatedBuilder를 통해 데이터 간 구분자를 설정할 수 있습니다.
너비 20의 sizebox를 구분자로 설정하였습니다. 
```
![image](https://user-images.githubusercontent.com/58906858/215411209-fe010008-f734-43c3-9eb8-0d22d8b17f40.png)

## 웹툰 썸네일 이미지 넣기
```
썸네일 이미지를 넣을 공간을 만들기 위해서 ListView를 Expanded로 감싸고 다시 Column으로 감싸줍니다.
Container를 이용해 공간을 만듭니다. SizedBox를 사용할 때모다 decoration로 옵션을 주어서 더 꾸며줄 수 있습니다.
Container 안에 Image.network(url) (url:webtoon.thumb에 있습니다)를 사용해서 이미지를 추가해줍니다.

웹툰 이미지를 추가해주고 제목과의 간격을 SizedBox로 조정합니다.
```
![image](https://user-images.githubusercontent.com/58906858/215418082-ee0fc9c1-c48b-4503-915e-92612f2082a8.png)

## 썸네일 이미지에 그림자 추가하기
```
불투명도 0.5 , 15크기의 범위를 가지는 그림자를 썸네일에 추가하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215636722-e1e9ddee-7def-41f8-94ab-bffb1c11c220.png)

## 웹툰 썸네일을 클릭했을 때 보여지는 상세 페이지 추가
```
웹툰 썸네일을 리턴하는 부분을 따로 detail_screen.dart파일로 분리한 후에
Container를 GestureDectector로 감싸준 뒤 onTap에서 Navigator를 작성하였습니다.
어떤 웹툰인지 구별하기 위해서 생성자로 title, thumb, id의 정보를 넘겨주도록 하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215641356-71ecc2b8-dfae-4f39-bb8a-623704dd9ac9.png)

## 상세 페이지로 화면 전환하기
```
썸네일 이미지를 누르면 Navigator의 MaterialRoute가 detail_screen.dart의 stless 화면 위젯 클래스를 route로 
build 해서 화면 전환 애니메이션 효과를 줄 수 있습니다.

AppBar는 전체적인 통일감을 주기 위해서 homescreen 에서 사용한 appbar 코드를 재활용하되 title은 
웹툰의 title이 올 수 있도록 수정하였습니다.

맨 앞 웹툰의 썸네일을 클릭한 후 화면을 전환하여 해당하는 웹툰의 상세 페이지로 넘어가도록 구현하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215643753-73907746-ffc3-450a-b671-77780fb15a68.png)

## 상세 페이지 애니메이션 효과 주기
```
버튼을 클릭했을 때 route의 종류에 따라 옵션을 달리하여 다양한 애니메이션 효과를 줄 수 있습니다.
MaterialRoute를 PageRouteBuilder로 수정하고 fullscreenDialog 옵션을 주어서 애니메이션 효과를 주었습니다.

썸네일 이미지를 클릭하면 아래에서 위로 페이지가 날라오면서 AppBar의 뒤로가기 버튼이 X 로 바뀝니다.
```
![image](https://user-images.githubusercontent.com/58906858/215648611-eb3ec9be-64ff-44d5-aaaf-0b5955fdbc31.png)

## Hero 위젯으로 홈의 이미지와 상세 페이지의 이미지 연결 애니메이션 주기
```
두 개의 화면의 위젯을 하나의 같은 태그로 연결하면 이미지가 연결되어 떠다니듯이 이동합니다.

Home 스크린의 Container를 Hero 위젯으로 감싸고 tag 값으로 id를 주었습니다.
마찬가지로 detail 스크린의 Container를 Hero 위젯으로 감싸고 tag 값으로 id를 주었습니다.
이렇게 하면 두 개의 이미지가 서로 연결되어 화면 전환이 일어날 때 위젯이 마치 연결된 듯한 움직임을
보여줄 수 있습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215650032-b426f747-0ffe-41c7-a385-32d3ca5c5c7d.png)

## 상세 페이지 모델 생성
[상세페이지모델 url](https://webtoon-crawler.nomadcoders.workers.dev/790713)
```
상세 페이지에 들어갈 내용을 official API URL에 Webtoon의 ID를 붙인 url에서 가져옵니다.
해당 Webtoon에 대한 디테일한 정보(title, about, genre, age, thumb)를 가지고 있습니다.

해당 정보를 가지는 모델(클래스)를 models/webtoon_detail_model.dart 파일에 작성합니다.
```
![image](https://user-images.githubusercontent.com/58906858/215941325-34bf8f76-e662-4817-98b6-aa961dbb92d5.png)
![image](https://user-images.githubusercontent.com/58906858/215941766-c3f9642b-cb20-475a-b770-d133335d8f21.png)

## 상세 페이지 데이터 가져오기(url/id)
```
Official Api url/id 에서 title, about, genre, age, thumb에 대한 정보를 json 형식의 데이터에서
프로젝트에 적용하기 위해서 전에 했던 방식처럼 Uri.parse, jsonDecode를 사용해서 데이터를 
가지고 옵니다.
```
![image](https://user-images.githubusercontent.com/58906858/215942578-196d524c-e825-4b91-b4fd-5cafd7974346.png)

## 최근 에피소드의 정보 모델 생성
[최근 에피소드 모델 url](https://webtoon-crawler.nomadcoders.workers.dev/790713/episodes)
```
official API URL에 Webtoon의 ID 뒤에 episodes를 붙이면 최근 에피소드의 정보를 받아올 수 있습니다.
정보는 id, title, rating, date(id, 제목, 평점, 날짜)를 가지고 있습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215943345-2fa62e26-2ff9-43a6-a7bd-b6c6f0e737c9.png)
![image](https://user-images.githubusercontent.com/58906858/215943314-c32bfb37-303a-4bb5-8ea8-68037d23f0ce.png)

## 최근 에피소드 데이터 가져오기(url/id/episodes)
```
url의 정보가 리스트이기 때문에 리스트를 리턴하는 getLatestEpisodesModel 함수를 작성하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215946211-576e5ab9-6c1b-4c29-82e0-076fc68c4a23.png)

## 상세 페이지에서 getToonById 함수 호출하기
```
앞서 만든 apiurl/id 에서 데이터를 가져오는 함수인 getToonById를 호출합니다.
detail_screen의 화면을 stless에서 stful 위젯으로 바꾸어 줍니다.

생성자에서 다른 클래스의 id를 참조하는 것은 불가능하기 때문에 late와
initState()를 사용하여 다른 클래스의 id를 참조하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215949949-b872aa73-aae8-4f7d-8324-d5c71777c9a8.png)

## 상세 페이지에서 getLatestEpisodesById 함수 호출하기
```
getLatestEpisodeById 함수 역시 late와 initState()를 사용하여 다른 클래스의 id를 참조한 뒤에
호출하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/215951152-212a97f9-b47c-40c0-b314-2b6c098fc7ad.png)

## 상세 페이지의 웹툰 설명(about) ui 추가하기
```
FutureBuilder를 사용해서 webtoon(apiurl/id)의 about 프로퍼티의 데이터를
텍스트로 출력하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216228776-753974a6-675f-421a-ac1e-4a922e4f3f9a.png)
![image](https://user-images.githubusercontent.com/58906858/216228787-bfc8f3fb-47a5-4d17-a60d-983bf81bec52.png)

## 상세 페이지의 웹툰 장르(genre) ui 추가하기
```
마찬가지로 장르(genre)프로퍼티의 데이터 값 역시도 텍스트로 출력하고 
설명(about)와 장르(genre) 간 여백을 주고 배치하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216231096-c39403e1-220c-4fa5-9a23-28761e443088.png)
![image](https://user-images.githubusercontent.com/58906858/216231081-118dbbb6-bdb6-470d-96c5-4deb0efe138b.png)

## 문자열 바인딩(Text interpolation)으로 장르 옆에 나이 출력하기
```
문자열 바인딩(Text interpolation) 이란 ${Text}의 형식으로 여러 개의 문자열을
이어서 출력할 수 있게 도와줍니다.
문자열 바인딩을 사용해서 장르 옆에 나이를 출력하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216231823-aef728b0-577c-4d1f-9a2a-478f6b4202d6.png)
![image](https://user-images.githubusercontent.com/58906858/216231838-b235b2e8-aef1-4d33-abaa-6c460db7b27e.png)

## 상세 페이지에 에피소드 ui 추가하기
```
에피소드의 Future 타입은 리스트가 반환되는 것을 알 수 있습니다.
리스트의 크기를 모르고 최적화가 중요 리스트라면 ListView나 ListView.builder를 사용하지만
리스트의 크기를 10개로 알고 있고 그 크기가 크지 않기에 Column을 사용합니다.

에피소드를 버튼처럼 표현하기 위해 Container와 Row를 사용하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216235477-70897070-0249-4dfb-a4bc-cfd61f2fbcce.png)
![image](https://user-images.githubusercontent.com/58906858/216235567-b7f3aedb-c36f-4f32-8273-33fce2042700.png)

## 에피소드 ui 꾸미기
```
에피소드 버튼에 색상과 폰트 색상, 여백, 요소들간 배치 등을 추가하여 ui를 꾸몄습니다.

이 전에 전체 위젯을 ListView로 감쌌는 데 SingleChildScrollView가 문제 해결에 더 좋을 것 같아서
수정하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216500802-394b676d-d5e1-40d4-bc5e-a34c307638ca.png)
![image](https://user-images.githubusercontent.com/58906858/216500784-832e9e93-9fa5-457b-b1cc-fb04e1183d93.png)

## url_launcher 패키지 설치와 설정
```
에피소드 버튼을 클릭했을 때 해당하는 회차의 웹툰 웹페이지로 이동시키기 위해서는
flutter의 url_launcher 라이브러리를 사용해야 합니다.
flutter pub add url_launcher 명령어를 사용해서 패키지를 설치한 후에

안드로이드라면 다음 코드를 android/main/AndroidManifest.xml 파일에 추가해줍니다.(최상단 root의 바로아래 child)
scheme에는 sms나 tel 등이 올 수 있지만 https url을 사용하기 때문에 https를 넣어주었습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216502572-1ec4ae0b-4c8c-41f8-b247-f49b3f195846.png)

## 에피소드 버튼을 생성하는 부분을 리팩토링(Extract Widget)
```
에피소드 버튼을 생성하는 부분을 Refactoring 합니다.
안드로이드 스튜디오의 Extract Flutter Widget(플러터 위젯으로 추출하기) 기능을 사용하여 이름이 Episode인 
Episode widget을 생성합니다.

```
![image](https://user-images.githubusercontent.com/58906858/216745551-f98ea110-4963-45cd-9060-aff54daa2425.png)
![image](https://user-images.githubusercontent.com/58906858/216745562-c4fb2313-cc47-4cfa-9809-b6380eca214d.png)

## url_launcher를 사용해서 에피소드 버튼 기능 구현
```
에피소드 버튼을 누르면 해당하는 웹툰 회차의 네이버 웹툰 사이트로 이동하게끔하는 기능을 추가해야합니다.
웹툰 사이트 url은 https://comic.naver.com/webtoon/detail?titleId=${webtoonId}&no=${episode.id}
즉 titleId에 웹툰의 id값이 no에 에피소드의 id값이 필요합니다.
epsiode의 Id 값은 webtoonEpisodeModel의 생성자에서 id를 얻어올 수 있고
webtoon의 Id 값은 detail_screen.dart파일에서 생성자로 넘겨주어야 합니다.

이렇게 받아온 webtoonId와 episodeId를 문자열 바인딩을 사용해서 url을 완성시켜줍니다.

각 에피소드 버튼에 GestureDetector를 생성하고 클릭하면 해당하는 웹툰 회차의 네이버 웹툰으로
이동하는 기능을 구현하였습니다.
```
### [deatil.screen.dart 파일에서 webtoonId 값을 넘겨준다.]
![image](https://user-images.githubusercontent.com/58906858/216746553-06288eae-59f9-4d4b-9aab-4cba04989cbe.png)

### [webtoonId값을 생성자로 받아와서 사용한다.]
![image](https://user-images.githubusercontent.com/58906858/216746546-2ffff96b-68cf-4ca3-8dc9-aa1eeecc579c.png)

### 받아온 webtoonId와 episodeId를 문자열 바인딩을 사용해서 url 생성
![image](https://user-images.githubusercontent.com/58906858/216746613-c39eabb7-963e-45ae-96dc-f2d2caaf1879.png)

### 에피소드 버튼을 눌렀을 때 해당하는 회차의 웹툰 사이트로 바로 연결해주어 웹툰을 볼 수 있게 함
![image](https://user-images.githubusercontent.com/58906858/216746645-699a3979-6793-4d39-8009-51ecd04ab8fc.png)

## AppBar에 좋아요 버튼 기능 추가
```
하트를 눌렀을 때 하트가 채워지면서 좋아요를 뜻하는 기능을 구현하고자 하였습니다.
먼저 detail_screen의 AppBar의 actions 프로퍼티에 onTap 함수와 빈 하트 아이콘을 추가하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216746953-86f12978-7c39-4ace-9b29-cba06319a702.png)
![image](https://user-images.githubusercontent.com/58906858/216746956-b53a1bb0-a0d3-4df4-9fcf-20d7d61fd201.png)

## shared_preferences 패키지 설치
```
핸드폰 저장소에 좋아요 버튼에 대한 정보를 저장할 필요가 있습니다.
저번에는 eqlite를 사용하여 개인 데이터베이스에 접근하였지만 이번에는 shared_preferences 라이브러리를 설치하여 사용하였습니다.
flutter pub add shared_preferences 명령어로 shared_preferences 라이브러리를 설치하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216798665-4522054e-8f09-4b5d-b09a-7f45952be023.png)

## shared_preferences를 사용하여 저장소와 연결하기
[shared_preferences 개발문서](https://pub.dev/packages/shared_preferences)
```
shared_preferences의 개발문서에 따르면 getInstance() 한 줄 만으로 저장소와 연결하여
저장소에 다양한 타입의 데이터를 ('key', value)의 형태로 write 저장할 수 있다고 합니다.

사용자의 저장소와 프로젝트를 연결하기 위해서 getInstance() 메서드를 initPrefs() 메서드에서 
비동기적으로 호출하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216798833-25a31a4c-66e2-4fb7-b5cd-99bb54d73d14.png)
![image](https://user-images.githubusercontent.com/58906858/216798865-1006611b-f102-44c4-a805-27b44b33f3ef.png)

## 저장소의 데이터 유무에 따라서 bool 값(좋아요 버튼의 상태) 변경하기
```
likedToons는 웹툰 id 리스트를 읽어서 likedToons에 저장하고 (getStringList)
웹툰 id 리스트의 데이터가 없다면 빈 리스트를 likedToons에 저장합니다.
웹툰 id 리스트에 데이터가 있고 웹툰 id를 포함한다면 (contains) isLiked 좋아요 버튼의 상태를 true로 변경합니다.
```
![image](https://user-images.githubusercontent.com/58906858/216799130-a8b37304-4635-456e-9c96-b09fc1ec34c5.png)

## bool 값 (좋아요 버튼의 상태)에 따라 리스트 변경하기
```
버튼 메서드 onHeartTap를 생성하고 좋아요 버튼이 이미 true 눌러져있다면 
리스트에서 해당하는 웹툰id를 제거하고 false 눌러져있지않다면 리스트에 해당하는 웹툰 id를 추가하는
로직을 추가하였습니다. 리스트를 로직에 의해 생성된 리스트로 새로 초기화해줍니다.
```
![image](https://user-images.githubusercontent.com/58906858/216799577-8099cf67-56bf-4746-894d-e44867d67e35.png)

## 좋아요 버튼 기능 구현 (최종)
```
버튼에 생성한 onHeartTap 함수를 호출하도록하고 좋아요 버튼이 잘 작동하나 테스트하였습니다.
좋아요 버튼을 맨 처음 눌렀을 때는 빈 하트가 채워진 하트로 변경되고
채워진 하트를 눌렀을 때는 빈 하트로 잘 변경되는 것을 알 수 있었습니다.

또한 이러한 bool, List 값은 사용자의 디바이스 데이터베이스에 저장되므로 
rebuilding했을 때도 데이터가 사라지지 않고 똑같이 작동하는 것을 확인하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/216799591-4487c24d-52a7-487a-a66d-7240507218f4.png)

### [좋아요 버튼을 누르기 전]
![image](https://user-images.githubusercontent.com/58906858/216799654-f1a2565d-f4e7-4926-969a-42d96abe8067.png)

### [좋아요 버튼을 눌렀을 때]
![image](https://user-images.githubusercontent.com/58906858/216799664-d735f388-f72a-4dc8-aeb0-5e0053b66b04.png)
