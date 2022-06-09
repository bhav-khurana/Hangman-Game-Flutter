import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void instructions(BuildContext context) {
    var alertdialog = AlertDialog(
      title: Text('About the Game'),
      content: Text('Hangman is an old school favorite, a word game where the goal is simply to find the missing word or words. \n\nYou will be presented with a number of blank spaces representing the missing letters you need to find. \n\nUse the keyboard to guess a letter (I recommend starting with vowels). \n\nIf your chosen letter exists in the answer, then all places in the answer where that letter appears will be revealed. \n\nAfter you have revealed several letters, you may be able to guess what the answer is and fill in the remaining letters (You can even reveal hints if you want to ;) \n\nBe warned, every time you guess a letter wrong you loose a life and the hangman begins to appear, piece by piece. \n\nSolve the puzzle before the hangman dies.'),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertdialog;
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Mr. Hangman'),
        //   centerTitle: true,
        //   backgroundColor: Colors.blue[900],
        // ),
        body: Container(
          color: Color(0xff001848),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(image: AssetImage('assets/logo.png')),
                  // Image(image: AssetImage('assets/hung3.gif'),height: 200.0,),
                  SizedBox(height: 150.0,),
                  ElevatedButton.icon(

                    icon: Icon(
                      Icons.not_started_outlined
                    ),
                    label: Text('Start Game', style: TextStyle(fontSize: 20.0),),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
                      elevation: 10,
                      primary: Colors.blue[500]!.withOpacity(0.7)
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/difficulty');
                    },
                  ),
                  SizedBox(height: 40.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.question_mark,
                        ),
                        label: Text('How to play', style: TextStyle(fontSize: 20.0),),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                          elevation: 10,
                            primary: Colors.blue[500]!.withOpacity(0.7)
                        ),
                        onPressed: () {
                          instructions(context);
                        },
                      ),
                      SizedBox(width: 50.0,),
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.exit_to_app_rounded,
                        ),
                        label: Text('Exit', style: TextStyle(fontSize: 20.0),),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                            elevation: 10,
                            primary: Colors.blue[500]!.withOpacity(0.7)
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  ),SizedBox(height: 20.0,),

                ],
              ),
          ),
        ),
      ),
    );
  }
}
