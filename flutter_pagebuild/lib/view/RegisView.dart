import 'dart:convert';
import 'dart:math';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pagebuild/model/RegisModel.dart';
import 'package:get/get.dart';
import 'package:flutter_pagebuild/controller/RegisController.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_pagebuild/view/MainView.dart';
import 'package:provider/provider.dart';

final controller = Get.find<RegisController>();
AccountList acList = AccountList();
pickChallenge pickchallinst = pickChallenge();

class RegisView extends StatelessWidget {
  const RegisView({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appbarHeight = screenHeight * 0.12;
    //초기값 설정용
    //controller.reset.resetPieChartMap();
    return MaterialApp(
      theme: ThemeData(
        fontFamily: '아리따-돋움',
      ),
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background-img.png'), // 배경 이미지
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const HeaderWidget(),
            centerTitle: true,
            backgroundColor: Colors.white,
            toolbarHeight: appbarHeight,
          ),
          body: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // 페이지에 들어갈 위젯들
                  StartPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 헤더위젯
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(context) {
    //   double screenHeight = MediaQuery.of(context).size.height;
    //   double appbarHeight = screenHeight * 0.15;

    return Image.asset(
      'assets/images/logo-image.png',
      height: 100,
    );
  }
}

// 첫번째 페이지

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonHeight = screenHeight * 0.1;
    double buttonHeight2 = screenHeight * 0.05;

    double imageHeight = screenHeight * 0.4;
    double startHeight = screenHeight * 0.1;
    double blankHeight = screenHeight * 0.02;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: startHeight,
          ),
          SizedBox(
            height: buttonHeight,
            width: 200,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.blue,
              highlightColor: const Color.fromARGB(255, 0, 72, 255),
              // 클릭시 색상 다르게 표현
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  CustomRoute(
                    builder: (BuildContext context) => const SecondScreen(),
                    settings: const RouteSettings(),
                  ),
                );
              },

              child: const Text(
                'Re-Habbit\n생성하기',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: blankHeight,
          ),

          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            child: const Text('로그인하기'),

            onPressed: () {
              // RegisController().goToMainTest();
              // 성공 팝업
              showDialog(
                context: context,
                
                barrierDismissible: true,
                builder: (BuildContext context) {
                  double screenWidth = MediaQuery.of(context).size.width;
                  double screenHeight = MediaQuery.of(context).size.height;

                  return AlertDialog(
                    
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    //Dialog Main Title
                    title: const Column(
                      
                      children: <Widget>[
                        Text("로그인"),
                      ],
                    ),
                    //
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '이름을 입력해주세요.\n',
                          style: TextStyle(
                            fontSize: 22,
                          ),),
                        
                        // 여기에 로그인 기능 구현
                        SizedBox(
                          width: screenWidth * 0.3,
                          height: screenHeight *0.05,
                          child: TextField(
                            decoration: const InputDecoration(
                              // labelText: 'ex) 김신한',
                              border: OutlineInputBorder(),
                            ),
                            controller: _inputName,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          RegisController().goToMainTest();
                        }, 
                        child: const Text("확인(제출성공)"),
                      ),
                      // (controller.verif(inputVeriN.text))
                      
                      OutlinedButton(
                        child: const Text("확인(실패)"),
                        onPressed: () {
                          // 다시 인증문구 페이지로
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Column(
                                  children: <Widget>[
                                    new Text("로그인 실패"),
                                  ],
                                ),
                                //
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "등록되지 않은 사용자입니다.",
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  new OutlinedButton(
                                    child: new Text("뒤로"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        },
                      ),
                    ],
                  );
                }
              );
            },
            
            
            
          ),


          SizedBox(
            height: imageHeight,
            child: Image.asset(
              'assets/images/profile-img.png',
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}



// 두번째 페이지 - 이름 받기 -> 계좌 받기로 수정(인증용)

//계좌 받기 위한 변수
TextEditingController _inputName = TextEditingController();
TextEditingController _inputAccount = TextEditingController();
TextEditingController _inputBank = TextEditingController();

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double appbarHeight = screenHeight * 0.12;
    double blankHeight = screenHeight * 0.03;
    double startHeight = screenHeight * 0.15;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const HeaderWidget(),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: appbarHeight,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: startHeight,
            ),
            // 이름 입력 위젯
            SizedBox(
              width: screenWidth * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. 이름을 입력해주세요',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: blankHeight,
                  ),
                  SizedBox(
                    width: screenWidth * 0.35,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'ex) 김신한',
                        border: OutlineInputBorder(),
                      ),
                      controller: _inputName,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: blankHeight,
            ),

            // 계좌 입력 위젯
            SizedBox(
              width: screenWidth * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '2. 사용하고 계신 계좌를 알려주세요.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: blankHeight,
                  ),
                  const SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BankDropdownButton(),
                        AccountNum(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: blankHeight,
                  ),
                ],
              ),
            ),

            // 제출 버튼
            SizedBox(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      if (!controller.setUser(_inputName.text, _inputBank.text,
                          _inputAccount.text)) {
                        return;
                      }
                      controller.setUser(
                          _inputName.text, _inputBank.text, _inputAccount.text);
                      // 조회 후 다음 단계로
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        //push: 다음 화면을 쌓겠다는 의미
                        CustomRoute(
                          builder: (BuildContext context) => const AuthScreen(),
                          settings:
                              const RouteSettings(), //materialpageroute: navigator가 이동할 경로 지정
                        ),
                      );
                    },
                    child: const Text('제출'))
              ],
            ))
          ],
        )));
  }
}

// 화면 전환 커스텀
class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/') return child;

    return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: child);
  }
}

// 인풋 받기 : 이름 & 계좌
class AccountNum extends StatefulWidget {
  const AccountNum({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountNumState();
}

class _AccountNumState extends State<AccountNum> {
  // Widget _buildNumberTextField() {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double textWidth = screenWidth * 0.5;
    return SizedBox(
      width: textWidth,
      child: TextField(
        controller: _inputAccount,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

// 계좌 인증 페이지
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final int _radioVal = 0;
  @override
  TextEditingController inputVeriN = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisController>();
    double screenHeight = MediaQuery.of(context).size.height;
    double appbarHeight = screenHeight * 0.12;
    double screenWidth = MediaQuery.of(context).size.width;
    double blankHeight = screenHeight * 0.05;
    double startHeight = screenHeight * 0.15;
    

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const HeaderWidget(),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: appbarHeight,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: startHeight,
            ),
            const Text(
              '입력하신 계좌로 1원을 송금하였습니다.\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Text(
              '받으신 인증문구를 입력해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            SizedBox(
              height: blankHeight * 0.5,
            ),
            SizedBox(
              width: screenWidth * 0.5,
              child: TextField(
                  controller: inputVeriN,
                  decoration: const InputDecoration(
                    labelText: 'ex) 파란토끼',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text),
            ),
            SizedBox(
              height: blankHeight * 0.5,
            ),
            // 인풋값과 인증문구를 비교
            // 맞는 경우
            OutlinedButton(
              onPressed: () {
                // 성공 팝업
                showDialog(
                    context: context,
                    //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        //Dialog Main Title
                        title: const Column(
                          children: <Widget>[
                            Text("계좌 인증"),
                          ],
                        ),
                        //
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            (controller.verif(inputVeriN.text))
                                ? const Text("인증에 성공하였습니다.")
                                : const Text("인증에 실패하였습니다."),
                          ],
                        ),
                        actions: <Widget>[
                          (controller.verif(inputVeriN.text))
                              ? OutlinedButton(
                                  child: const Text("확인"),
                                  onPressed: () {
                                    // 성공시 다음 페이지로
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      CustomRoute(
                                        builder: (BuildContext context) =>
                                            trackAccScreen(),
                                        settings: const RouteSettings(),
                                      ),
                                    );
                                  },
                                )
                              : OutlinedButton(
                                  child: const Text("뒤로"),
                                  onPressed: () {
                                    // 다시 인증문구 페이지로
                                    Navigator.pop(context);
                                  },
                                ),
                        ],
                      );
                    });
              },
              child: const Text('인증하기'),
            ),
            // 인증 실패한 경우
          ],
        ),
      ),
    );
  }
}

//여기 계좌 선택

int? selectedRow;

// 입출금 계좌 조회 및 선택
class trackAccScreen extends StatelessWidget {
  AccountList acList = AccountList();
  trackAccScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appbarHeight = screenHeight * 0.12;
    double blankHeight = screenHeight * 0.1;

    return Scaffold(
        appBar: AppBar(
          title: const HeaderWidget(),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: appbarHeight,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${controller.checkInfo.registName} 님 환영합니다!\n',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                '조회할 입출금계좌 선택하기',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              // DataTableExample(),

              AccountTable2(),

              const SizedBox(
                height: 20,
              ),

              OutlinedButton(
                onPressed: () {
                  if (selectedRow != null) {
                    acList.setaccountConsum(selectedRow);
                    // 다음 단계로
                    selectedRow = null;
                    Navigator.of(context).push(
                      CustomRoute(
                        builder: (BuildContext context) =>
                            const ChallSelectScreen(),
                        settings: const RouteSettings(),
                      ),
                    );
                  } else {
                    return;
                  }
                },
                child: const Text(
                  '제출',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ),
              SizedBox(
                height: blankHeight,
              ),
            ],
          ),
        ));
  }
}

//2가 입출금
class AccountTable2 extends StatefulWidget {
  AccountTable2({super.key});

  //ac리스트 재 생성
  AccountList acList = AccountList();
  @override
  _AccountTableState2 createState() => _AccountTableState2();
}

class _AccountTableState2 extends State<AccountTable2> {
  AccountList acList = AccountList();

  late Future<List<dynamic>> _accListFuture;
  @override
  void initState() {
    super.initState();

    _accListFuture = acList.setAccountList(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        
        child: Card(
            elevation: 4.0,
            child: FutureBuilder<List<dynamic>>(
                future: _accListFuture, //Future-객체 ->
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  // 연결 중인 경우
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      child: Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                    // 로딩 인디케이터 표시
                  }
                  // 에러 발생 시
                  else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  // 데이터가 준비되면
                  else {
                    return Column(
                      
                      children: <Widget>[
                        
                        // ListView.builder를 사용하여 동적으로 아이템 생성
                        ListView.builder(
                          
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final account = snapshot.data![index];
                            return ListTile(
                              
                              title: Text(account.accName),
                              subtitle: Text('계좌번호: ${account.accNum}'),
                              trailing: Text('${account.accNum}'),
                              tileColor: selectedRow == index
                                  ? const Color.fromARGB(255, 150, 208, 255)
                                  : null, // 선택된 로우에 색상 적용
                              onTap: () {
                                setState(() {
                                  if (selectedRow == index) {
                                    selectedRow =
                                        null; // 이미 선택된 로우를 다시 탭하면 선택 해제
                                  } else {
                                    selectedRow = index; // 새로운 로우를 선택
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ],
                    );
                  }
                })));
  }
}

// 챌린지 선택하기 페이지
class ChallSelectScreen extends StatefulWidget {
  const ChallSelectScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChallSelectScreenState();
}

class _ChallSelectScreenState extends State<ChallSelectScreen> {
  int radioVal = 0;
  AccountList acList = AccountList();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double blankHeight = screenHeight * 0.02;
    double startHeight = screenHeight * 0.05;

    double itemWidth = screenWidth * 0.8;
    double appbarHeight = screenHeight * 0.12;

    //pickchallinst.setconsumList();

    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: appbarHeight,
        leadingWidth: 10,

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: startHeight,
                ),
                Container(
                  width: itemWidth,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    textAlign: TextAlign.center,
                    '🔎 선택하신 [${acList.getaccountConsum?.accName}] 계좌의 소비내역을 바탕으로 구성했어요',
                    // '선택하신 ${acList.getaccountConsum?.bank} ${acList.getaccountConsum?.accNum} 계좌에서 발생한 소비내역을 바탕으로 구성했어요🔎',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Text(
                  '\n참여할 챌린지를 선택하세요.',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: blankHeight,
                ),
                SizedBox(
                  width: itemWidth,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        bool isEnabled = true;

                        return InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedRow == index) {
                                  selectedRow = null; // 이미 선택된 로우를 다시 탭하면 선택 해제
                                } else {
                                  selectedRow = index; // 새로운 로우를 선택
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                color: selectedRow == index
                                    ? Color.fromARGB(255, 204, 230, 255)
                                    : const Color.fromARGB(
                                        255, 255, 255, 255), // 조건부로 배경색 결정
                                borderRadius:
                                    BorderRadius.circular(10), // 모서리 둥글기 값 설정
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      //소비 종류와 관련된 버튼
                                      pickchallinst.getconsumLabel[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: isEnabled
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: selectedRow == index
                                            //색은 바꿔주세용
                                            ? Color.fromARGB(255, 155, 255, 186)
// 조건부로 배경색 결정

                                            : Color.fromARGB(255, 214, 255, 237), // 조건부로 배경색 결정

                                        borderRadius: BorderRadius.circular(
                                            10), // 모서리 둥글기 값 설정
                                      ),
                                      child: Text(
                                        // '# test',
                                        '# ${pickchallinst.getconsumList[index]}', // 여기에 원하는 텍스트를 넣으십시오.
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isEnabled
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }),
                ),
                SizedBox(
                  height: blankHeight,
                ),
                OutlinedButton(
                  onPressed: () {
                    // 다음 단계로
                    Navigator.of(context).push(
                      CustomRoute(
                        builder: (BuildContext context) => AccSelectScreen(),
                        settings: const RouteSettings(),
                      ),
                    );
                  },
                  child: const Text(
                    '제출',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 라디오 버튼에 대한 레이블을 반환하는 함수

// 적금계좌 조회 및 선택
class AccSelectScreen extends StatelessWidget {
  AccSelectScreen({super.key});
  AccountList acList = AccountList();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appbarHeight = screenHeight * 0.12;
    double blankHeight = screenHeight * 0.1;

    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: appbarHeight,
        leadingWidth: 10,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${controller.checkInfo.registName} 님 환영합니다!\n',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Text(
              '연동할 적금 계좌 선택하기',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            // DataTableExample(),

            const AccountTable(),

            OutlinedButton(
              onPressed: () {
                if (selectedRow != null) {
                  // 다음 단계로
                  acList.setaccountSaving(selectedRow);
                  selectedRow = null;
                  Navigator.of(context).push(
                    CustomRoute(
                      builder: (BuildContext context) =>
                          const AmountSelectScreen(),
                      settings: const RouteSettings(),
                    ),
                  );
                }
              },
              child: const Text(
                '선택',
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
            ),
            SizedBox(
              height: blankHeight,
            ),
          ],
        ),
      ),
    );
  }
}

//적금 리스트업
class AccountTable extends StatefulWidget {
  const AccountTable({super.key});

  @override
  _AccountTableState createState() => _AccountTableState();
}

class _AccountTableState extends State<AccountTable> {
  // 선택된 로우의 인덱스를 저장하는 변수
  AccountList acList = AccountList();
  late Future<List<dynamic>> _accListFuture;
  @override
  void initState() {
    super.initState();

    _accListFuture = acList.setAccountList(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
          elevation: 4.0,
          child: FutureBuilder<dynamic>(
            future: _accListFuture, //Future-객체 ->
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  child: Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  children: <Widget>[
                    // ListView.builder를 사용하여 동적으로 아이템 생성
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final account = snapshot.data![index];
                        return ListTile(
                          title: Text(account.accName),
                          subtitle: Text('계좌번호: ${account.accNum}'),
                          tileColor: selectedRow == index
                              ? const Color.fromARGB(255, 150, 208, 255)
                              : null, // 선택된 로우에 색상 적용
                          onTap: () {
                            setState(() {
                              if (selectedRow == index) {
                                selectedRow = null; // 이미 선택된 로우를 다시 탭하면 선택 해제
                              } else {
                                selectedRow = index; // 새로운 로우를 선택
                              }
                            });
                          },
                        );
                      },
                    ),
                  ],
                );
              }
            },
          )),
    );
  }
}

// 챌린지 참여일수 및 금액 받기
late int slidervalre = 10000;

class AmountSelectScreen extends StatelessWidget {
  const AmountSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double blankHeight = screenHeight * 0.05;
    double startHeight = screenHeight * 0.2;
    double contentWidth = screenWidth * 0.8;
    double appbarHeight = screenHeight * 0.12;

    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: appbarHeight,
        leadingWidth: 10,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: startHeight,
            ),
            // 선택지들
            SizedBox(
                width: contentWidth,
                child: Column(
                  children: [
                    const PeriodDropdownButton(),
                    SizedBox(
                      height: blankHeight,
                    ),
                    const AmountSlider(),
                  ],
                )),

            SizedBox(
              height: blankHeight,
            ),
            OutlinedButton(
              onPressed: () {
                // 선택한 값 적용하기
                pickchallinst.setSavingAmount(slidervalre);
//slidervalre
                // 다음 단계로
                Navigator.of(context).push(
                  CustomRoute(
                    builder: (BuildContext context) => const ResultScreen(),
                    settings: const RouteSettings(),
                  ),
                );
              },
              child: const Text(
                '제출',
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 드롭다운 1 - 기간 설정
class PeriodDropdownButton extends StatefulWidget {
  const PeriodDropdownButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PeriodDropdownButtonState();
}

class _PeriodDropdownButtonState extends State<PeriodDropdownButton> {
  static const menuItems = <String>[
    '30일',
  ];
  final List<DropdownMenuItem<String>> dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String btn1SelectedVal = '30일';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '참여 일수  :  ',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            DropdownButton<String>(
              // Must be one of items.value.

              value: btn1SelectedVal,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => btn1SelectedVal = newValue);
                }
              },
              items: dropDownMenuItems,
            ),
          ],
        ),
      ],
    );
  }
}

// 슬라이더 - 금액 설정
class AmountSlider extends StatefulWidget {
  const AmountSlider({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AmountSliderState();
}

class _AmountSliderState extends State<AmountSlider> {
  double sliderVal = 10000.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          '실패시 적금할 금액',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: SliderTickMarkShape.noTickMark,
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          ),
          child: Slider(
            value: sliderVal,
            min: 1000.0,
            max: 30000.0,
            divisions: 29,

            label: '${sliderVal.round()}',
            // 이것도 제출하면 state 바꾸도록하기
            // 설정한 금액도 띄워보자
            onChanged: (double value) {
              setState(() => sliderVal = value);
              slidervalre = sliderVal.toInt();
            },
          ),
        ),
        Text(
          '${sliderVal.round()} 원',
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}

// 선택 결과 알려주는 창
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double appbarHeight = screenHeight * 0.12;
    double startHeight = screenHeight * 0.03;

    double blankHeight  = screenHeight*0.05;


    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: appbarHeight,
        leadingWidth: 10,

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: startHeight,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),

                // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 48.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      '\n==================\n\n** RECEIPT **\n\n==================',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Text(
                        '\n${controller.checkInfo.registName} 님이 선택하신 \nRe-Habbit이 맞나요?\n\n................................................................',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    DataTable(
                        
                        headingTextStyle: const TextStyle(
                          fontFamily: '아리따-돋움',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        dataTextStyle: const TextStyle(
                          fontFamily: '아리따-돋움',
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        columns: const [
                          DataColumn(label: Text('항목')),
                          DataColumn(label: Text('선택')),
                        ],
                        rows: [
                          DataRow(cells: [
                            const DataCell(Text('연동된 적금')),
                            DataCell(Text(
                                '${acList.getaccountSaving?.accName} ${acList.getaccountSaving?.accNum}')),
                          ]),
                          DataRow(cells: [
                            const DataCell(Text('챌린지 계좌')),
                            DataCell(Text(
                                '${acList.getaccountConsum?.accName} ${acList.getaccountConsum?.accNum}')),
                          ]),
                          const DataRow(cells: [
                            DataCell(Text('도전 항목')),
                            DataCell(Text('커피 안 마시기')),
                          ]),
                          const DataRow(cells: [
                            DataCell(Text('도전 기간')),
                            DataCell(Text('30일')),
                          ]),
                          DataRow(cells: [
                            const DataCell(Text('실패시 적금금액')),
                            DataCell(Text('${pickchallinst.getSavingAmount}')),
                            // DataCell(Text('${amount}')),
                          ]),
                        ]),
                    const Text(
                      '................................................................\n',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: startHeight,
              ),
              // 선택지 1 - 토끼 생성
              OutlinedButton(
                onPressed: () {
                  // 다음 단계로
                  Navigator.of(context).push(
                    CustomRoute(
                      builder: (BuildContext context) => const FinalScreen(),
                      settings: const RouteSettings(),
                    ),
                  );
                },
                child: const Text(
                  '이대로 생성하기',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ),
              SizedBox(
                height: blankHeight,
              )
              // 선택지 2 - 다시 설정하기 -> 삭제
              // TextButton(
              //   onPressed: () {
              //     // 적금 선택 단계로
              //     Navigator.of(context).push(
              //       CustomRoute(
              //         builder: (BuildContext context) => trackAccScreen(),
              //         settings: const RouteSettings(),
              //       ),
              //     );
              //   },
              //   child: const Text(
              //     '수정하기',
              //     style: TextStyle(
              //       color: Color.fromARGB(255, 112, 108, 108),
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// 마지막 화면 - 토끼 생성 + 메인으로 입장
class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double appbarHeight = screenHeight * 0.12;
    double startHeight = screenHeight * 0.22;
    double blankHeight = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: HeaderWidget(),
        centerTitle: true,
        toolbarHeight: 100,
        leadingWidth: 10, // 중간 맞추기 위해 사용 (깨질 위험 있음)
        backgroundColor: Colors.white,

      ),
      body: Center(
        child: Container(
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background-img.png'), // 배경 이미지
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: startHeight,
              ),
              const Text(
                '천리길도 한 걸음부터!',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: blankHeight,
              ),

              const Text(
                '당신의 도전을 응원합니다.',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: blankHeight,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.find<RegisController>().goToMain();
                },
                child: const Text(
                  '메인으로',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 50,
              // ),
              Image.asset(
                'assets/images/profile-img.png',
                height: 300,
              ),
              // const SizedBox(
              //   height: 30,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// 추가 - 계좌번호 입력 시 은행 선택 과정에 필요한 클래스
// 은행 클래스 선언 -> 필드에 은행 이름과 은행 코드를 넣음
class Bank {
  Bank(this.bName, this.bCode);
  final String bName;
  final int bCode;

  // bool selected = false;
}

// 은행 데이터들
// 너무 많아서 일단 주석처리
final List<Bank> _banks = <Bank>[
  Bank('신한', 088),
  Bank('제주', 035),
  Bank('국민', 004),
  Bank('기업', 003),
  Bank('농협', 011),
  Bank('산업', 002),
  Bank('수협', 007),
  Bank('신협', 048),
  Bank('우리', 020),
  Bank('하나', 081),
  Bank('한국씨티', 027),
  Bank('카카오뱅크', 090),
  Bank('케이뱅크', 089),
  Bank('토스뱅크', 092),
  Bank('경남', 039),
  Bank('광주', 034),
  Bank('대구', 031),
  Bank('부산', 032),
  Bank('전북', 037),
  Bank('새마을', 045),
  Bank('우체국', 071),
  Bank('저축은행', 050),
  // Bank('지역농.축협', 012),
  // Bank('도이치', 055),
  // Bank('중국', 063),
  // Bank('중국건설', 067),
  // Bank('중국공상', 062),
  // Bank('BNP파리바', 061),
  // Bank('BOA', 060),
  // Bank('HSBC', 054),
  // Bank('JP모간', 057),
  // Bank('SC제일', 023),
  // Bank('산림조합', 064),
  // Bank('국세', 091),
  // Bank('신한금융투자', 278),
  // Bank('교보증권', 261),
  // Bank('다올투자증권', 227),
  // Bank('대신증권', 267),
  // Bank('메리츠증권', 287),
  // Bank('미래에셋증권', 238),
  // Bank('부국증권', 290),
  // Bank('삼성증권', 240),
  // Bank('상상인', 221),
  // Bank('신영증권', 291),
  // Bank('에스케이증권', 266),
  // Bank('유안타증권', 209),
  // Bank('유진투자증권', 280),
  // Bank('이베스트투자증권', 265),
  // Bank('카카오페이증권', 288),
  // Bank('케이프투자증권', 292),
  // Bank('키움증권', 264),
  // Bank('토스증권', 271),
  // Bank('한국포스증권', 294),
  // Bank('하나금융투자', 270),
  // Bank('하이투자증권', 262),
  // Bank('한국투자증권', 243),
  // Bank('한화투자증권', 269),
  // Bank('현대차증권', 263),
  // Bank('BNK투자증권', 224),
  // Bank('DB금융투자', 279),
  // Bank('IBK투자증권', 225),
  // Bank('KB증권', 218),
  // Bank('NH투자증권', 247),
  // Bank('지방세', 481),
  // Bank('국고금', 485),
  // Bank('금융결제원', 099)
];

class BankDropdownButton extends StatefulWidget {
  const BankDropdownButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BankDropdownButtonState();
}

class _BankDropdownButtonState extends State<BankDropdownButton> {
  static List<String> bankNames = _banks.map((bank) => bank.bName).toList();

  final List<DropdownMenuItem<String>> dropDownMenuItems = bankNames
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String btn1SelectedVal = '신한';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      alignment: Alignment.center,
      value: btn1SelectedVal,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => btn1SelectedVal = newValue);
        }
      },
      items: dropDownMenuItems,
    );
  }
}
