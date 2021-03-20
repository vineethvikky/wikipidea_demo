
//Static text
const kWikipedia = 'Wikipedia';
const kSearch = 'Search...';
const kNoDataFound = 'No Data Found';

//Assets
const kPlaceHolder = 'assets/placeholder.png';

//Font Size
const kFontSize10 = 10.0;
const kFontSize20 = 20.0;
const kFontSize22 = 22.0;
const kFontSize16 = 16.0;

double getWidth(double width, double screenWidth) {
  return ((screenWidth/375) * width);
}

double getHeight(double height, double screenHeight) {
  return ((screenHeight/667) * height);
}

double getFont(double font, double screenWidth) {
  return ((screenWidth/375) * font);
}

class ScreenUtil {
  static ScreenUtil _instance;

  static double _screenWidth;
  static double _screenHeight;

  ScreenUtil._();

  factory ScreenUtil() {
    return _instance;
  }

  static void init({num width, num height}) {
    _instance ??= ScreenUtil._();
    _screenWidth = width;
    _screenHeight = height;
  }

  double getHeight(double height) {
    return (_screenHeight/812)*height;
  }

  double getWidth(double width) {
    return (_screenWidth/375)*width;
  }
  double getFont(double font) {
    return (_screenWidth/375)*font;
  }
}