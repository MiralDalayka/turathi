String addNewLineAfterChars(String text, int charCount) {
  List<String> words = text.split(' ');

  StringBuffer buffer = StringBuffer();
  int count = 0;

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    if (count + word.length > charCount) {
      buffer.write('\n');
      count = 0;
    }

    buffer.write(word);

    if (i < words.length - 1) {
      buffer.write(' ');
      count++; 
    }

    count += word.length;
  }

  return buffer.toString();
}
