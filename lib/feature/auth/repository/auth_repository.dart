import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappme/common/helper/show_alert_dialog.dart';
import 'package:whatsappme/common/helper/show_loading_dialog.dart';
import 'package:whatsappme/common/model/user_model.dart';
import 'package:whatsappme/common/repository/firebase_storage_repository.dart';
import 'package:whatsappme/common/routes/routes.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance, realtime: FirebaseDatabase.instance);
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseDatabase realtime;

  AuthRepository({required this.auth, required this.realtime, required this.firestore});

    Stream<UserModel> getUserPresenceStatus({required String uid}) {
    return firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  void updateUserPresence() async{
    Map<String , dynamic> online = {
      "active": true,
      "lastSeen": DateTime.now().millisecondsSinceEpoch
    };
    Map<String , dynamic> offline = {
      "active": false,
      "lastSeen": DateTime.now().millisecondsSinceEpoch
    };

    final connectedRef = realtime.ref('.info/connected');
    connectedRef.onValue.listen((event) async{
      final isConnected = event.snapshot.value as bool ? ?? false;
      if(isConnected){
        await realtime.ref().child(auth.currentUser!.uid).update(online);
      }else{
        await realtime.ref().child(auth.currentUser!.uid).onDisconnect().update(offline);

      }
    });
  }

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo =
        await firestore.collection("users").doc(auth.currentUser?.uid).get();
    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  void saveUserInfoToFireStore({
    required String userName,
    required var profileImage,
    required ProviderRef ref,
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(context: context, message: "Saving user Info ...");
      String uid = auth.currentUser!.uid;
       String profileImageUrl = profileImage is String ? profileImage:'';
      if (profileImageUrl != null && profileImage is! String) {
        profileImageUrl = await ref
        .read(firebaseStorageRepositoryProvider)
        .storeFileToFirebase("profileImage/$uid", profileImage);
      }

      UserModel user = UserModel(
          userName: userName,
          uid: uid,
          profileImageUrl: profileImageUrl,
          active: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: [], lastSeen: DateTime.now().millisecondsSinceEpoch);
      await firestore.collection('users').doc(uid).set(user.toMap());
      if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.home, (route) => false);
    } catch (e) {
      Navigator.of(context).pop();
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verfySmsCode(
      {required BuildContext context,
      required String smsCodeId,
      required String smsCode,
      required bool mounted}) async {
    try {
      showLoadingDialog(context: context, message: "Verifying code ...");
      final navigator = Navigator.of(context);
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      UserModel? user = await getCurrentUserInfo();
      if (!mounted) return;
      navigator.pushNamedAndRemoveUntil(Routes.userInfo, (route) => false, arguments: user?.profileImageUrl);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendCode(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      showLoadingDialog(context: context, message: "Sending a verification code to $phoneNumber");
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showAlertDialog(context: context, message: e.toString());
          },
          codeSent: (smsCodeId, resendSmsCodeId) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.verification, (route) => false, arguments: {
              "phoneNumber": phoneNumber,
              "smsCodeId": smsCodeId
            });
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
