import 'package:flutter/material.dart';

class UserData {
  String name = "";
  String teacher = "";
  List<String> robots = [];
  List<String> accessories = [];
  int questsCompleted = 0;
  int questionsAnswered = 0;
  int roboOutletWins = 0;

  UserData(String _name, String _teacher, _robots) {
    name = _name;
    teacher = _teacher;
    robots = [_robots];
  }



  getName() {
    return name;
  }

  setName(String _name) {
    name = _name;
  }

  getTeacher() {
    return teacher;
  }

  setTeacher(String _teacher) {
    teacher = _teacher;
  }

  addRobot(String _robot) {
    robots.add(_robot);
  }

  addAccessories(String _accessories) {
    accessories.add(_accessories);
  }

  addQuests() {
    questsCompleted++;
  }

  addAnswered() {
    questionsAnswered++;
  }

  addWins() {
    roboOutletWins++;
  }
}
