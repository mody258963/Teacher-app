import 'package:flutter/material.dart';
import 'package:teacher/costanse/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(backgroundColor: MyColors.backcolor,
      body: Center(child: Text('Profile'),)
    ),);
  }
}