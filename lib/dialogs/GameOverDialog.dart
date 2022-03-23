import 'package:flutter/material.dart';



class GameOverDialog extends StatelessWidget {
  Function onRestartPressFunction;
  GameOverDialog({Key? key, required this.onRestartPressFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: MediaQuery.of(context).size.height/6,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '"Tutorial is over"!',
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width / 1.5,
                child: InkWell(
                    onTap: () {
                      onRestartPressFunction();
                    },
                    child: const Card(
                      color: Colors.black,
                      elevation: 5,
                      child: Center(
                        child: Text(
                          'Restart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
 
  }
}