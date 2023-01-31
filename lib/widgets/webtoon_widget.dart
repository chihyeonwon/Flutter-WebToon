import 'package:flutter/material.dart';
import '../screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(
          context,
          PageRouteBuilder(
            fullscreenDialog: true,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, anmation, secondaryAnimation) =>
                DetailScreen(id: id, title: title, thumb: thumb),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
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
                width: 250,
                child: Image.network(thumb)
            ),
          ),
          const SizedBox(
            height:10,
          ),
          Text(title,
              style:const TextStyle(
                fontSize:22,
              )),
        ],
      ),
    );
  }
}
