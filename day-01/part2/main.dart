import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('../input.txt');
  Stream<String> lines =
      file.openRead().transform(utf8.decoder).transform(LineSplitter());

  try {
    var total = 0;
    await for (var line in lines) {
      var numbers = _extractNumbersFromLine(line);
      if (numbers.isNotEmpty) {
        total += _calculateSum(numbers);
      }
      print('$line: ${numbers}, running total: ${total}');
    }
  } catch (e) {
    print(e);
  }
}

List<int> _extractNumbersFromLine(String line) {
  var concatenated = '';
  List<int> numbers = [];
  line.split('').forEach((ch) {
    concatenated += ch;
    final fromWord = _convertWordToNumber(concatenated);
    if (fromWord != null) {
      numbers.add(fromWord);
    } else {
      final fromChar = int.tryParse(ch);
      if (fromChar != null) {
        numbers.add(fromChar);
      }
    }
  });
  return numbers;
}

int? _convertWordToNumber(String text) {
  final words = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9
  };
  for (final entry in words.entries) {
    if (text.length - entry.key.length >= 0 &&
        text.substring(text.length - entry.key.length) == entry.key) {
      return entry.value;
    }
  }
  return null;
}

int _calculateSum(List<int> numbers) {
  String joined = '${numbers.first}${numbers.last}';
  return int.parse(joined);
}
