import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase/fbController.dart';

class ContactList extends StatefulWidget {
  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addContact');
              },
              icon: const Icon(Icons.add),
            )],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FbControllerAddUser().getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(snapshot.data!.docs[index]['Name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Phone :'+snapshot.data!.docs[index]['phoneNumber']),
                            Text('Addres :'+snapshot.data!.docs[index]['address']),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: ()async {
                          await  FbControllerAddUser().deleteUser(snapshot.data!.docs[index].id);
                          },
                          icon: const Icon(Icons.delete,color: Colors.red,),
                        )

                    );
                  },
                );
              }
            }
        )

    );
  }
}