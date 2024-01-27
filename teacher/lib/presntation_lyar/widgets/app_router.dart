import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:teacher/costanse/pages.dart';
import 'package:teacher/presntation_lyar/screens/HomeScreen.dart';
import 'package:teacher/presntation_lyar/screens/NavigationBar.dart';
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
      case nav:
        return MaterialPageRoute(
          builder: (context) => NavigationBars(),
        );
      case logain:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: LoginScreen(),
                ));
      case signup:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: SignUp(),
                ));
      case homescreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: HomeScreen(),
                ));
      case account:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: Container(),
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
              BlocProvider<EmailAuthCubit>.value(value: emailAuthCubit!)
            ],
            child: Container(),
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
