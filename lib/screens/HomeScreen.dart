import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'dart:math';

import 'package:tradhay_technologies/dialogs/GameOverDialog.dart';
import 'package:tradhay_technologies/utils/Colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List widgetList = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  int tappedIndex = -1;
 
/**
 * This Function Will Change the value of tapped box.
 * [index] Required Prameter is current index.
 */
  void onTaped(index) {
    var val = Random();

    int generatedNumber = val.nextInt(24);
// This Condition will be true when your all Boxes is coverd.
    if (tappedIndex == widgetList.length - 1) {
      setState(() {
        widgetList[index] = 2;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => GameOverDialog(
                onRestartPressFunction: reStartGame,
              ));
    }
// This Block will be execute when more boxes will be empty.
    else {
/**
 *  This Block will be execute when generated Radom number will be uniq it 
 *  mean generated random number will never generate in this game and generated
 *  random number should not be equal to current tapped index.       
  */

      if (widgetList[generatedNumber] != 2 && generatedNumber != index) {
        setState(() {
          widgetList[index] = 2;

          widgetList[generatedNumber] = 1;
        });
      } else
      /* if above condition will be false then again this block will call 
      *  same function to re-genrate random number.
      */

      {
        onTaped(index);
      }
    }
  }

  @override
  void initState() {
    //first time given block will be green.
    widgetList[4] = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Tridhya Tech",
        style: TextStyle(color:AppColors.mainColor,fontSize:20,fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
              alignment: Alignment.center,
             // height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.only(left:10,right:10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width:0.5,color:AppColors.mainColor)
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    addRepaintBoundaries: true,
                    itemCount: widgetList.length,
                    itemBuilder: (context, index) {
                      return Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          if (widgetList[index] == 1) {
                            tappedIndex++;
                            onTaped(index);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5, color: AppColors.mainColor),
                              color: widgetList[index] == 1
                                  ? Colors.green
                                  : widgetList[index] == 2
                                      ? Colors.red
                                      : Colors.white),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 2),
                  ),
                ),
              ))),
    );
  }

  void reStartGame() {
    for (int i = 0; i < widgetList.length; i++) {
      widgetList[i] = 0;
    }
    tappedIndex = -1;
    widgetList[4] = 1;
    setState(() {});
    Navigator.of(context).pop();
  }
}
