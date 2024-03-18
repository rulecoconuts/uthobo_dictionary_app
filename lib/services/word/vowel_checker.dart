class VowelChecker {
  static Set<String> getVowels() {
    return {"a", "e", "i", "o", "u"};
  }

  bool startsWithVowel(String word) {
    var trimmed = word.trim();
    if (trimmed.isEmpty) return false;

    return getVowels().contains(trimmed[0].toLowerCase());
  }

  String addIndefiniteArticle(String word) {
    var trimmed = word.trim();
    if (trimmed.isEmpty) return word;

    bool wordStartWithVowel = startsWithVowel(word);

    String article = wordStartWithVowel ? "an" : "a";

    return "$article $word";
  }
}
