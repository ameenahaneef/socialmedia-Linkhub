import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/application/bloc/navigationbloc/navigation_bloc.dart';
import 'package:socialmedia/presentation/screens/mainhomee/mainh.dart';
import 'package:socialmedia/presentation/screens/mainhomee/widget/bottomnavwidget.dart';
import 'package:socialmedia/presentation/screens/account/accountdetails.dart';
import 'package:socialmedia/presentation/screens/addnew/addpost.dart';
import 'package:socialmedia/presentation/screens/messages/messages.dart';
import 'package:socialmedia/presentation/screens/search/search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({
    super.key,
  });
  final List<Widget> pages = [
    const HomeMain(),
    const SearchScreen(),
    const AddPostWidget(),
    const MessageScreen(),
    const AccountDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navigationBloc =
        BlocProvider.of<NavigationBloc>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
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
