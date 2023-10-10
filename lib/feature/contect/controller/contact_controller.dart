import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappme/feature/contect/repository/contact_repository.dart';

final contactControllerFutureProvider = FutureProvider((ref) {
  return ref.watch(contactControllerProvider).getAllContacts();
});

final contactControllerProvider = Provider((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return ContactController(
    ref: ref,
    contactRepository:contactRepository,
        );});

class ContactController {
  final ProviderRef ref;
  final ContactRepository contactRepository;

  ContactController({required this.ref, required this.contactRepository});

  Future<List<List>> getAllContacts() async {
    final contactsData = await contactRepository.getAllContacts();
    return contactsData;
  }
}
