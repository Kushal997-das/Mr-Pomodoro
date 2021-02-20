import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:hello_promodoro/Backend/Authentication.dart';

class PromoDoroClock extends StatefulWidget {
  double wTime, bTime;
  int userPoints;
  String userName;
  Authenticate authenticate;

  PromoDoroClock(this.wTime, this.bTime, this.userPoints, this.userName,
      this.authenticate);

  @override
  State<StatefulWidget> createState() {
    return PromoDoro(this.wTime.toInt(), this.bTime.toInt(), this.userPoints,
        this.userName, this.authenticate);
  }
}

class PromoDoro extends State<PromoDoroClock> {
  int wTime, bTime, _userPoints;
  double percentCompleteness = 0.0;
  bool _startTimerEnabled = true, _resetEnabled = false;
  String timerCounter = "Sleep Mode", _userName;
  Authenticate _authenticate;

  CountDownController _controller = CountDownController();

  PromoDoro(this.wTime, this.bTime, this._userPoints, this._userName,
      this._authenticate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Colors.blueAccent,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 40.0,
                ),
                alignment: Alignment.center,
                child: Text(
                  "PromoDoro Counter",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontFamily: 'Lora',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              circularProgress(context),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 30.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          denoting("Working Time", this.wTime, 1),
                          SizedBox(
                            width: 20.0,
                          ),
                          denoting("Break Time", this.bTime, 0),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      instructionalButton(1),
                      SizedBox(
                        height: 35.0,
                      ),
                      instructionalButton(0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget circularProgress(BuildContext context) {
    return CircularCountDownTimer(
      duration: this.wTime,
      initialDuration: 0,
      controller: _controller,
      width: MediaQuery.of(context).size.width / 2 + 70,
      height: MediaQuery.of(context).size.height / 2 - 30,
      ringColor: Colors.white,
      ringGradient: null,
      fillColor: Colors.orange,
      fillGradient: null,
      backgroundColor: Colors.blueAccent,
      backgroundGradient: null,
      strokeWidth: 25.0,
      strokeCap: StrokeCap.butt,
      textStyle: TextStyle(
          fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.HH_MM_SS,
      autoStart: false,
      onComplete: () {
        int pointsEarned = 0;
        setState(() {
          _resetEnabled = false;
          if (this.wTime == 15) {
            this._userPoints += 5;
            pointsEarned = 5;
          } else if (this.wTime == 25) {
            this._userPoints += 10;
            pointsEarned = 10;
          } else if (this.wTime == 45) {
            this._userPoints += 15;
            pointsEarned = 15;
          } else {
            this._userPoints += 20;
            pointsEarned = 20;
          }
          this._authenticate.updatePoints(this._userName, this._userPoints);
        });
        Alert(
            context: this.context,
            title: "Congrats! You Completed This PromoDoro",
            desc:
                "${this.wTime} minute Working Time Successfully Completed\n\nYou have Earned $pointsEarned Points\n\nNow Take A Break for ${this.bTime} minutes and \ntry other PromoDoro",
            type: AlertType.success,
            closeIcon: Icon(Icons.close_rounded),
            closeFunction: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            buttons: [
              DialogButton(
                  color: Colors.blueAccent,
                  child: Text(
                    "Bye",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Lora',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
            ]).show();
      },
    );
  }

  Widget denoting(String primaryFont, int timeLimit, int firstPortion) {
    double moderateFontSize = 28.0, leftPadding = 10.0;
    if (firstPortion == 1) {
      moderateFontSize = 25.0;
      leftPadding = 6.0;
    }
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: leftPadding),
            child: Text(
              primaryFont,
              style: TextStyle(
                fontSize: moderateFontSize,
                fontFamily: 'Lora',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              "$timeLimit min",
              style: TextStyle(fontSize: 40.0, fontFamily: 'Lora'),
            ),
          ),
        ],
      ),
    );
  }

  Widget instructionalButton(int functionality) {
    String instruction = "Stop";
    double moderateFontSize = 23.0;
    if (functionality == 1) {
      instruction = "Start Timer";
      moderateFontSize = 25.0;
      return timerConfiguration(instruction, moderateFontSize);
    } else
      return resetConfiguration(instruction, moderateFontSize);
  }

  Widget timerConfiguration(String instruction, double moderateFontSize) {
    return Center(
        child: RaisedButton(
      elevation: 15.0,
      padding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            width: 1.0,
          )),
      color: Colors.blue,
      child: Text(
        instruction,
        style: TextStyle(
          fontSize: moderateFontSize,
          fontFamily: 'Lora',
          color: Colors.white,
        ),
      ),
      onPressed: _startTimerEnabled == true ? _startManagement : null,
    ));
  }

  Widget resetConfiguration(String instruction, double moderateFontSize) {
    return Center(
      child: RaisedButton(
        elevation: 15.0,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              width: 1.0,
            )),
        color: Colors.blue,
        child: Text(
          instruction,
          style: TextStyle(
            fontSize: moderateFontSize,
            fontFamily: 'Lora',
            color: Colors.white,
          ),
        ),
        onPressed: _resetEnabled == true ? _stopManagement : null,
      ),
    );
  }

  void _startManagement() {
    setState(() {
      _resetEnabled = true;
      _startTimerEnabled = false;
    });
    _controller.start();
  }

  void _stopManagement() {
    _controller.pause();
    setState(() {
      _resetEnabled = false;
    });
  }
}
