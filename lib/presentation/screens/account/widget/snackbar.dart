  import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(BuildContext context,String message,{Color backgroundColor=kgrey}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(message),
                          backgroundColor:backgroundColor,
                        ));
  }