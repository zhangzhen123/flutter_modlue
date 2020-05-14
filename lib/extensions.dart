///字符串转换Boolean的扩展函数
extension StringExtension on String {
  bool get boolean {
    if (this == "True") {
      return true;
    } else {
      return false;
    }
  }

  //字符串的布尔值取反
  String get inverse {
    if (this == "True") {
      return "False";
    } else {
      return "True";
    }
  }
}

//布尔转字符串的扩展函数
extension BooleanExtension on bool {
  String get toStr {
    if (this) {
      return "True";
    } else {
      return "False";
    }
  }
}
