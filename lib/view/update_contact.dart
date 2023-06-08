import 'package:app_contact/controller/contact_controller.dart';
import 'package:app_contact/model/contact_model.dart';
import 'package:app_contact/view/contact.dart';
import 'package:flutter/material.dart';

class UpdateContact extends StatefulWidget {
  UpdateContact({
    Key? key,
    required this.docId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  }) : super(key: key);

  final String? docId;
  String? name;
  String? phone;
  String? email;
  String? address;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var cc = ContactController();
  final formkey = GlobalKey<FormState>();

  // String? name;
  // String? phone;
  // String? email;
  // String? address;

  // String? docId;

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
                  initialValue: widget.name,
                  decoration: const InputDecoration(hintText: 'Name'),
                  onChanged: (value) {
                    widget.name = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.phone,
                  decoration: const InputDecoration(hintText: 'Phone'),
                  onChanged: (value) {
                    widget.phone = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.email,
                  decoration: const InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    widget.email = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.address,
                  decoration: const InputDecoration(hintText: 'Address'),
                  onChanged: (value) {
                    widget.address = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState != null &&
                        formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      ContactModel cm = ContactModel(
                        name: widget.name!,
                        phone: widget.phone!,
                        email: widget.email!,
                        address: widget.address!,
                      );
                      cc.updateContact(widget.docId!, cm);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const Contact()),
                        ),
                      );
                    }
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
