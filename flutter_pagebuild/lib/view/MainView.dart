import 'package:flutter/material.dart';
import 'package:flutter_pagebuild/DB/outdated/useroutdated.dart';
import 'package:provider/provider.dart';

import 'package:flutter_pagebuild/controller/MainController.dart';
import 'package:flutter_pagebuild/model/MainModel.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'dart:isolate';
import 'package:get/get.dart';
import 'dart:math';
import 'package:pie_chart/pie_chart.dart';

import 'package:flutter_pagebuild/controller/thread.dart';

final controller = Get.find<MainController>();

//ChangeNotifierProvider 의 위젯으로 반환(view 없음)
class MainView extends StatelessWidget {
  final ReceivePort receivePort = ReceivePort();

  MainView({Key? key}) : super(key: key) {
    resetMainModel reset = resetMainModel();
    if (!reset.getThreadCon) {
      spawnNewIsolate();
      receivePort.listen((message) {
        if (message) {
          print(message);
        } else {
          print(message);
        }
      });
    }
  }

  void spawnNewIsolate() async {
    await Isolate.spawn(myTask, receivePort.sendPort);
  }

  @override
  Widget build(BuildContext context) {
    //초기값 설정용
    controller.reset.setPieChartMap();

    return ChangeNotifierProvider<resetMainModel>(
      create: (context) => resetMainModel(),
      child: MaterialApp(
        title: 'Flutter Chart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: '아리따-돋움',
        ),
        home: const MyHomePage(title: 'Flutter Chart'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double blankHeight = screenHeight * 0.02;
    double blankWidth = screenWidth * 0.08;
    double startHeight = screenHeight * 0.08;
    double contentWidth = screenWidth * 0.8;
    double imageHeight = screenHeight * 0.25;


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: startHeight,
              ),
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Color.fromARGB(255, 223, 223, 223),
                  // ),
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 27, 69, 245),
                ),
                child: Text(
                  '커피 사먹지 않기 도전 중 ⏳',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
              ),

              // const HeaderWidget(),
              Stack(
                children: [
                  Image.asset(
                    'assets/images/main-image.png',
                    height: imageHeight,

                  ),
                  Positioned(
                    top: startHeight*0.25,
                    left: 0,
                    right: screenWidth*0.4,
                    child: Column(
                      children: [
                        UserWidget(),
                        // 마이페이지 버튼
                        TextButton(
                          onPressed: () {
                            controller.goToDetail();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          child: const Text('마이페이지'),
                        ),

                        
                      ],
                    ),
                  ),
                ],
              ),
              
              
              // 랭킹 및 현황 버튼들
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            const Color.fromARGB(255, 230, 239, 255)),
                      ),
                      onPressed: () {
                        //controller.reset.temptest();
                        controller.goToRank();
                      },
                      child: const Text(
                        '랭킹보기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: blankWidth,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.goToStamp();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            const Color.fromARGB(255, 223, 241, 233)),
                      ),
                      child: const Text(
                        '스탬프 보기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: blankHeight,
              ),

              Consumer<resetMainModel>(builder: (context, resetmodel, child) {
                return
                    // 달성률 관련 위젯들 묶음
                    Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 234, 244, 255),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 209, 209, 209)
                                .withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 7), // changes position of shadow
                          ),
                        ],
                      ),
                      width: screenWidth,
                      height: screenHeight * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: blankHeight,
                          ),
                          // 달성률 현황
                          //const 삭제했음 - 담비
                          Text(
                            '현재 달성률 ${controller.reset.getSucSavRate}% 🏃‍♀️',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 0, 113, 206),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          // !! 성공률 변수 넣기 !!
                          Text(
                            '챌린지성공 ${controller.reset.getSucRate} % + 적금 ${controller.reset.getsavinRate}%',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 60,
                      child: PieChart(
                        // 달성률 차트
                        chartType: ChartType.ring,

                        dataMap: controller.reset.getPieChartMap,

                        animationDuration: const Duration(milliseconds: 800),
                        colorList: colorList,
                        chartLegendSpacing: 50,
                        chartRadius: contentWidth / 3,
                        initialAngleInDegree: 0,
                        ringStrokeWidth: 60,

                        // 범례
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: false,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                            chartValueStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                );
              }), //스택종료

              // 현재 진행중인 챌린지 및 이미지
              
            ],
          ),
        ),
      ),
    );
  }
}

// !! 비율 데이터 여기에 넣으면 된다 !!
// 파이차트 데이터 Controller에서 가져올 것임

// 파이차트 색상
final colorList = <Color>[
  const Color.fromARGB(255, 68, 136, 255),
  const Color.fromARGB(255, 148, 218, 255),
  const Color.fromARGB(255, 157, 157, 157),
];

// 헤더위젯 - 삭제

// 유저위젯
class UserWidget extends StatelessWidget {
  late final Future<String> _usernameFuture;
  UserWidget({Key? key})
      : _usernameFuture = controller.reset.getUser,
        super(key: key);

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FutureBuilder<String>(
                    future: _usernameFuture,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      // 연결 중 상태 처리
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // 오류 상태 처리
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // 데이터가 있는 경우의 처리
                      return Consumer<resetMainModel>(
                        builder: (context, counter, child) {
                          return Text(
                            '\n${snapshot.data}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          );
                        },
                      );
                    }),
                const Text(
                  ' 님',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                
              ],
            ),
            
          ],
        ),
      ],
    );
  }
}
