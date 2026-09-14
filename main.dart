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

  //checks how much times the engine temperature was over 25
  int timesTheEngineRanWell(List numbers) {
    int numOfGoodTimes = 0;
    for (double number in numbers) {
      if (number > 25) {
        numOfGoodTimes++;
      }
    }
    return numOfGoodTimes;
  }

  //decoding the JSON files
  File file = File('readings.json');
  String stringJson = file.readAsStringSync();
  List<dynamic> listJson = jsonDecode(stringJson);
  File secondFile = File('Jokes.json');
  String jokeJson = secondFile.readAsStringSync();
  Map<String, dynamic> jokesMap = jsonDecode(jokeJson);

  List<num> allTemps = [];
  List<num> lengthOfJokes = [];
  List<num> sortedAllTemps = [];

  //adding all the temperature to a list
  for (Map map in listJson) {
    if (map.containsKey("temperature")) {
      num temp = map["temperature"];
      allTemps.add(temp.toDouble());
    }
  }

  //split the jokes frome the main JSON and add their length to a list
  List<dynamic> jokesList = jokesMap["jokes"];
  for (dynamic object in jokesList) {
    Map map = object;
    if (map["type"] == "single") {
      lengthOfJokes.add(map["joke"].length);
    } else {
      lengthOfJokes.add(map["setup"].length + map["delivery"].length);
    }
  }

  //prints the answers
  print("Average temperature: ${avrg(allTemps)}");
  print("Highest temperature: ${allTemps.reduce(max)}");
  print("lowest temperature: ${allTemps.reduce(min)}");
  print("The engine ran well ${timesTheEngineRanWell(allTemps)} times");
  print("Average length of a joke: ${avrg(lengthOfJokes)}");
  print("The highest length of a joke: ${lengthOfJokes.reduce(max)}");
  print("The lowest lenght of a joke: ${lengthOfJokes.reduce(min)}");

  while (allTemps.length > 1) {
    sortedAllTemps.add(allTemps.reduce(min));
    allTemps.remove(allTemps.reduce(min));
  }

  print(sortedAllTemps);
}
