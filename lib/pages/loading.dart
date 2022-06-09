import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../shared/words.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map chosenFilters = {};
  Future<void> getWord(Map chosenFilters) async {
    try{
    List word = Words.words;
    int len = word.length;
    Random random = new Random();
    int randomNumber = random.nextInt(len);
    print(word[randomNumber]);
    Response response2 = await get(Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/${word[randomNumber]}'));
    List hint = await jsonDecode(response2.body) as List;
    Map hints = hint[0];
    print(hints);
    Navigator.pushReplacementNamed(context, '/gameplay', arguments: {
      'word': word[randomNumber],
      'diff': chosenFilters['diff'],
      'partOfSpeech': hints['meanings'][0]['partOfSpeech'],
      'definition': hints['meanings'][0]['definitions'][0]['definition']
    }, );}
    catch(e){
      print(e);
    }

  }
  @override
  Widget build(BuildContext context) {
    chosenFilters = ModalRoute.of(context)!.settings.arguments as Map;
    getWord(chosenFilters);
    return Scaffold(
        backgroundColor: Color(0xff001848),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Loading \n\n',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  letterSpacing: 1.4,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SpinKitFoldingCube(
                color: Colors.white,
                size: 28.0,
              ),
            ],
          ),
        )
    );
  }
}

