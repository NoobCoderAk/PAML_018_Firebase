import 'package:app_contact/controller/contact_controller.dart';
import 'package:app_contact/model/contact_model.dart';
import 'package:app_contact/view/add_contact.dart';
import 'package:app_contact/view/update_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var cc = ContactController();

  @override
  void initState() {
    cc.getContact();
    super.initState();
  }

  void deleteContact(id) async {
    await cc.deleteContact(id);
  }

  void updateContact(String docId, ContactModel contactModel) async {
    await cc.updateContact(docId, contactModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Contact List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: StreamBuilder<List<DocumentSnapshot>>(
                  stream: cc.stream,
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final List<DocumentSnapshot> data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Card(
                            elevation: 8,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  data[index]['name']
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(data[index]['name']),
                              subtitle: Text(data[index]['phone']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => UpdateContact(
                                                docId: data[index]['id'],
                                                name: data[index]['name'],
                                                phone: data[index]['phone'],
                                                email: data[index]['email'],
                                                address: data[index]['address'],
                                              )),
                                        ),
                                      );
                                    }),
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: (() {
                                      deleteContact(data[index].id);
                                      setState(() {
                                        data.removeAt(index);
                                      });
                                    }),
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const AddContact()),
            ),
          );
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
