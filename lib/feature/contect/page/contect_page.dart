import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsappme/common/model/user_model.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';
import 'package:whatsappme/common/routes/routes.dart';
import 'package:whatsappme/common/utils/appColors.dart';
import 'package:whatsappme/feature/contect/controller/contact_controller.dart';
import 'package:whatsappme/common/widget/custom_icon_button.dart';

import '../widget/contact_card.dart';

class ContectPage extends ConsumerWidget {
  const ContectPage({super.key});
  shareLink(phoneNumber)async{
    Uri sms = Uri.parse(
      "sms: $phoneNumber?body=Let's chait on whatsApp its a chaiting app"
    );
    if(await launchUrl(sms)){

    }else{
      
    }
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select contact",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            ref.watch(contactControllerFutureProvider).when(data: (allContact)=>Text("${allContact[0].length} Contacts", style: const TextStyle(fontSize: 13),), error: (e, t){
              return const SizedBox(); 
            }, loading: (){return const Text("Counting...", style: TextStyle(fontSize: 12),);})
          ],
        ),
        actions: [
          CustomIconButton(onTap: () {}, icon: Icons.search),
          CustomIconButton(onTap: () {}, icon: Icons.more_vert),
        ],
      ),
      body: ref.watch(contactControllerFutureProvider).when(
          data: (allContacts) {
            return ListView.builder(
                itemCount: allContacts[0].length + allContacts[1].length,
                itemBuilder: (context, i) {
                  late  UserModel firebaseContacts;
                  late UserModel phoneContacts;
                  if (i < allContacts[0].length) {
                    firebaseContacts = allContacts[0][i];
                  } else {
                    phoneContacts = allContacts[1][i - allContacts[0].length];
                    
                  }
                  return
                   i < allContacts[0].length
                      ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (i == 0)
                            Column(
                              children: [
                                myListTile(
                                leading: Icons.group,
                                text: 'New group',
                              ),
                                myListTile(
                                  leading: Icons.contacts,
                                  text: 'New contact',
                                  trailing: Icons.qr_code,
                                ),
                              
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  "Contacts on WhatsApp",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: context.theme.greyColor),
                                ),
                              ),],
                            ),
                              ContactCard(contactSource: firebaseContacts, onTap: () {
                                Navigator.of(context).pushNamed(Routes.chat, arguments: firebaseContacts);
                              },)
                          ],
                        )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (i == allContacts[0].length)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  "Invite on WhatsApp",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: context.theme.greyColor),
                                ),
                              ),
                            ContactCard(contactSource: phoneContacts, onTap: () => shareLink(phoneContacts.phoneNumber),)
                        ],
                      );
                });
          },
          error: (e, t) {
            return null;
          },
          loading: () => Center(child: CircularProgressIndicator(color: context.theme.authAppBarTextColor,))),
    );
  }
}


 ListTile myListTile({
    required IconData leading,
    required String text,
    IconData? trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 10, left: 20, right: 10),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.greenDark,
        child: Icon(
          leading,
          color: Colors.white,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        trailing,
        color: AppColors.greyDark,
      ),
    );
  }

