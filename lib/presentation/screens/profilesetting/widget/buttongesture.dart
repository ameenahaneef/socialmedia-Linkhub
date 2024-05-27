import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
import 'package:socialmedia/application/bloc/editprofilebloc/editprofilebloc_bloc.dart';
import 'package:socialmedia/application/models/newedit.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';

class Gesturebutton extends StatelessWidget {
  const Gesturebutton({
    super.key,
    required TextEditingController nameController,
    required TextEditingController usernameContr,
    required TextEditingController bioController,
    required TextEditingController linksController,
  })  : _nameController = nameController,
        _usernameContr = usernameContr,
        _bioController = bioController,
        _linksController = linksController;
  final TextEditingController _nameController;
  final TextEditingController _usernameContr;
  final TextEditingController _bioController;
  final TextEditingController _linksController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditprofileblocBloc, EditprofileblocState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Profile updated Successfully'),
            backgroundColor: green,
          ));
          context.read<AccountBloc>().add(FetchUserDataEvent());
          navigatePop(context);
        } else if (state is EditProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (_nameController.text.isEmpty ||
                _nameController.text.length < 3 ||
                _nameController.text.length > 30) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Name is not Valid'),
                backgroundColor: korange,
              ));
              return;
            }
            if (_usernameContr.text.isEmpty ||
                _usernameContr.text.length < 3 ||
                _usernameContr.text.length > 30) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Please enter a valid username'),
                backgroundColor: korange,
              ));
              return;
            }
            if (_bioController.text.length > 60) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Only 60 letters Possible'),
                backgroundColor: korange,
              ));
              return;
            }

            context.read<EditprofileblocBloc>().add(EditProfile(Profilee(
                name: _nameController.text,
                username: _usernameContr.text,
                bio: _bioController.text,
                links: _linksController.text)));
          },
          child: Container(
            width: 160,
            height: 55,
            decoration: BoxDecoration(
                color: kgrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(23),
                border: Border.all(color: kwhite)),
            child: Center(
              child: Text(
                'Save',
                style: nostyle,
              ),
            ),
          ),
        );
      },
    );
  }
}
