
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
void saveToLocalStorage(path,data) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(path, data);

}

Future <void> saveCurrentlyPlaying(data) async{
  String json_data  = json.encode(data);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("currentPlaying",json_data);
}

Future <dynamic> getCurrentlyPlayed() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var value  = await prefs.get("currentPlaying").toString();
  var decoded  = json.decode(value);
  return decoded;
}

