import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/costanse/pages.dart';
import 'package:teacher/presntation_lyar/screens/NavigationBar.dart';
import 'package:teacher/presntation_lyar/widgets/app_router.dart';

String? initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  if (getUserId() != null) {
    initialRoute = nav;
  } else {
    initialRoute = signup;
  }
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
