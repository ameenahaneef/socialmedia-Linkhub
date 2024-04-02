import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/navigationbloc/navigation_bloc.dart';
import 'package:socialmedia/presentation/mainhomee/mainh.dart';
import 'package:socialmedia/presentation/mainhomee/widget/bottomnavwidget.dart';
import 'package:socialmedia/presentation/screens/account/accountdetails.dart';
import 'package:socialmedia/presentation/screens/addnew/addpost.dart';
import 'package:socialmedia/presentation/screens/messages/messages.dart';
import 'package:socialmedia/presentation/screens/search/search.dart';

class ScreenMainPage extends StatelessWidget {
   ScreenMainPage({super.key, });
  final List<Widget> pages=[
    HomeMain(),
    SearchScreen(),
    AddPostWidget(),
    MessageScreen(),
    AccountDetails(),


  ];

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navigationBloc=BlocProvider.of<NavigationBloc>(context);
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationInitial) {
            return IndexedStack(
              index: state.initialPageIndex,
              children: pages,
            );
          }
          return Container(); // Handle other states if needed
        },
      ),
      bottomNavigationBar: bottomnavigationbar(navigationBloc: navigationBloc,),
    );
  }
}