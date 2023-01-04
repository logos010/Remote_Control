// ignore_for_file: avoid_unnecessary_containers, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:ui';

void confirmDialog(
    BuildContext context, String message, String title, void func()) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.blue),
          child: new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: new Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Container(
              // height: 100,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gilroy',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DialogButton(
                        color: Colors.grey,
                        radius: const BorderRadius.all(Radius.circular(48)),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 100,
                      ),
                      DialogButton(
                        color: Colors.blue,
                        radius: const BorderRadius.all(Radius.circular(48)),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          func();
                        },
                        width: 100,
                      ),
                    ],
                  )
                ],
              ),
            ),
            actionsOverflowButtonSpacing: 10,
          ),
        ),
      );
    },
  );
}

void successDialogWithFunc(BuildContext context, String content, void func()) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Color(0xFF0D1D41)),
          child: new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: Container(
              // height: 160,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    'Remote Control',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                      ),
                      onPressed: func,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "OK",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actionsOverflowButtonSpacing: 10,
          ),
        ),
      );
    },
  );
}

void errorDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Color(0xFF0D1D41)),
          child: new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: Container(
              // height: 160,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    'Remote Control',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "OK",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actionsOverflowButtonSpacing: 10,
          ),
        ),
      );
    },
  );
}

void errorDialogWithFunc(BuildContext context, String content, void func()) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Color(0xFF0D1D41)),
          child: new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: Container(
              // height: 160,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    'Remote Control',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                      ),
                      onPressed: func,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "OK",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actionsOverflowButtonSpacing: 10,
          ),
        ),
      );
    },
  );
}
