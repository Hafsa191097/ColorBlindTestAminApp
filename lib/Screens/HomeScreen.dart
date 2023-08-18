import 'package:flutter/material.dart';

import '../../Constants/Widgets.dart';

import '../Screens/Settings.dart';
import 'Home.dart';
import 'Upload.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late TabController _TabController;

  final List<Tab> topTabs = <Tab>[
    const Tab(text: 'Home',),
    const Tab(text: 'Upload',),
    const Tab(text: 'Settings',)
  ];

  @override
  void initState() {
    _TabController = TabController(length: 3,initialIndex: 0, vsync: this)
    ..addListener(() {
      setState(() {
        
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: appBar(context),
        elevation: 0.0,
        bottom: TabBar(
          tabs: topTabs,
          controller: _TabController,
          indicatorColor: Colors.red[400],
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.red[400],
          unselectedLabelColor: Colors.black54,
          labelStyle:const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 16.0, 
          ),
          
        ),
      ),
      body: TabBarView(
        controller: _TabController,
        children: const[
          Games(),
          UploadQuiz(),
          Settings(),
        ]
        
      ),
    );
  }
}
