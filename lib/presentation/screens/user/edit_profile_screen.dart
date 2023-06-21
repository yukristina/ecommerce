import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/logic/cubits/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_state.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:ecommerce/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String routeName = "edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is UserLoggedInState) {
              return editProfile(state.userModel);
            }

            return const Center(
              child: Text('An error occured'),
            );
          },
        ),
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Personal Details',
          style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
        ),
        const GapWidget(
          size: -10,
        ),
        PrimaryTextField(
          labelText: 'Fullname',
          initialValue: userModel.fullName,
          onChanged: (value) {
            userModel.fullName = value;
          },
        ),
        const GapWidget(),
        PrimaryTextField(
          labelText: 'Phone Number',
          initialValue: userModel.phoneNumber,
          onChanged: (value) {
            userModel.phoneNumber = value;
          },
        ),
        const GapWidget(
          size: -10,
        ),
        Text(
          'Address',
          style: TextStyles.body2.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        PrimaryTextField(
          labelText: 'City',
          initialValue: userModel.city,
          onChanged: (value) {
            userModel.city = value;
          },
        ),
        const GapWidget(),
        PrimaryTextField(
          labelText: 'State',
          initialValue: userModel.state,
          onChanged: (value) {
            userModel.state = value;
          },
        ),
        const GapWidget(),
        PrimaryButton(
            onPressed: () async {
              bool success = await BlocProvider.of<UserCubit>(context)
                  .updateUser(userModel);

              if (success) {
                Navigator.pop(context);
              }
            },
            text: 'Save'),
      ],
    );
  }
}
