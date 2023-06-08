import 'dart:async';

import 'package:app_contact/model/contact_model.dart';
import 'package:app_contact/view/update_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();

    final DocumentReference docRef = await contactCollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        phone: ctmodel.phone,
        email: ctmodel.email,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.add(contact.docs);
    return contact.docs;
  }

  Future deleteContact(id) async {
    final contact = await contactCollection.doc(id).delete();
    return contact;
  }

  Future updateContact(String docId, ContactModel contactModel) async {
    final ContactModel updateContactModel = ContactModel(
      name: contactModel.name,
      phone: contactModel.phone,
      email: contactModel.email,
      address: contactModel.address,
      id: docId,
    );
    final DocumentSnapshot documentSnapshot =
        await contactCollection.doc(docId).get();
    if (!documentSnapshot.exists) {
      print('Contact with ID $docId does not exist');
      return;
    }

    final updateContact = updateContactModel.toMap();
    await contactCollection.doc(docId).update(updateContact);
    await getContact();
    print('Updated contact with id : $docId');
  }

  // Future updateContact({name, phone, email, address}) async {
  //   final docRef = contactCollection.doc();
  //   ContactModel contactModel = ContactModel(
  //       name: name,
  //       phone: phone,
  //       email: email,
  //       address: address,
  //       id: docRef.id);

  //   await docRef.set(contactModel.toMap());
  // }
}
