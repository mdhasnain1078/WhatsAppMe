import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';
import '../../../common/model/user_model.dart';
import '../../../common/utils/appColors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contactSource,
    required this.onTap,
  });

  final UserModel contactSource;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 20, right: 10),
      dense: true,
      leading: CircleAvatar(
          backgroundColor: context.theme.greyColor!.withOpacity(0.3),
          backgroundImage: contactSource.profileImageUrl.isNotEmpty
              ? CachedNetworkImageProvider(contactSource.profileImageUrl)
              : null,
          radius: 20,
          child: contactSource.profileImageUrl.isEmpty
              ? Icon(
                  Icons.person,
                  size: 30,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                )
              : const SizedBox()),
      title: Text(
        contactSource.userName,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: contactSource.profileImageUrl.isEmpty
          ? null
          : Text(
              "Hey i am using whatsApp",
              style: TextStyle(
                  color: context.theme.greyColor, fontWeight: FontWeight.w600),
            ),
      trailing: contactSource.profileImageUrl.isEmpty
          ? TextButton(
              onPressed: () {},
              child: const Text(
                "INVITE",
                style: TextStyle(color: AppColors.greenDark),
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}
