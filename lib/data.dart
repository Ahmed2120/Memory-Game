import 'package:flutter/cupertino.dart';
import 'package:flip_card/flip_card.dart';

List<String> fillSourceArray() {
  return [
    'assets/images/dino.png',
    'assets/images/dino.png',
    'assets/images/fish.png',
    'assets/images/fish.png',
    'assets/images/frog.png',
    'assets/images/frog.png',
    'assets/images/octo.png',
    'assets/images/octo.png',
    'assets/images/shark.png',
    'assets/images/shark.png',
    'assets/images/wolf.png',
    'assets/images/wolf.png',
    'assets/images/zoo.png',
    'assets/images/zoo.png',
    'assets/images/whale.png',
    'assets/images/whale.png',
    'assets/images/rabbit.png',
    'assets/images/rabbit.png',
    'assets/images/seahorse.png',
    'assets/images/seahorse.png',
    'assets/images/girraf.png',
    'assets/images/girraf.png',
    'assets/images/peacock.png',
    'assets/images/peacock.png',
  ];
}

enum Level { HARD, MEDIUM, EASY }

List<String> getSourceArray(Level level) {
  List<String> levelList = [];
  List sourceArray = fillSourceArray();
  if (level == Level.HARD) {
    sourceArray.forEach((element) => levelList.add(element));
  } else if (level == Level.MEDIUM) {
    for (int i = 0; i < 18; i++) {
      levelList.add(sourceArray[i]);
    }
  } else if (level == Level.EASY) {
    for (int i = 0; i < 10; i++) {
      levelList.add(sourceArray[i]);
    }
  }
  levelList.shuffle();
  return levelList;
}

List<bool> getInitialItemState(Level level) {
  //to control of fliping every card
  List<bool> getItemState = [];
  if (level == Level.HARD) {
    for (int i = 0; i < 24; i++) {
      getItemState.add(true);
    }
  } else if (level == Level.MEDIUM) {
    for (int i = 0; i < 18; i++) {
      getItemState.add(true);
    }
  } else if (level == Level.EASY) {
    for (int i = 0; i < 10; i++) {
      getItemState.add(true);
    }
  }
  return getItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level){
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  if (level == Level.HARD) {
    for (int i = 0; i < 24; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.MEDIUM) {
    for (int i = 0; i < 18; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.EASY) {
    for (int i = 0; i < 10; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}