import 'package:flutter/cupertino.dart';

class RobotCostumes {
  double robotSize = 0;
  String robotImage = '';
  String hatImage = '';
  String headDecorImage = '';
  String neckDecorImage = '';

  RobotCostumes(this.robotSize, this.robotImage, this.hatImage,
      this.headDecorImage, this.neckDecorImage);

  static Widget drawRobot(RobotCostumes robot) {
    Offset hatOffset = Offset(0, 0);
    Offset headOffset = Offset(0, 0);
    Offset neckOffset = Offset(0, 0);
    double hatSize = 0.25;
    double headSize = 0.33;
    double neckSize = 0.4;

    if (robot.robotImage == 'images/OvalRobot.png') {
      hatOffset = Offset(robot.robotSize * 0.04, 0);
      headOffset = Offset(robot.robotSize * 0.04, robot.robotSize * 0.27);
      neckOffset = Offset(robot.robotSize * 0.04, robot.robotSize * 0.4);
    } else if (robot.robotImage == 'images/robot.png') {
      hatOffset = Offset(0, 0);
      headSize = 0.5;
      headOffset = Offset(0, robot.robotSize * 0.33);
      neckOffset = Offset(0, robot.robotSize * 0.5);
    } else if (robot.robotImage == 'images/FemaleRobot.png') {
      hatOffset = Offset(0, 0);
      headOffset = Offset(0, robot.robotSize * 0.33);
      neckOffset = Offset(0, robot.robotSize * 0.45);
    } else if (robot.robotImage == 'images/RadRobot.png') {
      hatOffset = Offset(-(robot.robotSize * 0.02), 0);
      headOffset = Offset(-(robot.robotSize * 0.01), robot.robotSize * 0.27);
      neckOffset = Offset(-(robot.robotSize * 0.02), robot.robotSize * 0.40);
    } else if (robot.robotImage == 'images/WinkingRobot.png') {
      headSize = 0.5;
      hatOffset = Offset(0, 0);
      headOffset = Offset(0, robot.robotSize * 0.25);
      neckOffset = Offset(0, robot.robotSize * 0.40);
    } else if (robot.robotImage == 'images/SquareRobot.png') {
      hatOffset = Offset(0, 0);
      headOffset = Offset(0, robot.robotSize * 0.34);
      neckOffset = Offset(0, robot.robotSize * 0.47);
    }
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: Offset(0, robot.robotSize / 6),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    robot.robotImage,
                    height: robot.robotSize,
                    width: robot.robotSize,
                    fit: BoxFit.cover,
                  )),
            )),
        if (robot.hatImage != '')
          Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: hatOffset,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    robot.hatImage,
                    height: robot.robotSize * hatSize,
                    width: robot.robotSize * hatSize,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        if (robot.headDecorImage != '')
          Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: headOffset,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    robot.headDecorImage,
                    height: robot.robotSize * headSize,
                    width: robot.robotSize * headSize,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        if (robot.neckDecorImage != '')
          Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: neckOffset,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    robot.neckDecorImage,
                    height: robot.robotSize * neckSize,
                    width: robot.robotSize * neckSize,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
      ],
    );
  }
}
