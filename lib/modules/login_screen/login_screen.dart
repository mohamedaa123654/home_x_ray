import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import '../../modules/register_Screen/register_screen.dart';
import '../../shared/components/components.dart';

import '../../layout/home_layout.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/resources/color_manager.dart';
import '../../shared/resources/strings_manager.dart';
import '../../shared/resources/values_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child:
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'login',
              value: true,
            ).then((value) {
              if (value) {
                navigateAndFinish(
                  context,
                  HomeLayout(),
                );
              }
            });
          }
        }, builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.backgroundColor,
            body: Container(
                padding: const EdgeInsets.only(top: AppPadding.p100),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Center(
                            child: Image(
                                image: AssetImage(
                                    'assets/images/splash_logo.png'))),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: ColorManager.white,
                                  ),
                        ),
                        const SizedBox(
                          height: AppSize.s28,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p28, right: AppPadding.p28),
                          child: defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? text) {
                                if (text!.isEmpty) {
                                  return 'Email Should not be empty';
                                }
                                return null;
                              },
                              label: AppStrings.username,
                              prefix: Icons.email),
                        ),
                        const SizedBox(
                          height: AppSize.s28,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p28, right: AppPadding.p28),
                          child: defaultFormField(
                              controller: userPasswordController,
                              type: TextInputType.visiblePassword,
                              suffix: LoginCubit.get(context).suffix,
                              onSubmit: (value) {},
                              isPassword: LoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              validate: (String? text) {
                                if (text!.isEmpty) {
                                  return 'Password Should not be empty';
                                }
                                return null;
                              },
                              label: AppStrings.password,
                              prefix: Icons.lock_outline),
                        ),
                        const SizedBox(
                          height: AppSize.s28,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p28, right: AppPadding.p28),
                          child: ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: userPasswordController.text,
                                        );
                                      }
                                    },
                                    text: 'login',
                                    isUpperCase: true,
                                  ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator())
                              // Center(
                              //     child:
                              //     LoadingState(
                              //   stateRendererType:
                              //       StateRendererType.popupLoadingState,
                              // ) as Widget
                              // ),
                              ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: AppPadding.p8,
                                left: AppPadding.p28,
                                right: AppPadding.p28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                defaultTextButton(
                                    function: () {},
                                    text: AppStrings.forgetPassword),
                                defaultTextButton(
                                    function: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    text: AppStrings.registerText)
                              ],
                            )),
                        SignInButton(
                          Buttons.GoogleDark,
                          text: "Sign up with Google",
                          onPressed: () {
                            LoginCubit.get(context).signInWithGoogle(context);
                          },
                        ),
                        // SignInButton(
                        //   Buttons.Facebook,
                        //   text: "Sign up with Facebook",
                        //   onPressed: () {
                        //     LoginCubit.get(context).signInWithFacebook(context);
                        //   },
                        // )
                      ],
                    ),
                  ),
                )),
          );
        }));
  }
}
