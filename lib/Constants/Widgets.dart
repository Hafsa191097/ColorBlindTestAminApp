import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
    return Column(
      children: [       
        RichText(
          text:const TextSpan(
            style: TextStyle(fontSize:25),
            children: <TextSpan>[
              TextSpan(text: 'ColorBlind', style: TextStyle(fontWeight: FontWeight.w400,color:Colors.black)),
              TextSpan(text: 'Test', style: TextStyle(fontWeight: FontWeight.bold,color:Colors.redAccent)),
            
            ],
          ),
        ),
      ],
    );
}