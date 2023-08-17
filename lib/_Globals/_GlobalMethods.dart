import 'package:flutter/material.dart';

class Global_Methods{

  static void showErrorBox({required String error, required BuildContext ctx}){
    showDialog(
        context: ctx,
        builder: (context){
          return AlertDialog(
            title: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout,
                    color:Colors.grey,
                    size:35,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Error Occured"
                  ),
                ),
              ],
            ),
            content:Text(
              error,
              style: const TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
                  child: const Text("Ok",style: TextStyle(
                    color:Colors.redAccent,
                  ),),
              ),
            ],
          );
        }
    );

  }
}