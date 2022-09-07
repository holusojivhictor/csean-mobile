extension IntExtensions on int {
  bool parseToBool() {
    if (this == 1) {
      return true;
    } else if (this == 0) {
      return false;
    }

    throw "Invalid value, cannot be parsed";
  }
}