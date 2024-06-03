import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
import 'package:socialmedia/application/bloc/chat/chat_bloc.dart';
import 'package:socialmedia/application/bloc/propic/propic_bloc.dart';
import 'package:socialmedia/application/bloc/comment/comment_bloc.dart';
import 'package:socialmedia/application/bloc/editprofilebloc/editprofilebloc_bloc.dart';
import 'package:socialmedia/application/bloc/follow/follow_bloc.dart';
import 'package:socialmedia/application/bloc/following/following_bloc.dart';
import 'package:socialmedia/application/bloc/homepost/home_bloc.dart';
import 'package:socialmedia/application/bloc/like/like_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/application/bloc/search/search_bloc.dart';
import 'package:socialmedia/application/bloc/userpost/userpost_bloc.dart';
import 'package:socialmedia/application/sharedpreference/sharedpreference.dart';
import 'package:socialmedia/application/bloc/navigationbloc/navigation_bloc.dart';
import 'package:socialmedia/presentation/screens/home/pages/splash.dart';
import 'package:socialmedia/presentation/screens/mainhomee/pages/screenmain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  bool isLoggedIn = await SharedPreferenceService.getLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}
  const String socketBaseUrl="wss://ciao.ashkar.tech/chat/ws";

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final accountBloc=AccountBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(create: (context) => PostBloc(accountBloc: accountBloc)),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(
          create: (context) => FollowBloc(accountBloc: accountBloc),
          child: Container(),

        ),
        BlocProvider(create: (context) =>FollowingBloc()),
        BlocProvider(create: (context) =>EditprofileblocBloc(accountBloc)),
        BlocProvider(create: (context)=>HomeBloc()),
        BlocProvider(create: (context)=>CommentBloc()),
        BlocProvider(create: (context)=>LikeBloc()),
        BlocProvider(create: (context)=>UserpostBloc()),
        BlocProvider(create: (context)=>PropicBloc()),
        BlocProvider(create: (context)=>ChatBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: isLoggedIn ? ScreenMainPage() : SplashScreen()),
    );
  }
}
