import 'package:flutter/material.dart';
import 'package:teacher/costanse/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

Widget _title(String  title) {
  return Text(title, style: TextStyle(color: Colors.white));
}
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(backgroundColor: MyColors.backcolor,
      body: Center(child:Text('3eeb'),)
    ),);
  }
}