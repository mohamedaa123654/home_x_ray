import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/request_model.dart';
import '../../models/user_model.dart';
import '../../shared/resources/constants_manager.dart';
import 'state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  // FirebaseService
  sendLocationToFirebase() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    saveLocation(
        longitude: _locationData.longitude, latitude: _locationData.latitude);
    longitude = _locationData.longitude;
    latitude = _locationData.latitude;
  }

  UserModel? userModel;

  void getUserData() {
    // emit(HomeGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetUserErrorState());
    });
  }

  void saveLocation({
    required double? longitude,
    required double? latitude,
  }) {
    getUserData();
    UserModel model = UserModel(
        latitude: latitude,
        longitude: longitude,
        email: userModel!.email,
        name: userModel!.name,
        phone: userModel!.phone,
        uId: userModel!.uId,
        image: userModel!.image,
        isEmailVerified: userModel!.isEmailVerified);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      // getUserData();
      emit(HomeSaveLocationSuccessState());
    }).catchError((error) {
      emit(HomeSaveLocationErrorState());
    });
  }

  goToMaps(double? latitude, double? longitude) async {
    String mapUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final String encodeUrl = Uri.encodeFull(mapUrl);
    if (await canLaunch(encodeUrl)) {
      await launch(encodeUrl);
    } else {
      print('could not launch $encodeUrl');
    }
  }

  void createRequist({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required double latitude,
    required double longitude,
  }) {
    RequestModel model = RequestModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        latitude: latitude,
        longitude: longitude);

    FirebaseFirestore.instance
        .collection('rquestes')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateRequistSuccessState());
    }).catchError((onError) {
      print('XXXXXXXXXXXXXXXXXXXXXXXXXX' + onError.toString());
      emit(CreateRequistErrorState());
    });
  }
}
