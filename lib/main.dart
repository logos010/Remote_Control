// ignore_for_file: unnecessary_new, prefer_const_constructors, depend_on_referenced_packages, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:remote_controller/Model/UrlModel.dart';
import 'package:remote_controller/add_title.dart';
import 'package:remote_controller/edit_title.dart';
import 'Common/LocalStoreKey.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  List<UrlModel> titles = [];

  void saveToPfrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'titles', jsonEncode(titles.map((i) => i.toJson()).toList()));
  }

  void getFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String titlesFromPrefs = prefs.getString('titles')!;
    titles = List<UrlModel>.from(
      json.decode(titlesFromPrefs).map(
            (urlModel) => UrlModel.fromJson(urlModel),
          ),
    );
    setState(() {});
  }

  void callTrashApi(UrlModel urlModel) async {
    var url = Uri.http(urlModel.url, '');
    try {
      var response = await http.get(url);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  @override
  void initState() {
    super.initState();
    getFromPrefs();
  }

  Future<void> backToTurnOff(UrlModel urlModel) =>
      Future.delayed(Duration(milliseconds: urlModel.duration), () {
        refresh(urlModel);
      });

  void refresh(UrlModel urlModel) {
    setState(() {
      urlModel.status = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME PAGE'),
        actions: [
          IconButton(
              onPressed: () {
                UrlModel createUrlModel = new UrlModel();
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => AddTitle(),
                      ),
                    )
                    .then((value) => {
                          if (value != null)
                            {
                              setState(() {
                                createUrlModel = UrlModel.fromJson(value);
                                titles.add(createUrlModel);
                                saveToPfrefs();
                              })
                            }
                        });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: (titles.isEmpty)
            ? Center(
                child: Text(
                  'List empty',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              )
            : ListView.builder(
                // padding: const EdgeInsets.all(8),
                itemCount: titles.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      UrlModel editUrlModel = new UrlModel();
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => EditTitle(titles[index]),
                            ),
                          )
                          .then((value) => {
                                if (value != null)
                                  {
                                    setState(() {
                                      editUrlModel = UrlModel.fromJson(value);
                                      // titles.add(createUrlModel);
                                      titles.elementAt(index).title =
                                          editUrlModel.title;
                                      titles.elementAt(index).url =
                                          editUrlModel.url;
                                      titles.elementAt(index).duration =
                                          editUrlModel.duration;

                                      saveToPfrefs();
                                    })
                                  }
                              });
                    },
                    child: Container(
                      height: 70,
                      color: (index % 2 == 0) ? Colors.grey[200] : Colors.white,
                      child: cardViewTitle(titles[index], index),
                    ),
                  );
                }),
      ),
    );
  }

  Widget cardViewTitle(UrlModel urlModel, int index) {
    return Dismissible(
      key: ObjectKey(index),
      background: rightDeleteIcon,
      secondaryBackground: rightDeleteIcon,
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Remote Control"),
              content: Text(
                  "Are you sure you want to delete " + urlModel.title + "?"),
              actions: <Widget>[
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      titles.removeAt(index);
                      saveToPfrefs();
                      setState(() {});
                    },
                    child: const Text("DELETE")),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        urlModel.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text('(' + urlModel.duration.toString() + 'ms)'),
                    ],
                  ),
                  Spacer(),
                  FlutterSwitch(
                    width: 50,
                    height: 30,
                    value: urlModel.status,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.black12,
                    toggleColor: Colors.white,
                    onToggle: (value) {
                      urlModel.status = value;
                      setState(() {});
                      if (urlModel.status == true && urlModel.duration != 0) {
                        callTrashApi(urlModel);
                        backToTurnOff(urlModel);
                      } else {
                        callTrashApi(urlModel);
                      }
                    },
                  ),
                ],
              ),
              Spacer(),
              Text(
                urlModel.url,
                style: TextStyle(color: Colors.black38),
              )
            ],
          ),
        ),
      ),
    );
  }

  final rightDeleteIcon = Container(
    color: Colors.red,
    child: Icon(
      Icons.delete,
      color: Colors.white,
    ),
    alignment: Alignment.centerRight,
  );
}
