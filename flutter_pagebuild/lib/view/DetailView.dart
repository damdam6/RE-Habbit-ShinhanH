<<<<<<< Updated upstream
import 'package:flutter/material.dart';
//import 'package:flutter_pagebuild/view/flutter/dev/bots/utils.dart';

import 'package:get/get.dart';
import 'package:flutter_pagebuild/controller/DetailController.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:line_chart/line_chart.dart';

import 'dart:async';
import 'dart:math';
import 'dart:ui';

class DetailView extends StatelessWidget {
  DetailView({Key? key}) : super(key: key);
  final controller = Get.find<DetailController>();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double blankHeight = screenHeight * 0.01;
    double blankWidth = screenWidth * 0.05;
    double startHeight = screenHeight * 0.27;
    double contentWidth = screenWidth * 0.5;
    double appbarHeight = screenHeight * 0.12;


    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 247, 247),
      appBar: AppBar(
        title: const HeaderWidget(),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: appbarHeight,
        leadingWidth: 10,
      ),
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            userInfo(),
            const Text('Detail',
              style: TextStyle(fontSize: 30, color: Colors.grey)),
            // stampResult(),
            // graphWidget(title: '',),
            
            Container(
              height: screenHeight*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
                padding: EdgeInsets.all(10),  
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                // height: widgetHeight,
              child: chartWidget(),
            ),
            resultWidget(),
          ],
            
        ),
      ),
    );
  }
}

class userInfo extends StatelessWidget {
  const userInfo({super.key});

  @override
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double widgetHeight = screenHeight * 0.3;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.white),
      // padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        height: widgetHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 0),
                  // padding: EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/images/profile-img.png',
                    width: 200, 
                    // fit: BoxFit.contain,
                  ),
                ),
                Container(
                  // width: double.infinity,
                  // height: 130,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  // alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      //챌린지 시작 날짜
                      Text(
                        '챌린지 시작 날짜',
                        style: TextStyle(
                            fontSize: 23, color: Colors.purple),
                      ),
                      
                      //(w/controller)
                      Text(
                        '2023.03.22',
                        style: TextStyle(fontSize: 20),
                      ),
                      
                      //남은 날짜
                      Text(
                        '남은 날짜',
                        style: TextStyle(
                            fontSize: 23, color: Colors.purple),
                      ),
                      
                      //(w/controller)
                      Text(
                        'D-20',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class stampResult extends StatelessWidget {
  const stampResult({super.key});

  @override
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double widgetHeight = screenHeight * 0.3;

    return Container(
      child: Column(
        children: [
          //스탬프 갯수 Box -> 아직 보류
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            width: screenWidth,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(' > 스탬프 개수',
                        style: TextStyle(
                            fontSize: 20, color: Colors.purple)),
                    Spacer(),
                    Text(
                      '(기준 : 무지출 + 유지출무적금)',
                      style:
                          TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                //당근 스탬프
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.3,
                        child: Image.asset(
                          'assets/images/carrot-stamp.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      //고정
                      Text(
                        ' ',
                        style: TextStyle(fontSize: 80),
                      ),
                      Text(
                        'X',
                        style: TextStyle(fontSize: 30),
                      ),
                      
                      //(w/Controller)
                      Text(
                        ' 3',
                        style: TextStyle(fontSize: 50),
                      ),
                    ],
                  ),
                  //토끼가 당근 먹는 Stamp
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.3,
                        child: Image.asset(
                          'assets/images/rabbit-stamp.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      //고정
                      Text(
                        ' ',
                        style: TextStyle(fontSize: 80),
                      ),
                      Text(
                        'X',
                        style: TextStyle(fontSize: 30),
                      ),
                      
                      //(w/Controller)
                      Text(
                        ' 3',
                        style: TextStyle(fontSize: 50),
                      ),
                    ],
                  ),
            
                //적금 stamp 갯수
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.3,
                      child: Image.asset(
                        'assets/images/money-stamp.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    //고정
                    Text(
                      ' ',
                      style: TextStyle(fontSize: 80),
                    ),
                    Text(
                      'X',
                      style: TextStyle(fontSize: 30),
                    ),
                    
                    //(w/Controller)
                    Text(
                      ' 3',
                      style: TextStyle(fontSize: 50),
                    ),
                  ],
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}

class resultWidget extends StatelessWidget {
  const resultWidget({super.key});

  @override
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double widgetHeight = screenHeight * 0.3;
    double blankHeight = screenHeight * 0.02;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.white),
      // padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        height: widgetHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          //적금한 일수
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: TextStyle(fontSize: 8),
                ),
                Row(
                  children: [
                    Text(' > 적금한 일수',
                        style: TextStyle(
                            fontSize: 20, color: Colors.purple)),
                    Spacer(),
                    Text(
                      '(기준 : 무지출 + 유지출무적금)',
                      style:
                          TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  '',
                  style: TextStyle(fontSize: 4),
                ),
                //적금총액 세부사항 (w/Controller)
                Column(
                  children: [
                    Row(
                      children: [
                        //고정
                        Text('무지출 :  '),
                        //(w/Controller)
                        Text(
                          '100',
                          style: TextStyle(
                              color: Colors.red,
                              fontStyle: FontStyle.italic),
                        ),
                        //고정
                        Text('%'),
                      ],
                    ),
                    Text(
                      '',
                      style: TextStyle(fontSize: 4),
                    ),
                    Row(
                      children: [
                        //고정
                        Text('유지출 유적금 :  '),
                        //(w/Controller)
                        Text(
                          '100',
                          style: TextStyle(
                              color: Colors.red,
                              fontStyle: FontStyle.italic),
                        ),
                        //고정
                        Text('%'),
                      ],
                    ),
                  ],
                ),
                
                //총 (w/Controller)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //고정
                    Text('총 ',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                    //(w/Controller)
                    Text(
                      '100',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    //고정
                    Text('%',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: blankHeight,
          ),
        
        //>적금 총액
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: TextStyle(fontSize: 8),
                ),
                Row(
                  children: [
                    Text('> 적금 누적금액',
                        style: TextStyle(
                            fontSize: 20, color: Colors.purple)),
                    Spacer(),
                    Text(
                      '(기준 : 소비 후 적금)',
                      style:
                          TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  '',
                  style: TextStyle(fontSize: 4),
                ),
                //적금총액 세부사항 (w/Controller)
                Column(
                  children: [
                    Text(
                      '',
                      style: TextStyle(fontSize: 4),
                    ),

                    //누적금액 Cumulative Graph
                    // Container(
                    //   width: double.infinity,
                    //   // height: 2,
                    //   child: CumulativeGraph(
                    //     title: 'g',
                    //   ),
                    // )
                  ],
                ),
                //절약금액 수정 사항(w/Controller)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //(w/Controller)
                    Text(
                      '총 75,000원',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),    
          ),
        ],
      ),
        
    );
  
  }
}

// 로고 누르면 메인으로 돌아가게 함 (기능 추가)
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        var controller = Get.find<DetailController>();
        controller.goToMain();
      },
      icon: Image.asset(
        'assets/images/logo-image.png',
        // height: 2000,
      ),
      iconSize: 250,
    );
  }
}

class chartWidget extends StatelessWidget {
  List<double> points = [0, 0, 3000, 3000, 6000, 9000, 12000, 12000];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: CustomPaint(
                    size: Size(300, 150),
                    foregroundPainter: LineChart(
                        points: points, 
                        pointSize: 10, // 점의 크기를 정합니다. 
                        lineWidth: 3.0, // 선의 굵기를 정합니다.
                        lineColor: Color.fromARGB(255, 130, 153, 255), // 선의 색을 정합니다.
                        pointColor: Color.fromARGB(255, 24, 92, 228))), // 점의 색을 정합니다.
              )
            ],
          ),
        ),
      
    );
  }
}

class LineChart extends CustomPainter {
  List<double> points;
  double lineWidth;
  double pointSize = 3;
  Color lineColor = Colors.black;
  Color pointColor = Colors.blue;
  int maxValueIndex = 0;
  int minValueIndex = 0;
  double fontSize = 15.0;

  LineChart({required this.points, required this.pointSize, required this.lineWidth, required this.lineColor, required this.pointColor});
  

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> offsets = getCoordinates(points, size); // 점들이 그려질 좌표를 구합니다.

    drawText(canvas, offsets); // 텍스트를 그립니다. 최저값과 최고값 위아래에 적은 텍스트입니다. 
    drawLines(canvas, size,  offsets); // 구한 좌표를 바탕으로 선을 그립니다.
    drawPoints(canvas, size, offsets); // 좌표에 따라 점을 그립니다. 
  }

  void drawLines(Canvas canvas, Size size, List<Offset> offsets) {
    Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path(); 

    double dx = offsets[0].dx;
    double dy = offsets[0].dy;

    path.moveTo(dx, dy);
    offsets.map((offset) => path.lineTo(offset.dx , offset.dy)).toList();

    canvas.drawPath(path, paint);
  }

  void drawPoints(Canvas canvas, Size size, List<Offset> offsets) {
    Paint paint = Paint()
        ..color = pointColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = pointSize;

    canvas.drawPoints(PointMode.points, offsets, paint);
  }

  List<Offset> getCoordinates(List<double> points, Size size) {
    List<Offset> coordinates = [];

    double spacing = size.width / (points.length - 1); // 좌표를 일정 간격으로 벌리지 위한 값을 구합니다.
    double maxY = points.reduce(max); // 데이터 중 최소값을 구합니다. 
    double minY = points.reduce(min); // 데이터 중 최대값을 구합니다. 

    double bottomPadding = fontSize * 2; // 텍스트가 들어갈 패딩(아랫쪽)을 구합니다.
    double topPadding = bottomPadding * 2; // 텍스트가 들어갈 패딩(위쪽)을 구합니다.
    double h = size.height - topPadding; // 패딩을 제외한 화면의 높이를 구합니다. 

    for (int index = 0; index < points.length; index++) {
      double x = spacing * index; // x축 좌표를 구합니다. 
      double normalizedY = points[index] / maxY; // 정규화한다. 정규화란 [0 ~ 1] 사이가 나오게 값을 변경하는 것.
      double y = getYPos(h, bottomPadding, normalizedY); // Y축 좌표를 구합니다. 높이에 비례한 값입니다. 

      Offset coord = Offset(x, y);
      coordinates.add(coord);

      findMaxIndex(points, index, maxY, minY); // 텍스트(최대값)를 적기 위해, 최대값의 인덱스를 구해놓습니다. 
      findMinIndex(points, index, maxY, minY); // 텍스트(최소값)를 적기 위해, 최대값의 인덱스를 구해놓습니다. 
    }

    return coordinates;
  }

  double getYPos(double h, double bottomPadding, double normalizedY) => (h + bottomPadding) - (normalizedY * h); 

  void findMaxIndex(List<double> points, int index, double maxY, double minY) {
    if (maxY == points[index]) {
      maxValueIndex = index;
    }
  }

  void findMinIndex(List<double> points, int index, double maxY,double minY) {
    if (minY == points[index]) {
      minValueIndex = index;
    }
  }

  void drawText(Canvas canvas, List<Offset> offsets) {
    String maxValue = points.reduce(max).toString();
    String minValue = points.reduce(min).toString();

    drawTextValue(canvas, minValue, offsets[minValueIndex], false); 
    drawTextValue(canvas, maxValue, offsets[maxValueIndex], true);
  }

  void drawTextValue(Canvas canvas, String text, Offset pos, bool textUpward) {
    TextSpan maxSpan = TextSpan(style: TextStyle(fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.bold), text: text); 
    TextPainter tp = TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
    tp.layout();

    double y = textUpward ? -tp.height * 1.5  : tp.height * 0.5; // 텍스트의 방향을 고려해 y축 값을 보정해줍니다.
    double dx = pos.dx - tp.width / 2; // 텍스트의 위치를 고려해 x축 값을 보정해줍니다.
    double dy = pos.dy + y; 

    Offset offset = Offset(dx, dy);

    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(LineChart oldDelegate) {
    return oldDelegate.points != points;
  }
}

=======
// // import 'package:flutter/material.dart';
// // //import 'package:flutter_pagebuild/view/flutter/dev/bots/utils.dart';

// // import 'package:get/get.dart';
// // import 'package:flutter_pagebuild/controller/DetailController.dart';
// // import 'package:pie_chart/pie_chart.dart';

// // //graph
// // // https://pub.dev/packages/gradient_line_graph/example
// // import 'dart:async';
// // import 'dart:math';

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     double blankHeight = screenHeight * 0.01;
//     double mainHeight = screenHeight * 0.2;
//     double contentWidth = screenWidth * 0.5;
//     double appbarHeight = screenHeight * 0.12;

//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 228, 247, 247),
//       appBar: AppBar(
//         title: const HeaderWidget(),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         toolbarHeight: appbarHeight,
//       ),
//       // resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20), color: Colors.white),
//               // padding: EdgeInsets.all(10),
//               margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

//               // height: mainHeight,
//               child: Column(
//                 // color: Colors.red,
//                 children: [
//                   Container(
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(left: 0),
//                           // padding: EdgeInsets.only(right: 20),
//                           child: Image.asset('assets/images/profile-img.png',
//                               width: contentWidth, 
//                               fit: BoxFit.contain
//                           ),
//                         ),
//                         Container(
//                           width: 1,
//                           height: 130,
//                           color: Colors.grey,
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 10),
//                           // alignment: Alignment.center,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               //챌린지 시작 날짜
//                               Text(
//                                 '챌린지 시작날짜',
//                                 style: TextStyle(
//                                     fontSize: 23, color: Colors.purple),
//                               ),
//                               //여백
//                               Text(
//                                 '',
//                                 style: TextStyle(fontSize: 10),
//                               ),
//                               //(w/controller)
//                               Text(
//                                 '2023.03.22',
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                               Text(
//                                 '',
//                                 style: TextStyle(fontSize: 30),
//                               ),
//                               //남은 날짜
//                               Text(
//                                 '남은 날짜',
//                                 style: TextStyle(
//                                     fontSize: 23, color: Colors.purple),
//                               ),
//                               //여백
//                               Text(
//                                 '',
//                                 style: TextStyle(fontSize: 10),
//                               ),
//                               //(w/controller)
//                               Text(
//                                 'D-20',
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 30),
//                     child: Row(
//                       children: [
//                         //(w/Controller)
//                         Text(
//                           'OOO',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         //고정
//                         Text('님의 커피 1잔 평균 금액은 ',
//                             style: TextStyle(color: Colors.grey)),
//                         //(w/Controller)
//                         Text('5,000', style: TextStyle(color: Colors.grey)),
//                         //고정
//                         Text('원 입니다.', style: TextStyle(color: Colors.grey))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),


// //     return Scaffold(
// //       backgroundColor: Color.fromARGB(255, 228, 247, 247),
// //       appBar: AppBar(
// //         title: const HeaderWidget(),
// //         centerTitle: true,
// //         backgroundColor: Colors.white,
// //         toolbarHeight: 130,
// //       ),
// //       // resizeToAvoidBottomInset: false,
// //       body: SingleChildScrollView(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           children: <Widget>[
// //             Container(
// //               decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(20), color: Colors.white),
// //               // padding: EdgeInsets.all(10),
// //               margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
// //               height: startHeight,
// //               child: Column(
// //                 // color: Colors.red,
// //                 children: [
// //                   Container(
// //                     child: Row(
// //                       // mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Container(
// //                           margin: EdgeInsets.only(left: 0),
// //                           // padding: EdgeInsets.only(right: 20),
// //                           child: Image.asset('assets/images/profile-img.png',
// //                               width: contentWidth, fit: BoxFit.contain),
// //                         ),
// //                         Container(
// //                           width: double.infinity,
// //                           // height: 130,
// //                           color: Colors.grey,
// //                         ),
// //                         Container(
// //                           padding: EdgeInsets.only(left: 10),
// //                           // alignment: Alignment.center,
// //                           child: Column(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               //챌린지 시작 날짜
// //                               Text(
// //                                 '챌린지 시작 날짜',
// //                                 style: TextStyle(
// //                                     fontSize: 23, color: Colors.purple),
// //                               ),
// //                               //여백
// //                               Text(
// //                                 '',
// //                                 style: TextStyle(fontSize: 10),
// //                               ),
// //                               //(w/controller)
// //                               Text(
// //                                 '2023.03.22',
// //                                 style: TextStyle(fontSize: 20),
// //                               ),
// //                               Text(
// //                                 '',
// //                                 style: TextStyle(fontSize: 30),
// //                               ),
// //                               //남은 날짜
// //                               Text(
// //                                 '남은 날짜',
// //                                 style: TextStyle(
// //                                     fontSize: 23, color: Colors.purple),
// //                               ),
// //                               //여백
// //                               Text(
// //                                 '',
// //                                 style: TextStyle(fontSize: 10),
// //                               ),
// //                               //(w/controller)
// //                               Text(
// //                                 'D-20',
// //                                 style: TextStyle(fontSize: 20),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Container(
// //               // padding: EdgeInsets.only(left: 30),
// //               width: screenWidth * 0.95,
// //               // color: Colors.amber,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   SizedBox(
// //                     height: 40,
// //                     child: //Detail 글자 부분
// //                         Text('Detail',
// //                             style: TextStyle(fontSize: 30, color: Colors.grey)),
// //                   ),

// //                   //>적금 총액
// //                   Container(
// //                     padding: EdgeInsets.all(7),
// //                     decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(20),
// //                         color: Colors.white),
// //                     width: screenWidth,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           '',
// //                           style: TextStyle(fontSize: 8),
// //                         ),
// //                         Row(
// //                           children: [
// //                             Text('> 적금 누적금액',
// //                                 style: TextStyle(
// //                                     fontSize: 20, color: Colors.purple)),
// //                             Spacer(),
// //                             Text(
// //                               '(기준 : 소비 후 적금)',
// //                               style:
// //                                   TextStyle(fontSize: 10, color: Colors.grey),
// //                             ),
// //                           ],
// //                         ),
// //                         Text(
// //                           '',
// //                           style: TextStyle(fontSize: 4),
// //                         ),
// //                         //적금총액 세부사항 (w/Controller)
// //                         Column(
// //                           children: [
// //                             Text(
// //                               '',
// //                               style: TextStyle(fontSize: 4),
// //                             ),

// //                             //누적금액 Cumulative Graph
// //                             // Container(
// //                             //   width: double.infinity,
// //                             //   // height: 2,
// //                             //   child: CumulativeGraph(
// //                             //     title: 'g',
// //                             //   ),
// //                             // )
// //                           ],
// //                         ),
// //                         //절약금액 수정 사항(w/Controller)
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.end,
// //                           children: [
// //                             //(w/Controller)
// //                             Text(
// //                               '총 75,000원',
// //                               style: TextStyle(
// //                                   fontSize: 17,
// //                                   color: Colors.black87,
// //                                   fontWeight: FontWeight.bold),
// //                               textAlign: TextAlign.right,
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     height: blankHeight,
// //                   ),

// //                   //적금한 일수
// //                   Container(
// //                     padding: EdgeInsets.all(7),
// //                     decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(20),
// //                         color: Colors.white),
// //                     width: screenWidth,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           '',
// //                           style: TextStyle(fontSize: 8),
// //                         ),
// //                         Row(
// //                           children: [
// //                             Text('>적금한 일수',
// //                                 style: TextStyle(
// //                                     fontSize: 20, color: Colors.purple)),
// //                             Spacer(),
// //                             Text(
// //                               '(기준 : 무지출 + 유지출무적금)',
// //                               style:
// //                                   TextStyle(fontSize: 10, color: Colors.grey),
// //                             ),
// //                           ],
// //                         ),
// //                         Text(
// //                           '',
// //                           style: TextStyle(fontSize: 4),
// //                         ),
// //                         //적금총액 세부사항 (w/Controller)
// //                         Column(
// //                           children: [
// //                             Row(
// //                               children: [
// //                                 //고정
// //                                 Text('무지출 :  '),
// //                                 //(w/Controller)
// //                                 Text(
// //                                   '100',
// //                                   style: TextStyle(
// //                                       color: Colors.red,
// //                                       fontStyle: FontStyle.italic),
// //                                 ),
// //                                 //고정
// //                                 Text('%'),
// //                               ],
// //                             ),
// //                             Text(
// //                               '',
// //                               style: TextStyle(fontSize: 4),
// //                             ),
// //                             Row(
// //                               children: [
// //                                 //고정
// //                                 Text('유지출 유적금 :  '),
// //                                 //(w/Controller)
// //                                 Text(
// //                                   '100',
// //                                   style: TextStyle(
// //                                       color: Colors.red,
// //                                       fontStyle: FontStyle.italic),
// //                                 ),
// //                                 //고정
// //                                 Text('%'),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                         //총 (w/Controller)
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.end,
// //                           children: [
// //                             //고정
// //                             Text('총 ',
// //                                 style: TextStyle(
// //                                     fontSize: 17,
// //                                     color: Colors.black87,
// //                                     fontWeight: FontWeight.bold)),
// //                             //(w/Controller)
// //                             Text(
// //                               '100',
// //                               style: TextStyle(
// //                                   fontSize: 17,
// //                                   color: Colors.black87,
// //                                   fontWeight: FontWeight.bold),
// //                             ),
// //                             //고정
// //                             Text('%',
// //                                 style: TextStyle(
// //                                     fontSize: 17,
// //                                     color: Colors.black87,
// //                                     fontWeight: FontWeight.bold)),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     height: blankHeight,
// //                   ),
// //                   //>스탬프 갯수 Box
// //                   Container(
// //                     padding: EdgeInsets.all(7),
// //                     decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(20),
// //                         color: Colors.white),
// //                     width: screenWidth,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Row(
// //                           children: [
// //                             Text('>스탬프 갯수',
// //                                 style: TextStyle(
// //                                     fontSize: 20, color: Colors.purple)),
// //                             Spacer(),
// //                             Text(
// //                               '(기준 : 무지출 + 유지출무적금)',
// //                               style:
// //                                   TextStyle(fontSize: 10, color: Colors.grey),
// //                             ),
// //                           ],
// //                         ),
// //                         Text(
// //                           '',
// //                           style: TextStyle(fontSize: 30),
// //                         ),
// //                         //적금 stamp 갯수
// //                         Row(
// //                           children: [
// //                             Container(
// //                               width: contentWidth * 0.7,
// //                               child: Image.asset(
// //                                 'assets/images/money-stamp.png',
// //                                 fit: BoxFit.contain,
// //                               ),
// //                             ),
// //                             //고정
// //                             Text(
// //                               ' ',
// //                               style: TextStyle(fontSize: 80),
// //                             ),
// //                             Text(
// //                               'X',
// //                               style: TextStyle(fontSize: 30),
// //                             ),
// //                             Text(
// //                               ' ',
// //                               style: TextStyle(fontSize: 50),
// //                             ),
// //                             //(w/Controller)
// //                             Text(
// //                               '3',
// //                               style: TextStyle(fontSize: 50),
// //                             ),
// //                           ],
// //                         ),
// //                         //당근 스탬프
// //                         Row(
// //                           children: [
// //                             Container(
// //                               width: contentWidth * 0.7,
// //                               child: Image.asset(
// //                                 'assets/images/carrot-stamp.png',
// //                                 fit: BoxFit.contain,
// //                               ),
// //                             ),
// //                             //고정
// //                             Text(
// //                               ' ',
// //                               style: TextStyle(fontSize: 80),
// //                             ),
// //                             Text(
// //                               'X',
// //                               style: TextStyle(fontSize: 30),
// //                             ),
// //                             Text(
// //                               ' ',
// //                               style: TextStyle(fontSize: 50),
// //                             ),
// //                             //(w/Controller)
// //                             Text(
// //                               '3',
// //                               style: TextStyle(fontSize: 50),
// //                             ),
// //                           ],
// //                         ),
// //                         //토끼가 당근 먹는 Stamp
// //                         Row(
// //                           children: [
// //                             Container(
// //                               width: contentWidth * 0.7,
// //                               child: Image.asset(
// //                                 'assets/images/rabbit-stamp.png',
// //                                 fit: BoxFit.contain,
// //                               ),
// //                             ),
// //                             //고정
// //                             Text(
// //                               ' ',
// //                               style: TextStyle(fontSize: 80),
// //                             ),
// //                             Text(
// //                               'X',
// //                               style: TextStyle(fontSize: 30),
// //                             ),
// //                             Text(
// //                               ' ',
// //                               style: TextStyle(fontSize: 50),
// //                             ),
// //                             //(w/Controller)
// //                             Text(
// //                               '3',
// //                               style: TextStyle(fontSize: 50),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),

// //                   SizedBox(
// //                     height: blankHeight,
// //                   ),
// //                   //>예상 우대 이율
// //                   // --> 이걸 뺴고 달성율을 소비 적금 기준으로 나눠서 하기.(자세하게)
// //                   //아이콘을 넣는다거나 박스처리를 하거나 글자를 조금더 색깔 다르게 글자 크기 차이 주고
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: BottomAppBar(
// //         child: Row(
// //           children: [
// //             // ElevatedButton(
// //             //   onPressed: () {
// //             //     Get.find<DetailController>().goToMain();
// //             //   },
// //             //   child: const Text('goToMain'),
// //             // ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // 로고 누르면 메인으로 돌아가게 함 (기능 추가)
// // class HeaderWidget extends StatelessWidget {
// //   const HeaderWidget({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return IconButton.filled(
// //       onPressed: () {
// //         var controller = Get.find<DetailController>();
// //         controller.goToMain();
// //       },
// //       icon: Image.asset(
// //         'assets/images/logo-image.png',
// //         // height: 2000,
// //       ),
// //       iconSize: 200,
// //     );
// //   }
// // }


//   @override
//   Widget build(BuildContext context) {
//     return IconButton.filled(
//       onPressed: () {
//         var controller = Get.find<DetailController>();
//         controller.goToMain();
//       },
//       icon: Image.asset(
//         'assets/images/logo-image.png',
//         // height: 2000,
//       ),
//       iconSize: 250,
//     );
//   }
// }

>>>>>>> Stashed changes
