import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/model/user_model.dart';


final contactRepositoryProvider = Provider((ref) => ContactRepository(firestore: FirebaseFirestore.instance));

class ContactRepository{
  final FirebaseFirestore firestore;

  ContactRepository({required this.firestore});

    Future<List<List>> getAllContacts() async{
    List<UserModel> firebaseContacts = [];
    List<UserModel> phonesContacts = [];
    firebaseContacts.add(UserModel(userName: "Hasnain(you)", uid: '', profileImageUrl: 'https://tostatus.in/wp-content/uploads/2023/05/%F0%9F%90%88-and-beautiful-HD-quality-cute-WhatsApp-DP-download-1024x1024.jpg.webp', active: false, phoneNumber: "9315810327", groupId: [], lastSeen: 0));
    try {
      if(await FlutterContacts.requestPermission()){
        final userCollection = await firestore.collection("users").get();

        final allContactsInPhone = await FlutterContacts.getContacts(withProperties: true);
        bool isContactFound = false;
        for(var contact in allContactsInPhone){
          for (var firebasContactData in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(firebasContactData.data());
            print(firebaseContact.phoneNumber.replaceAll("+91", ''));
            if (contact.phones[0].number.replaceAll(' ', '') == firebaseContact.phoneNumber.replaceAll("+91", '')) {
              firebaseContacts.add(firebaseContact);
              print(firebaseContact.userName);
              isContactFound = true;
              break;
            }
          }
          if (!isContactFound) {
            phonesContacts.add(UserModel(userName: contact.displayName, uid: '', profileImageUrl: '', active: false, phoneNumber: contact.phones[0].number.replaceAll(' ', ''), groupId: [], lastSeen: 0));
          }
          isContactFound = false;
        }
      }
    } catch (e) {
      print(e.toString());
    }

  return [firebaseContacts, phonesContacts];
  }
  
}