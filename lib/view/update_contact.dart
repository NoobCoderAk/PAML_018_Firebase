import 'package:app_contact/controller/contact_controller.dart';
import 'package:app_contact/view/contact.dart';
import 'package:flutter/material.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({
    super.key,
  });

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var cc = ContactController();
  final formkey = GlobalKey<FormState>();

  final String docId;
  String name;
  String phone;
  String email;
  String address;

  @override
  void initState() {
    cc.updateContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Contact',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(hintText: 'Name'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  initialValue: phone,
                  decoration: const InputDecoration(hintText: 'Phone'),
                  onChanged: (value) {
                    phone = value;
                  },
                ),
                TextFormField(
                  initialValue: email,
                  decoration: const InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  initialValue: address,
                  decoration: const InputDecoration(hintText: 'Address'),
                  onChanged: (value) {
                    address = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const Contact()),
                      ),
                    );
                  },
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
