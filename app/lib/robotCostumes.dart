import 'package:flutter/cupertino.dart';

class RobotCostumes {
  String robotImage = '';
  String hatImage = '';
  String headDecorImage = '';
  String neckDecorImage = '';

  RobotCostumes(
      this.robotImage, this.hatImage, this.headDecorImage, this.neckDecorImage);

  static Widget drawRobot(RobotCostumes robot, double size) {
    Offset hatOffset = Offset(0, 0);
    Offset headOffset = Offset(0, 0);
    Offset neckOffset = Offset(0, 0);
    double hatSize = 0.25;
    double headSize = 0.33;
    double neckSize = 0.4;

    if (robot.robotImage == 'images/OvalRobot.png') {
      hatOffset = Offset(size * 0.04, 0);
      headOffset = Offset(size * 0.04, size * 0.27);
      neckOffset = Offset(size * 0.04, size * 0.4);
    } else if (robot.robotImage == 'images/robot.png') {
      hatOffset = Offset(0, 0);
      headSize = 0.5;
      headOffset = Offset(0, size * 0.33);
      neckOffset = Offset(0, size * 0.5);
    } else if (robot.robotImage == 'images/FemaleRobot.png') {
      hatOffset = Offset(0, 0);
      headOffset = Offset(0, size * 0.33);
      neckOffset = Offset(0, size * 0.45);
    } else if (robot.robotImage == 'images/RadRobot.png') {
      hatOffset = Offset(-(size * 0.02), 0);
      headOffset = Offset(-(size * 0.01), size * 0.27);
      neckOffset = Offset(-(size * 0.02), size * 0.40);
    } else if (robot.robotImage == 'images/WinkingRobot.png') {
      headSize = 0.5;
      hatOffset = Offset(0, 0);
      headOffset = Offset(0, size * 0.25);
      neckOffset = Offset(0, size * 0.40);
    } else if (robot.robotImage == 'images/SquareRobot.png') {
      hatOffset = Offset(0, 0);
      headOffset = Offset(0, size * 0.34);
      neckOffset = Offset(0, size * 0.47);
    }
    return Container(
        width: size,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0, size / 6),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        robot.robotImage,
                        height: size,
                        width: size,
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
                        height: size * hatSize,
                        width: size * hatSize,
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
                        height: size * headSize,
                        width: size * headSize,
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
                        height: size * neckSize,
                        width: size * neckSize,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
          ],
        ));
  }
}
