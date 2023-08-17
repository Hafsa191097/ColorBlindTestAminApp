import 'package:flutter/material.dart';

import 'Upload.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Container(
         child: const Column(children: [
       
             ],),
       ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const UploadQuiz()));
          },
          backgroundColor: Colors.redAccent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child:
               const Icon(Icons.add_rounded, color: Colors.white, size: 25),
        ),
    );
  }
}