import 'package:flutter/cupertino.dart';

import 'package:app/robotCostumes.dart';

class Globals {
  static int coins = 100000;
  static int spins = 0;
  static List<String> inventory = []; // Global inventory list
  // List to store items that are still available to win
  static List<String> availableItems = [];
  static List<String> robots = [
    'images/robot.png',
    'images/FemaleRobot.png',
    'images/RadRobot.png',
    'images/SquareRobot.png',
    'images/WinkingRobot.png',
    'images/OvalRobot.png',
  ];
  static List<String> mergedRobots =
      []; // New list to store merged robot images
  static List<String> accessories = [];
  static String equippedHat = '';
  static String equippedHead = '';
  static String equippedNeck = '';
  static RobotCostumes selectedRobot =
      RobotCostumes(250, 'images/OvalRobot.png', '', '', '');
}
