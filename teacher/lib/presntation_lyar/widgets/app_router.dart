import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:teacher/costanse/pages.dart';
import 'package:teacher/presntation_lyar/screens/ContantScreen.dart';
import 'package:teacher/presntation_lyar/screens/CourseScreen.dart';
import 'package:teacher/presntation_lyar/screens/HomeScreen.dart';
import 'package:teacher/presntation_lyar/screens/LectureScreen.dart';
import 'package:teacher/presntation_lyar/screens/NavigationBar.dart';
import 'package:teacher/presntation_lyar/screens/ProfileScreen.dart';
import 'package:teacher/presntation_lyar/screens/SignUp.dart';
import 'package:teacher/presntation_lyar/screens/loginScreen.dart';
import 'package:teacher/web_servese/dio/web_serv.dart';
import 'package:teacher/web_servese/reproserty/myRepo.dart';
import '../../besnese_logic/get_method/get_method_cubit.dart';
import '../../besnese_logic/uploding_data/uploding_data_cubit.dart';

class AppRouter {
  UplodingDataCubit? uplodingDataCubit;
  GetMethodCubit? getMethodCubit;
  EmailAuthCubit? emailAuthCubit;
  AppRouter() {
    MyRepo myRepoInstance = MyRepo(NameWebServise());
    uplodingDataCubit = UplodingDataCubit(myRepoInstance);
    emailAuthCubit = EmailAuthCubit(
      myRepoInstance,
    );
    getMethodCubit = GetMethodCubit(
        myRepoInstance, emailAuthCubit ?? EmailAuthCubit(myRepoInstance));
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
       case logain:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: const SignUp(),
                ));
      case signup:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: SignUp(),
                ));
      case homescreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GetMethodCubit>.value(
                  value: getMethodCubit!,
                  child: HomeScreen(),
                ));
      case account:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GetMethodCubit>.value(
                  value: getMethodCubit!,
                  child: ProfileScreen(),
                ));
      case genraldata:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: Container(),
                ));
      case forgetpass:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: Container(),
                ));
      case editaccount:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: Container(),
                ));

      case mycourse:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<UplodingDataCubit>.value(value: uplodingDataCubit!),
              BlocProvider<GetMethodCubit>.value(value: getMethodCubit!)
            ],
            child: CourseScreen(),
          ),
        );

              case lecture:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<UplodingDataCubit>.value(value: uplodingDataCubit!),
              BlocProvider<GetMethodCubit>.value(value: getMethodCubit!)
            ],
            child: const LectureScreen(course_id: null,),
          ),
        );
                   case contant:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<UplodingDataCubit>.value(value: uplodingDataCubit!),
              BlocProvider<GetMethodCubit>.value(value: getMethodCubit!)
            ],
            child: ContantScreen(),
          ),
        );
   case nav:
        return MaterialPageRoute(
          
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<GetMethodCubit>.value(value: getMethodCubit!),
              BlocProvider<UplodingDataCubit>.value(value: uplodingDataCubit!)
            ],
            child: NavigationBars(),
          ),
        );
      case search:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<GetMethodCubit>.value(value: getMethodCubit!),
              BlocProvider<EmailAuthCubit>.value(value: emailAuthCubit!)
            ],
            child: Container(),
          ),
        );
    }
    return null;
  }
}
