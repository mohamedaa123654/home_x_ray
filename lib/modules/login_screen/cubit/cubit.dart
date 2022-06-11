import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../layout/home_layout.dart';
import '../../../modules/register_Screen/cubit/cubit.dart';
import '../../../shared/components/components.dart';

import '../../../models/login_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/resources/constants_manager.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;

      CacheHelper.saveData(
        key: 'uId',
        value: value.user!.uid,
      );

      emit(LoginSuccessState(uId: value.user!.uid));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  GoogleSignInAccount? userGoogle;
  Future signInWithGoogle(context) async {
    // Trigger the authentication flow XXXXXXXXXXXXXXX
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    userGoogle = googleUser;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      print('cccccccccc${userGoogle!.displayName.toString()}');
      userCreate(
          name: userGoogle!.displayName.toString(),
          email: userGoogle!.email.toString(),
          image: userGoogle!.photoUrl.toString(),
          phone: '',
          isEmailVerified: true,
          uId: value.user!.uid);
      uId = value.user!.uid;
      CacheHelper.saveData(
        key: 'uId',
        value: value.user!.uid,
      );
      navigateAndFinish(context, HomeLayout());
      emit(GoogleLoginSuccessState());
    }).catchError((onError) {
      emit(GoogleLoginErrorState());
    });
  }

  // LoginResult? facebookResult;
  // Future signInWithFacebook(context) async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   facebookResult = loginResult;
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   // Once signed in, return the UserCredential
  //   FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential)
  //       .then((value) {
  //     print('ffffffffffffffff $facebookResult');
  //     // userCreate(
  //     //     name: userGoogle!.displayName.toString(),
  //     //     email: userGoogle!.email.toString(),
  //     //     phone: '0',
  //     //     isEmailVerified: true,
  //     //     uId: value.user!.uid);
  //     uId = value.user!.uid;
  //     CacheHelper.saveData(
  //       key: 'uId',
  //       value: value.user!.uid,
  //     );
  //     if (uId == CacheHelper.getData(key: 'uId')) {
  //       navigateAndFinish(context, HomeLayout());
  //       emit(FacebookLoginSuccessState());
  //     }
  //   }).catchError((onError) {
  //     emit(FacebookLoginErrorState());
  //   });
  // }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    String? image,
    bool? isEmailVerified,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        image: image,
        uId: uId,
        isEmailVerified: isEmailVerified ?? false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      print('XXXXXXXXXXXXXXXXXXXXXXXXXX' + onError.toString());
      emit(CreateUserErrorState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}
