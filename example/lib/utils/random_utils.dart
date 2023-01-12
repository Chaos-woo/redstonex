import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';
import 'package:random_avatar/random_avatar.dart';

class RandomUtils {
  static String getRandomName() {
    return mockName();
  }

  static int getRandomNum([int min = 1, int max = 10]) {
    return mockInteger(min, max);
  }

  static String getRandomString([int minLength = 1, int maxLength = 10]) {
    return mockString(getRandomNum(minLength, maxLength));
  }

  static Widget getRandomAvatar({double height = 50.0, double width = 50.0}) {
    return randomAvatar(getRandomString(4, 7), trBackground: false, height: height, width: width);
  }

  static Widget getFixedRandomAvatar(String string, {double height = 50.0, double width = 50.0}) {
    return randomAvatar(string, trBackground: false, height: height, width: width);
  }
}