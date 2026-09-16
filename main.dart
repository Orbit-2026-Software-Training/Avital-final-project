import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {

  //find the average number in a list
  num average(List numbers) {
    num totalTemp = 0;
    num averageTemp = 0;
    for (num number in numbers) {
      totalTemp += number;
    }
    averageTemp = totalTemp / numbers.length;
    return averageTemp;
  }

  //checks how much times the engine temperature was over 25
  int timesTheEngineRanWell(List numbers) {
    int numOfGoodTimes = 0;
    for(double number in numbers) {
      if(number > 25) {
        numOfGoodTimes++;
      }
    }
    return numOfGoodTimes;
  }

  //finds the error rates of list of numbers
  num errorRate(List<num> list, String minOrMax) {
    num avrg = average(list);
    num minValue = list.reduce(min);
    num maxvalue = list.reduce(max);

    num minErrorRate = ((minValue - avrg).abs() / avrg) * 100;
    num maxErrorRate = ((maxvalue - avrg).abs() / avrg) * 100;

    if(minOrMax == "min") {return minErrorRate;}
    else {return maxErrorRate;}


  }

  //decodes the JSON files
  File file = File('readings.json');
  String stringJson = file.readAsStringSync();
  List<dynamic> listJson = jsonDecode(stringJson);
  File secondFile = File('Jokes.json');
  String jokeJson = secondFile.readAsStringSync();
  Map<String, dynamic> jokesMap = jsonDecode(jokeJson);

  List<num> allTemps = [];
  List<num> lengthOfJokes = [];
  List<num> sortedAllTemps = [];
  List<num> errorRates = [];

  //adds all of the temperatures to a list
  for (Map map in listJson) {
    if (map.containsKey("temperature")) {
      num temp = map["temperature"];
      allTemps.add(temp.toDouble());
    }
  }

  //splits the jokes from the main JSON and add their length to a list
  List<dynamic> jokesList = jokesMap["jokes"];
  for(dynamic object in jokesList) {
    Map map = object;
    if(map["type"] == "single") {
      lengthOfJokes.add(map["joke"].length);
    } else {
      lengthOfJokes.add(map["setup"].length + map["delivery"].length);
    }
  }

  //adds the error rate to a list, findes from what list the error rate is and if it using the highest or the lowest value of the lists
  errorRates.add(errorRate(allTemps, "min")); 
  errorRates.add(errorRate(allTemps, "max"));
  errorRates.add(errorRate(lengthOfJokes, "min"));
  errorRates.add(errorRate(lengthOfJokes, "max"));
  String tempsOrJokes = "";
  String highestOrLowest = "";
  if(errorRates.indexOf(errorRates.reduce(max)) == 0 || errorRates.indexOf(errorRates.reduce(max)) == 1) {
    tempsOrJokes = "temperature";
  } else {
    tempsOrJokes = "jokes lengths";
  }
  if(errorRates.indexOf(errorRates.reduce(max)) == 0 || errorRates.indexOf(errorRates.reduce(max)) == 2) {
    highestOrLowest = "lowest";
  } else {
    highestOrLowest = "highest";
  }

  //prints the answers
  print("Average temperature: ${average(allTemps)}");
  print("Highest temperature: ${allTemps.reduce(max)}");
  print("Lowest temperature: ${allTemps.reduce(min)}");
  print("The engine ran well ${timesTheEngineRanWell(allTemps)} times");
  print("Average length of a joke: ${average(lengthOfJokes)}");
  print("The highest length of a joke: ${lengthOfJokes.reduce(max)}");
  print("The lowest lenght of a joke: ${lengthOfJokes.reduce(min)}");
  print("The highest error rate is ${errorRates.reduce(max)} and it's the $highestOrLowest value of the $tempsOrJokes list");

  //sorts all the temperatures from lowest to highest
  while(allTemps.isNotEmpty) {
    sortedAllTemps.add(allTemps.reduce(min));
    allTemps.remove(allTemps.reduce(min));
  }

  //prints the sorted temperatures
  print(sortedAllTemps);
}