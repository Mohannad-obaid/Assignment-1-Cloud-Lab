// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'firebase/fbController.dart';
import 'model/userModel.dart';
import 'package:quickalert/quickalert.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();

  void _saveContact() async {

    if (_formKey.currentState!.validate()) {
      
         // showAlertDialog(context);

      userModel user = userModel(
        Name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        address: _addressController.text,
      );

      await FbControllerAddUser().addUser(user: user).then((value) => QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Add  Successfully!',
      )).onError((error, stackTrace) => QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong',
      ));

      _nameController.clear();
      _phoneNumberController.clear();
      _addressController.clear();
    }
  }

  showAlertDialog(BuildContext context) {

    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return  Center(
            widthFactor: 100,
            heightFactor: 100,
            child: const CircularProgressIndicator()
        );
      },
    );

    Timer(const Duration(seconds: 2), () {
      return; // Exit from this function after 2 seconds
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveContact,

                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
