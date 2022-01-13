import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe

class Data {
  final String description;
  final String imageUrl;

  Data({
    required this.description,
    required this.imageUrl,
  });
}

// ignore: camel_case_types
class indicator extends StatelessWidget {
  final int index;

  const indicator(this.index);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BuildContainer(
            0,
            index == 0
                ? Color.fromARGB(255, 46, 64, 84)
                : Color.fromARGB(255, 55, 134, 150),
          ),
          BuildContainer(
            1,
            index == 1
                ? Color.fromARGB(255, 46, 64, 84)
                : Color.fromARGB(255, 55, 134, 150),
          ),
          BuildContainer(
            2,
            index == 2
                ? Color.fromARGB(255, 46, 64, 84)
                : Color.fromARGB(255, 55, 134, 150),
          ),
          BuildContainer(
            3,
            index == 3
                ? Color.fromARGB(255, 46, 64, 84)
                : Color.fromARGB(255, 55, 134, 150),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget BuildContainer(int i, Color color) {
    return index == i
        ? Container(
            margin: EdgeInsets.all(4),
            height: 6,
            width: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          )
        : Container(
            margin: EdgeInsets.all(4),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          );
  }
}

class Pview extends StatefulWidget {
  const Pview({Key? key}) : super(key: key);

  @override
  _PviewState createState() => _PviewState();
}

class _PviewState extends State<Pview> {
  var isUserLoggedIn;
  int _currentindex = 0;
  final _pageIndexNotifier = ValueNotifier<int>(0);
  final PageController _controller = PageController(
    initialPage: 0,
  );

  final List<Data> myData = [
    Data(
      description: "Start where you are",
      imageUrl: "assets/images/q4.png",
    ),
    Data(
      description: "Use what you have",
      imageUrl: "assets/images/q2.png",
    ),
    Data(
      description: "Do what you can",
      imageUrl: "assets/images/q1.png",
    ),
    Data(
      description: "The secret of getting ahead is getting started",
      imageUrl: "assets/images/q3.png",
    )
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentindex < 3) {
        _currentindex++;
      }
      _controller.animateToPage(_currentindex,
          duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 55, 134, 150),
            Color.fromARGB(255, 190, 210, 224),
          ],
        ),
      ),
      child: Stack(
        children: [
          Builder(
            builder: (ctx) => PageView(
              children: myData
                  .map(
                    (item) => Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              alignment: Alignment.center,
                              image: ExactAssetImage(item.imageUrl),
                              fit: BoxFit.contain,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 450),
                                Text(
                                  item.description,
                                  style: TextStyle(
                                    inherit: false,
                                    color: Color.fromARGB(255, 46, 64, 84),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )
                  .toList(),
              onPageChanged: (val) {
                _pageIndexNotifier.value = val;
                setState(() {
                  _currentindex = val;
                  // if (_currentindex == 3) {
                  //   Future.delayed(Duration(seconds: 3),
                  //       () => Navigator.of(ctx).pushNamed('/a'));
                  // }
                });
              },
              controller: _controller,
            ),
          ),
          indicator(_currentindex),
          Builder(
            builder: (ctx) => Align(
              alignment: const Alignment(0, 0.9),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 250, height: 58),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 46, 64, 84)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        color: Color.fromARGB(255, 190, 210, 224),
                        fontSize: 25,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pushReplacementNamed('/a');
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
