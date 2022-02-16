import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter/MyApp/back.dart';
import 'package:first_flutter/MyApp/home.dart';
import 'package:first_flutter/Movie/movies.dart';
import 'package:first_flutter/MyApp/quiz.dart';
import 'package:first_flutter/parsing_json/json_parsing.dart';
import 'package:first_flutter/parsing_json/json_parsing_map.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'board_firestore/boar_app.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(home:MovieListView(),));
}





