// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:remote_controller/Common/custom_popup.dart';
import 'package:remote_controller/Model/UrlModel.dart';

class AddTitle extends StatefulWidget {
  const AddTitle({super.key});

  @override
  State<AddTitle> createState() => _AddTitleState();
}

class _AddTitleState extends State<AddTitle> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController durationController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE CONTROLL'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (titleController.text.isEmpty ||
              durationController.text.isEmpty ||
              urlController.text.isEmpty) {
            errorDialog(context, 'The value must not be empty');
          }
          UrlModel urlModel = new UrlModel();
          urlModel.title = titleController.text;
          urlModel.duration = int.parse(durationController.text);
          urlModel.status = false;
          urlModel.url = urlController.text;

          Navigator.of(context).pop(urlModel.toJson());
        },
        label: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: Text(
              'CREATE',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '* ',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    'Title',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              TextField(
                controller: titleController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '* ',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    'Duration',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('(ms)'),
                ],
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: durationController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '* ',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    'Url',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              TextField(
                controller: urlController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
