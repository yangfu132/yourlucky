class SASStringService {
  static String appendToString(String mainString, String appendString) {
    if (appendString != '') {
      if (mainString != '') {
        mainString = mainString + '\r\n' + appendString;
      } else
        mainString = appendString;
    }
    //else cont.

    return mainString;
  }

  static String appendSentence(String stringMain, String stringContain) {
    return stringMain + ',' + stringContain;
  }
}
