import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagebuild/controller/RankController.dart';
import 'package:get/get.dart';
import 'package:flutter_pagebuild/controller/MainController.dart';
// import 'package:sorted_list/sorted_list.dart';
import 'package:categorized_dropdown/categorized_dropdown.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RankView extends StatelessWidget {
  RankView({Key? key}) : super(key: key);

  final controller = Get.find<RankController>();

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<RankController>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 247, 247),

      appBar: AppBar(
        title: const HeaderWidget(),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 130,
      ),

      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 더보기버튼
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       SeeMoreBtn(),
            //     ],
            //   ),
            // ),

            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.amberAccent,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              // color: Colors.amberAccent,
              height: 40,
              width: double.infinity,
              alignment: Alignment.center,
              // "내 토끼의 뜀박질 랭킹은 몇위?"
              child: Text(
                '🐰🥕내 토끼의 뜀박질 랭킹은 몇 위?',
                style: TextStyle(fontSize: 20),
              ),
            ),

            //평균Raabit 지속시간 큰 Container
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 236, 241, 217), width: 3),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white),
              // color: Colors.black26,

              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: [
                  //평균 Rabbit Text
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Color.fromARGB(255, 236, 241, 217)),
                    // width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '평균 Rabbit 지속 시간 🕒',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87),
                          ),
                          Text(
                            '',
                            style: TextStyle(fontSize: 5),
                          ),
                          Row(
                            children: [
                              Text(
                                '상위%    기간',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black45),
                              ),
                              Spacer(),
                              Text(
                                '(월)',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black45),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  //평균 Rabbit Graph
                  //(w/Controller)

                  Container(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: RankGraph1()),
                  ),
                ],
              ),
            ),
            //Rabbit 모은 금액 Text

            //2
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 255, 242, 197), width: 3),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white),
              // color: Colors.black26,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: [
                  //평균 Rabbit Text
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Color.fromARGB(255, 255, 242, 197)),
                    // width: double.infinity,
                    // color: Color.fromARGB(255, 255, 242, 197),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Rabbit으로 모은 금액 ✨',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87),
                          ),
                          Text(
                            '',
                            style: TextStyle(fontSize: 5),
                          ),
                          Row(
                            children: [
                              Text(
                                '상위%    금액',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black45),
                              ),
                              Spacer(),
                              Text(
                                '(단위: 만원)',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black45),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  //끝 ㅋ

                  //평균 Rabbit Graph
                  //(w/Controller)

                  Container(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: RankGraph2()),
                  ),
                ],
              ),
            ),

            //Rabbit 모은 금액 Graph
            //(w/Controller)

            // Container(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Get.find<RankController>().goToMain();
            //     },
            //     child: Text('goToMain'),
            //   ),
            // )
          ],
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.share),
      //       label: '친구에게 공유하기',
      //     ),
      //   ],
      // ),
    );
  }
}

//평균 Rabbit Graph
class RankGraph1 extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RankGraph1({Key? key}) : super(key: key);

  @override
  RankGraph1State createState() => RankGraph1State();
}

class RankGraph1State extends State<RankGraph1> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      //아래는 고정값
      _ChartData('~40%', 2.4, Colors.grey),
      _ChartData('~20%', 5, Colors.grey),
      _ChartData('~10%', 7, Colors.grey),

      //Controller, Data 유기적으로 작동해야 할 부분
      _ChartData('~5%🥕', 10, Colors.blue)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(minimum: 0, maximum: 12, interval: 1),
      tooltipBehavior: _tooltip,
      series: <ChartSeries<_ChartData, String>>[
        BarSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          pointColorMapper: (_ChartData data, _) => data.color,
          name: 'Period',
          width: 0.4,
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

//Rabbit 모은 금액 Graph
class RankGraph2 extends StatefulWidget {
  RankGraph2({Key? key}) : super(key: key);

  @override
  RankGraph2State createState() => RankGraph2State();
}

class RankGraph2State extends State<RankGraph2> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      //고정값
      _ChartData('~40%', 10, Colors.grey),
      _ChartData('~20%', 30, Colors.grey),
      //Controller, Data 유기적으로 작동해야 할 부분
      _ChartData('~10%🥕', 40, Colors.orange),
      //고정값
      _ChartData('~5%', 80, Colors.grey),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(minimum: 0, maximum: 100, interval: 10),
      tooltipBehavior: _tooltip,
      series: <ChartSeries<_ChartData, String>>[
        BarSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          pointColorMapper: (_ChartData data, _) => data.color,
          name: 'Gold',
          width: 0.4,
        ),
      ],
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
        var controller = Get.find<RankController>();
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
