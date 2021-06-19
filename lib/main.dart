import 'package:flutter/material.dart';
import 'story_content.dart';

void main() => runApp(GameOfWords());

class GameOfWords extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  // static Color mainThemeColor = Color();

  static Color primaryContentColor = Color(0xfffc8686);
  static Color primaryOverlayColor = Color(0xfff5c4c4);
  static Color secondaryContentColor = Color(0xffFFA952);
  static Color secondaryOverlayColor = Color(0xfffad3ac);
  static Color mainTextColor = Color(0xff233142);

  StoryContent storyContent = StoryContent();

  void updateStory({required int userAnswer}) {
    setState(() {
      storyContent.nextStory(choiceNumber: userAnswer);
    });
  }

  Padding choiceButton(
      {required String buttonText,
      required int userAnswer,
      required Color backgroundColor,
      required Color overlayColor,
      required Color textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: ElevatedButton(
        onPressed: () => updateStory(userAnswer: userAnswer),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (states) => overlayColor,
          ),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'Titillium Web',
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_pic.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyContent.getStory().storyText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Titillium Web',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: choiceButton(
                  buttonText: storyContent.getChoice1(),
                  userAnswer: 1,
                  backgroundColor: primaryContentColor,
                  overlayColor: primaryOverlayColor,
                  textColor: mainTextColor,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: (storyContent.getChoice2() == '') ? false : true,
                  child: choiceButton(
                    buttonText: storyContent.getChoice2(),
                    userAnswer: 2,
                    backgroundColor: secondaryContentColor,
                    overlayColor: secondaryOverlayColor,
                    textColor: mainTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
