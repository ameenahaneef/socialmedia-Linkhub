import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/application/bloc/navigationbloc/navigation_bloc.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:socialmedia/presentation/screens/mainhomee/pages/mainh.dart';
import 'package:socialmedia/presentation/screens/mainhomee/widget/bottomnavwidget.dart';
import 'package:socialmedia/presentation/screens/account/pages/accountdetails.dart';
import 'package:socialmedia/presentation/screens/addnew/pages/addpost.dart';
import 'package:socialmedia/presentation/screens/messages/pages/messages.dart';
import 'package:socialmedia/presentation/screens/search/pages/search.dart';
import 'package:web_socket_channel/io.dart';

class ScreenMainPage extends StatefulWidget {
  
  ScreenMainPage({
    super.key,

  });

  @override
  State<ScreenMainPage> createState() => _ScreenMainPageState();
}

class _ScreenMainPageState extends State<ScreenMainPage> {
  final List<Widget> pages = [
    const HomeMain(),
     const SearchScreen(),
    AddPostWidget(),
     MessageScreen(channel: IOWebSocketChannel.connect(EndPoints.socketBaseUrl),),
    const AccountDetails(),
  ];
@override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final NavigationBloc navigationBloc =
        BlocProvider.of<NavigationBloc>(context);
    return Scaffold(
      backgroundColor: black,
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationInitial) {
            return IndexedStack(
              index: state.initialPageIndex,
              children: pages,
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: bottomnavigationbar(
        navigationBloc: navigationBloc,
      ),
    );
  }
}