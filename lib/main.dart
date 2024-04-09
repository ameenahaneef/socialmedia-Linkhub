import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/application/sharedpreference/sharedpreference.dart';
import 'package:socialmedia/application/bloc/navigationbloc/navigation_bloc.dart';
import 'package:socialmedia/presentation/screens/home/splash.dart';
import 'package:socialmedia/presentation/screens/mainhomee/screenmain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await SharedPreferenceService.getLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(create: (context) => PostBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: isLoggedIn ? ScreenMainPage() : SplashScreen()),
    );
  }
}
