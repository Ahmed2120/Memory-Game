import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'data.dart';

class FlipCardGame extends StatefulWidget {
  final Level _level;

  FlipCardGame(this._level);

  @override
  _FlipCardGameState createState() => _FlipCardGameState(_level);
}

class _FlipCardGameState extends State<FlipCardGame> {
  final Level _level;
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  bool _isFinished = false;
  late Timer _timer;
  late int _time = 5;
  late int _left;
  late List<String> _data;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStatusKeys;

  _FlipCardGameState(this._level);

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                blurRadius: 3,
                spreadRadius: 0.8,
                offset: Offset(2, 1))
          ]),
      margin: EdgeInsets.all(0.4),
      child: Image.asset(_data[index]),
    );
  }

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _time = _time - 1;
      });
    });
  }

  void restart() {
    setState(() {
      startTimer();
      _data = getSourceArray(_level);
      _cardFlips = getInitialItemState(_level);
      _cardStatusKeys = getCardStateKeys(_level);
      _time = 5;
      _left = (_data.length ~/ 2);
      _isFinished = false;
      Future.delayed(Duration(seconds: 5), () {
        _start = true;
        _timer.cancel();
      });
    });

  }

  @override
  void initState() {
    super.initState();
    restart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isFinished
        ? Scaffold(
            body: Center(
              child: GestureDetector(
                onTap: () {setState(() {
                  Navigator.pop(context);
                });},
                child: Container(
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Replay',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: _time > 0 ? Text('$_time') : Text('left: $_left'),
                    ),
                    GridView.builder(
                      itemCount: _data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) => _start
                          ? FlipCard(
                        key: _cardStatusKeys[index],
                              onFlip: () {
                                if (!_flip) {
                                  _flip = true;
                                  _previousIndex = index;
                                } else {
                                  if (_previousIndex != index ) {
                                    if (_data[_previousIndex] != _data[index]) {
                                      _wait = true;
                                      Future.delayed(Duration(microseconds: 2000),
                                          () {
                                        var f = _cardStatusKeys[_previousIndex].currentState;
                                        if(f != null){
                                              f.toggleCard();
                                        }
                                        _previousIndex = index;
                                        Future.delayed(
                                            Duration(microseconds: 160), () {
                                          setState(() {
                                            _wait = false;
                                          });
                                        });
                                      });
                                    }else{
                                      _cardFlips[index] = false;
                                      _cardFlips[_previousIndex] = false;
                                      setState(() {
                                        _flip = false;
                                        _left -=1;
                                      });
                                      if(_cardFlips.every((element) => element == false)){
                                        Future.delayed(Duration(microseconds: 160), (){
                                          setState(() {
                                            _isFinished = true;
                                            _start = false;
                                          });
                                        });
                                      }
                                    }
                                  }
                                }
                              },
                              front: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 3,
                                          spreadRadius: 0.8,
                                          offset: Offset(2, 1))
                                    ]),
                                margin: EdgeInsets.all(0.4),
                                child: Image.asset('assets/images/quest.png'),
                              ),
                              flipOnTouch: _wait ? false : _cardFlips[index],
                              back: getItem(index))
                          : getItem(index),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
