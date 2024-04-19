import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/model/ButtonLandingPage.dart';
import 'package:todolist/view/Dashboard/Dashboard.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  bool _isButtonPressed1 = true;
  bool _isButtonPressed2 = false;
  late AnimationController _controller;
  late Animation<double> _animation1, _animation2, _animation3;
  MediaQueryData? queryData;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.33, curve: Curves.easeIn),
      ),
    );

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.33, 0.66, curve: Curves.easeIn),
      ),
    );

    _animation3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.66, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MediaQuery(
      data: queryData!.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation1,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: ShapeDecoration(
                            color: Color(0xFF4383F7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 5.30,
                                offset: Offset(0, 3),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check, // Replace with your desired icon
                              color: Colors.white,
                              size: 40.0, // Set a larger size for the icon
                              // Adjust color as needed
                            ),
                          ),
                        ),
                        const SizedBox(height: 21),
                        Container(
                          width: 300,
                          height: 78,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome to',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Text(
                                'My Todo',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _animation1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 74,
                      child: Text(
                        'My Todo helps you stay organized and perform your tasks much faster.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTransition(
                        opacity: _animation2,
                        child: CustomButton(
                          color: _isButtonPressed1
                              ? Color(0xFFDAE7F7)
                              : Colors.transparent,
                          buttonText: 'Try Demo',
                          onTap: () {
                            setState(() {
                              _isButtonPressed1 = true;
                              _isButtonPressed2 = false;
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()),
                            );
                            // Aksi yang ingin Anda lakukan saat tombol ditekan
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      FadeTransition(
                        opacity: _animation3,
                        child: CustomButton(
                          color: _isButtonPressed2
                              ? Color(0xFFDAE7F7)
                              : Colors.transparent,
                          buttonText: 'No Thenks',
                          onTap: () {
                            SystemNavigator.pop();
                            setState(() {
                              _isButtonPressed2 = true;
                              _isButtonPressed1 = false;
                            });
                            // Aksi yang ingin Anda lakukan saat tombol ditekan
                          },
                        ),
                      ),
                    ],
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
