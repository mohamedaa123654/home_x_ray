import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import '../shared/components/components.dart';
import '../shared/resources/color_manager.dart';
import '../shared/resources/constants_manager.dart';

import '../shared/components/drawer/custom_drawer.dart';
import '../shared/components/drawer_side.dart';
import '../shared/resources/strings_manager.dart';
import '../shared/resources/values_manager.dart';
import 'cubit/state.dart';

class HomeLayout extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = HomeCubit.get(context).userModel?.name ?? '';
        emailController.text = HomeCubit.get(context).userModel?.email ?? '';
        phoneController.text = HomeCubit.get(context).userModel?.phone ?? '';
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.appName),
          ),
          drawer: const CustomDrawer(),
          backgroundColor: ColorManager.backgroundColor,
          // floatingActionButton: FloatingActionButton(
          //     onPressed: () {
          //       HomeCubit.get(context).sendLocationToFirebase();
          //     },
          //     child: Icon(
          //       Icons.location_on_outlined,
          //       color: ColorManager.white,
          //     )),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                      },
                      label: 'User Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              enabled: false,
                              initialSelection: '+20',
                              // favorite: const ['+39', 'FR', "+966"],
                              // optional. Shows only country name and flag
                              showCountryOnly: true,
                              hideMainText: true,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: true,
                            )),
                        Expanded(
                          flex: 4,
                          child: defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your email address';
                        }
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    // defaultButton(
                    //     function: () {
                    //       HomeCubit.get(context).sendLocationToFirebase();
                    //     },
                    //     text: 'click hear to but your location'),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! HomeUserRequistLoadingState,
                      builder: (context) => defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            HomeCubit.get(context).createRequist(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              uId: uId!,
                              latitude: latitude!,
                              longitude: longitude!,
                            );
                          }
                        },
                        text: 'register',
                        isUpperCase: true,
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()
                              //     LoadingState(
                              //   stateRendererType:
                              //       StateRendererType.popupLoadingState,
                              // ) as Widget
                              ),
                    ),
                  ],
                ),
              ),
            ),

            // child: Stack(
            //   alignment: AlignmentDirectional.bottomCenter,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: 30, left: 10),
            //       child: Align(
            //           alignment: AlignmentDirectional.topStart,
            //           child: GestureDetector(
            //             onTap: () => const DrawerSide(),
            //             // child: SizedBox(
            //             //     width: 40,
            //             //     height: 40,
            //             //     child: CircleAvatar(
            //             //       backgroundImage:
            //             //           const AssetImage('assets/images/splash_logo.png'),
            //             //       backgroundColor: ColorManager.backgroundColor,
            //             //     )),
            //           )),
            //     ),
            //   ],
            // ),
          ),
        );
      },
    );
  }
}
