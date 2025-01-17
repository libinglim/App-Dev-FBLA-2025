import 'package:app/robotCostumes.dart';

class Globals {
  static int coins = 100000;
  static int spins = 10;
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
  static List<String> accessories = [];
  static RobotCostumes selectedRobot = RobotCostumes('images/OvalRobot.png', '', '', '');
}
