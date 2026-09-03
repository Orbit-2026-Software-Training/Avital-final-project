import 'dart:convert';
import 'dart:io';


void main() {
  double totalTemp = 0;

  File file = File('readings.json');
  String stringJson = file.readAsStringSync();
  List<dynamic> listJson = jsonDecode(stringJson);
  List<Map<String, dynamic>> mapListJson = List<Map<String, dynamic>>.from(listJson);
  //print(mapListJson);

  for(Map indMap in mapListJson) {
    for(var key in indMap.keys) {
      if(key == "teperture"){
        double temp = indMap['temperature'];
        totalTemp += temp;
      }
    }
  }

  double avrgTemp = totalTemp / mapListJson.length;
  print(avrgTemp);
}