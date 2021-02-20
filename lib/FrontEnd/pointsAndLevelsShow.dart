import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:countup/countup.dart';

class PointsOrValueShow extends StatefulWidget {
  int _userAchieve;
  String _achieveType;
  PointsOrValueShow(this._userAchieve, [this._achieveType = "Points"]);

  @override
  State<StatefulWidget> createState() {
    return PointsOrValuesShowOnScreen(this._userAchieve, this._achieveType);
  }
}

class PointsOrValuesShowOnScreen extends State<PointsOrValueShow> {
  int _userAchieve, _duration;
  String _achieveType;
  PointsOrValuesShowOnScreen(this._userAchieve, [this._achieveType = "Points"]);

  @override
  void initState(){
    super.initState();
    if(this._userAchieve <= 20)
      this._duration = 2;
    else if(this._userAchieve <= 50)
      this._duration = 3;
    else if(this._userAchieve<=100)
      this._duration = 5;
    else if(this._userAchieve<=1000)
      this._duration = 7;
    else if(this._userAchieve<=5000)
      this._duration = 13;
    else
      this._duration = 15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.pinkAccent,
              Colors.blueAccent,
              Colors.purpleAccent,
              Colors.redAccent
            ],
          )),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 4,
                child: Text(
                  "${this._achieveType} Earned",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Lora',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: CircularCountDownTimer(
                  duration: _duration,
                  initialDuration: 0,
                  //controller: _controller,
                  width: MediaQuery.of(context).size.width - 60,
                  height: MediaQuery.of(context).size.height,
                  ringColor: Colors.white,
                  ringGradient: null,
                  fillColor: Colors.orange,
                  fillGradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.lightGreenAccent,
                        Colors.deepOrange,
                        Colors.lightGreenAccent,
                        Colors.yellowAccent,
                        Colors.redAccent,
                      ]),
                  strokeWidth: 25.0,
                  strokeCap: StrokeCap.round,
                  isTimerTextShown: false,
                  autoStart: true,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Countup(
                  begin: 0.0,
                  end: this._userAchieve.toDouble(),
                  duration: Duration(seconds: _duration),
                  style: TextStyle(
                    fontSize: 90.0,
                    fontFamily: 'Lora',
                    fontWeight: FontWeight.w700,
                    color: Colors.lightGreenAccent,
                  ),
                  curve: Curves.easeInQuad,
                  textAlign: TextAlign.justify,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
