import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() async {
  final file = File('../input.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    num total = 0;
    await for (var line in lines) {
      num lineAmount = getLineAmount(line);
      total += lineAmount;
      print('$line: ${lineAmount}, total: ${total}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// Strip away the letters from the string, then add up the last two numbers.
getLineAmount(String line) {
  if (line.isEmpty) return null;

  String stringifiedNums = '';
  line.split('').forEach((ch) {
    if (int.tryParse(ch) != null) {
      stringifiedNums += ch;
    }
  });
  if (stringifiedNums.length > 0) {
    stringifiedNums =
        stringifiedNums[0] + stringifiedNums[stringifiedNums.length - 1];
    return int.parse(stringifiedNums);
  }
}
