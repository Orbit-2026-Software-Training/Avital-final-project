import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
  //find the average number in a list
  num avrg(List numbers) {
    num totalTemp = 0;
    num avrgTemp = 0;

    for (num number in numbers) {
      totalTemp += number;
    }

    avrgTemp = totalTemp / numbers.length;
    return avrgTemp;
  }

  //decoding the JSON file
  File file = File('readings.json');
  String stringJson = file.readAsStringSync();
  List<dynamic> listJson = jsonDecode(stringJson);

  List<num> allTemps = [];

  //adding all the temperature to a list
  for (Map map in listJson) {
    if (map.containsKey("temperature")) {
      num temp = map["temperature"];
      allTemps.add(temp.toDouble());
    }
  }

  //prints the answers
  print("Average temperature: ${avrg(allTemps)}");
  print("Highest temperature: ${allTemps.reduce(max)}");
  print("lowest temperature: ${allTemps.reduce(min)}");
}