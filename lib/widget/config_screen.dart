import 'package:flutter/cupertino.dart';
import 'package:test_app/widget/constant.dart';

enum ScreenType { SMALL, MEDIUM, LARGE, XLARGE }

class ConfigScreen {
  double screenWidth;
  double screenHeight;
  ScreenType screenType;
  ConfigScreen(BuildContext context) {
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    _setScreen();
    print("Screen type ${this.screenType}");
  }

  void _setScreen() {
    if (this.screenWidth >= 320 && this.screenWidth < 375)
      this.screenType = ScreenType.SMALL;
    else if (this.screenWidth >= 375 && this.screenWidth < 414)
      this.screenType = ScreenType.MEDIUM;
    else if (this.screenWidth >= 414 && this.screenWidth < 550)
      this.screenType = ScreenType.LARGE;
    else
      this.screenType = ScreenType.XLARGE;
  }
}

class WidgetSize {
  ConfigScreen configScreen;
  WidgetSize(ConfigScreen configScreen) {
    this.configScreen = configScreen;
    initValue();
  }
  void initValue() {
    if (configScreen.screenType == ScreenType.SMALL) {
      Constant.verySmallFont = 12;
      Constant.smallFont = 14;
      Constant.mediumFont = 18;
      Constant.largeFont = 20;
      Constant.xlargeFont = 22;
      Constant.veryVerySmallFont = 10;
    } else if (configScreen.screenType == ScreenType.MEDIUM) {
      Constant.verySmallFont = 14;
      Constant.smallFont = 16;
      Constant.mediumFont = 20;
      Constant.largeFont = 24;
      Constant.xlargeFont = 28;
      Constant.veryVerySmallFont = 12;
    } else {
      Constant.verySmallFont = 16;
      Constant.smallFont = 18;
      Constant.mediumFont = 22;
      Constant.largeFont = 26;
      Constant.xlargeFont = 30;
      Constant.veryVerySmallFont = 14;
    }
  }
}
