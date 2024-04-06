import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/application/bloc/navigationbloc/navigation_bloc.dart';

class bottomnavigationbar extends StatelessWidget {
  final NavigationBloc navigationBloc;
  const bottomnavigationbar({
    super.key,
    required this.navigationBloc,
  });

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navigationBloc =
        BlocProvider.of<NavigationBloc>(context);
    return CurvedNavigationBar(
      backgroundColor: korange,
      color: Colors.black.withOpacity(0.9),
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(
          Icons.home,
          color: kwhite,
        ),
        Icon(
          Icons.search,
          color: kwhite,
        ),
        Icon(
          Icons.add,
          color: kwhite,
        ),
        Icon(
          Icons.message,
          color: kwhite,
        ),
        Icon(
          Icons.person,
          color: kwhite,
        )
      ],
      onTap: (index) {
        navigationBloc.add(ChangeNavigationEvent(index));
      },
    );
  }
}
