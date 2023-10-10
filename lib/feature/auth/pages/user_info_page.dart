import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsappme/feature/auth/controller/authController.dart';
import 'package:whatsappme/feature/auth/pages/image_picker_page.dart';
import 'package:whatsappme/feature/auth/widget/custom_textField.dart';
import 'package:whatsappme/common/helper/show_alert_dialog.dart';
import 'package:whatsappme/common/utils/appColors.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';
import 'package:whatsappme/common/widget/custom_elevated_buttom.dart';
import 'package:whatsappme/common/widget/custom_icon_button.dart';
import 'package:whatsappme/common/widget/short_h_bar.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({this.profileImageUrl, super.key});
  final String? profileImageUrl;

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  File? cameraImage;
  Uint8List? imageGallery;

  late TextEditingController userNameController;

  saveUserInfoToFireStore(
  ) async{
    String username = userNameController.text;
    if(username.isEmpty){
     return showAlertDialog(context: context, message: "Please provide a username");
    }else if(username.length < 3 || username.length>20){
     return showAlertDialog(context: context, message: "A username length should be between 3-20");
    }
    ref.read(authControllerProvider).saveUserInfoToFireStore(userName: username, profileImage: cameraImage??imageGallery?? widget.profileImageUrl ??'',  context: context, mounted: true);
  }

  showImagePickerTypeBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ShortHBar(),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Profile Pic",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const Spacer(),
              CustomIconButton(
                  onTap: () => Navigator.pop(context), icon: Icons.close),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          Divider(
            color: context.theme.greyColor!.withOpacity(0.3),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              imagePickerIcons(
                  onTap: pickImageFromCamera, icon: Icons.camera_alt_rounded, text: "Camera"),
              const SizedBox(
                width: 15,
              ),
              imagePickerIcons(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final image = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ImagePickerPage()));
                    if (image == null) return;
                    setState(() {
                      print("Done");
                      imageGallery = image;
                      cameraImage = null;
                    });
                  },
                  icon: Icons.photo_camera_back_rounded,
                  text: "Gallery")
            ],
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  imagePickerIcons(
      {required VoidCallback onTap,
      required IconData icon,
      required String text}) {
    return Column(
      children: [
        CustomIconButton(
          onTap: onTap,
          icon: icon,
          iconColor: AppColors.greenDark,
          minWidth: 50,
          border: Border.all(
              color: context.theme.greyColor!.withOpacity(0.2), width: 1),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: context.theme.greyColor),
        )
      ],
    );
  }

  pickImageFromCamera() async{
    Navigator.of(context).pop();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        cameraImage = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  @override
  void initState() {
    userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Profile Info",
          style: TextStyle(color: context.theme.authAppBarTextColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Please provide your name and an optional profile pick",
              textAlign: TextAlign.center,
              style: TextStyle(color: context.theme.greyColor),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: showImagePickerTypeBottomSheet,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.photoIconBgColor,
                  border: Border.all(
                      color: imageGallery == null && cameraImage == null
                          ? Colors.transparent
                          : context.theme.greyColor!.withOpacity(0.4)),
                  image: cameraImage != null || imageGallery != null || widget.profileImageUrl != null
                      ? DecorationImage(
                        fit: BoxFit.cover,
                          image: imageGallery != null
                              ? MemoryImage(imageGallery!)
                              : widget.profileImageUrl!=null ?NetworkImage(widget.profileImageUrl!): FileImage(cameraImage!) as ImageProvider)
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: imageGallery == null && cameraImage == null && widget.profileImageUrl == null
                          ? context.theme.photoIconColor:Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: CustomTextField(
                      controller: userNameController,
                  keyboardType: TextInputType.text,
                  hintText: "Type your name here",
                  textAlign: TextAlign.left,
                )),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: context.theme.photoIconColor,
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: saveUserInfoToFireStore,
        buttonWidth: 90,
        text: "NEXT",
      ),
    );
  }
}
