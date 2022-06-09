import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Gameplay extends StatefulWidget {
  const Gameplay({Key? key}) : super(key: key);

  @override
  State<Gameplay> createState() => _GameplayState();
}

class _GameplayState extends State<Gameplay> {
  int _hiscore = 0;
  String word = '';
  bool h1 = false;
  bool h2 = false;
  int count = 0;
  List visible = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
  List enabled1 = [true,true,true,true,true,true,true,true,true,true,true,true,true]; List enabled2 = [true,true,true,true,true,true,true,true,true,true,true,true,true]; List enabled3 = [true,true,true,true,true,true,true,true,true,true,true,true,true]; List enabled4 = [true,true,true,true,true,true,true,true,true,true,true,true,true];
  List triesLeft = [7,5,3];
  int ind = 1;
  List alpha1 = ['A', 'B', 'C', 'D', 'E','F','G'];
  List alpha2 = ['H', 'I', 'J', 'K', 'L','M','N'];
  List alpha3 = ['O', 'P', 'Q', 'R', 'S','T','U'];
  List alpha4 = ['V', 'W', 'X', 'Y', 'Z'];
  int score = 100;
  String pos = '', def = '';
  void gameOver(BuildContext context) {
    var alertdialog = AlertDialog(
      title: Center(child: Text('Game Over!')),
      content: Column(
        children: [
          Text('The word was $word'),
          const SizedBox(height: 20.0,),
          const Text('Score: 0'),
          const SizedBox(height: 20.0,),
          Text('Previous HiScore: $_hiscore'),
          const SizedBox(height: 20.0,),
          OutlinedButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/difficulty');
            },
            child: Text('Play Again'),
          )
        ]
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertdialog;
      }
    );
  }
  void Won(BuildContext context) {
    _updateHiScore();
    var alertdialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      title: Center(child: Text('You Won !')),
      content: Column(
          children: [
            Text('The word was $word'),
            const SizedBox(height: 20.0,),
            Text('Score: $score'),
            const SizedBox(height: 20.0,),
            Text('Previous HiScore: $_hiscore'),
            const SizedBox(height: 20.0,),
            OutlinedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/difficulty');
              },
              child: Text('Play Again'),
            )
          ]
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertdialog;
        }
    );
  }
  @override
  void initState() {
    super.initState();
    _loadhiscore();
  }

  Future<void> _loadhiscore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hiscore = (prefs.getInt('hiscore') ?? 0);
    });
  }

  Future<void> _updateHiScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hiscore = score > _hiscore ? score : _hiscore;
      prefs.setInt('hiscore', _hiscore);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = ModalRoute.of(context)!.settings.arguments as Map;
    String diff = data['diff'];
    word = data['word'].toUpperCase();
    pos = data['partOfSpeech'];
    def = data['definition'];
    print(word);
    List<Widget> dashes = [];
    for (int i = 0; i < word.length; i++) {
      dashes.add(
        Container(
          child: Center(child: Visibility(
              child: Text(
                word[i],
                style:  TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white as Color)
                ),
            visible: visible[i],
              )
          ),
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0)
          ),
        )
      );
    }
    int tries = 0;
    if (diff == 'easy') {
      tries = triesLeft[0];
    } else if (diff == 'med') {
      tries = triesLeft[1];
    } else {
      tries = triesLeft[2];
    }
    // if (diff == 'easy')
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Hangman'),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xff001848),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(child: Opacity(opacity: 0.6,child: Image(image: AssetImage('assets/easy$ind.png',), height: 180.0,))),
                ),
                const SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var i in dashes) Container(child: i)
                  ],
                ),
                const SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45.0,
                        // width: 80.0,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            radius: 2,
                            colors: [
                              Colors.grey[300] as Color,
                              Color(0xff301860).withOpacity(0.9)
                            ],
                          ),
                          border: Border.all(color: Colors.brown[200] as Color),
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15.0),
                          child: Center(
                            child: Text(
                              'Tries left: $tries ', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45.0,
                        // width: 80.0,
                        decoration: BoxDecoration(
                            gradient: RadialGradient(
                              radius: 2,
                              colors: [
                                Colors.grey[300] as Color,
                                Color(0xff301860).withOpacity(0.9)
                              ],
                            ),
                            border: Border.all(color: Colors.brown[200] as Color),
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 15.0),
                          child: Center(
                            child: Text(
                                'Score: $score', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for(int i = 0; i < 7; i++) GestureDetector(
                      onTap: enabled1[i] ? (){
                        setState(() {
                          bool isthere = false;
                          for(int j = 0; j < word.length; j++) {
                            if (word[j] == alpha1[i])
                              {
                                visible[j] = true;
                                isthere = true;
                              }
                          }
                          if (!isthere) {
                            triesLeft[0] -= 1;
                            triesLeft[1] -= 1;
                            triesLeft[2] -= 1;
                            score -= 10;

                            if (diff == 'easy' && ind+1 <= 7) ind += 1;
                            else if (diff == 'med' && ind+2 <= 7) ind += 2;
                            else if (diff == 'hard' && ind+3 <= 7) ind += 3;
                            if (tries == 1) {
                              gameOver(context);
                            }
                          }
                          else {
                            count += alpha1[i].allMatches(word).length as int;
                          }
                          enabled1[i] =false;
                          if (count == word.length) {
                            Won(context);
                          }
                        });
                      } : null,
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.3),
                          borderRadius: BorderRadius.circular(10.0),
                          color: enabled1[i] ? Color(0xffc8b0c8) : Colors.white,

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          child: Center(child: Text(alpha1[i], style: TextStyle(fontSize: 20.0),)),
                        ),
                      ),

                    )
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for(int i = 0; i < 7; i++) GestureDetector(
                      onTap: enabled2[i] ? (){
                        setState(() {
                          bool isthere = false;
                          for(int j = 0; j < word.length; j++) {
                            if (word[j] == alpha2[i])
                            {
                              visible[j] = true;
                              isthere = true;
                            }
                          }
                          if (!isthere) {
                            triesLeft[0] -= 1;
                            triesLeft[1] -= 1;
                            triesLeft[2] -= 1;
                            score -= 10;

                            if (diff == 'easy' && ind+1 <= 7) ind += 1;
                            else if (diff == 'med' && ind+2 <= 7) ind += 2;
                            else if (diff == 'hard' && ind+3 <= 7) ind += 3;
                            if (tries == 1) {
                              gameOver(context);
                            }
                          }
                          else {
                            count += alpha2[i].allMatches(word).length as int;
                          }
                          enabled2[i] =false;
                          if (count == word.length) {
                            Won(context);
                          }
                        });
                      } : null,
                      child:  Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.3),
                          borderRadius: BorderRadius.circular(10.0),
                          color: enabled2[i] ? Color(0xffc8b0c8) : Colors.white,

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          child: Center(child: Text(alpha2[i], style: TextStyle(fontSize: 20.0),)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for(int i = 0; i < 7; i++) GestureDetector(
                      onTap: enabled3[i] ? (){
                        setState(() {
                          bool isthere = false;
                          for(int j = 0; j < word.length; j++) {
                            if (word[j] == alpha3[i])
                            {
                              visible[j] = true;
                              isthere = true;
                            }
                          }
                          if (!isthere) {
                            triesLeft[0] -= 1;
                            triesLeft[1] -= 1;
                            triesLeft[2] -= 1;
                            score -= 10;

                            if (diff == 'easy' && ind+1 <= 7) ind += 1;
                            else if (diff == 'med' && ind+2 <= 7) ind += 2;
                            else if (diff == 'hard' && ind+3 <= 7) ind += 3;
                            if (tries == 1) {
                              gameOver(context);
                            }
                          }
                          else {
                            count += alpha3[i].allMatches(word).length as int;
                          }
                          enabled3[i] =false;
                          if (count == word.length) {
                            Won(context);
                          }
                        });
                      } : null,
                      child:  Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.3),
                          borderRadius: BorderRadius.circular(10.0),
                          color: enabled3[i] ? Color(0xffc8b0c8) : Colors.white,

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          child: Center(child: Text(alpha3[i], style: TextStyle(fontSize: 20.0),)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for(int i = 0; i < 5; i++) GestureDetector(
                      onTap: enabled4[i] ? (){
                        setState(() {
                          bool isthere = false;
                          for(int j = 0; j < word.length; j++) {
                            if (word[j] == alpha4[i])
                            {
                              visible[j] = true;
                              isthere = true;
                            }
                          }
                          if (!isthere) {
                            triesLeft[0] -= 1;
                            triesLeft[1] -= 1;
                            triesLeft[2] -= 1;
                            score -= 10;

                            if (diff == 'easy' && ind+1 <= 7) ind += 1;
                            else if (diff == 'med' && ind+2 <= 7) ind += 2;
                            else if (diff == 'hard' && ind+3 <= 7) ind += 3;
                            if (tries == 1) {
                              gameOver(context);
                            }
                          }
                          else {
                            count += alpha4[i].allMatches(word).length as int;
                          }
                          enabled4[i] =false;
                          if (count == word.length) {
                            Won(context);
                          }
                        });
                      } : null,
                      child:  Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.3),
                          borderRadius: BorderRadius.circular(10.0),
                          color: enabled4[i] ? Color(0xffc8b0c8) : Colors.white,

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          child: Center(child: Text(alpha4[i], style: TextStyle(fontSize: 20.0),)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue[800] as Color, width: 1), borderRadius: BorderRadius.circular(5)),
                    child: IgnorePointer(
                      ignoring: h1,
                      child: ExpansionTile(
                        onExpansionChanged: (bool expanded){
                          setState(() {
                            h1 = true;
                            score -= 5;
                          });
                        },
                        title: const Text('Reveal Hint 1   (-5 points)', style: TextStyle(fontSize: 17.0),),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                              child: Text('Part of Speech: $pos', style: TextStyle(fontSize: 17.0),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue[800] as Color, width: 1), borderRadius: BorderRadius.circular(5)),
                    child: IgnorePointer(
                      ignoring: h2,
                      child: ExpansionTile(
                        onExpansionChanged: (bool expanded){
                          setState(() {
                            h2 = true;
                            score -= 10;
                          });
                        }
                        ,
                        title: Text('Reveal Hint 2   (-10 points)', style: TextStyle(fontSize: 17.0),),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                              child: Text('Definition: $def', style: TextStyle(fontSize: 17.0),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
