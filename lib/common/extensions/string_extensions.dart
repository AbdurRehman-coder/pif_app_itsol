extension StringExt on String {
  bool equalsIgnoreCase(String value) {
    return toLowerCase() == value.toLowerCase();
  }

  bool isValidEmail() {
    const p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(p);
    return regExp.hasMatch(this);
  }

  String capitalizeTheFirstLetter() {
    if (this == null || this.isEmpty) {
      return '';
    }

    final List<String> words = this.toLowerCase().split('-');
    final capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return '';
      }
    }).toList();

    return capitalizedWords.join(' ');
  }
}
