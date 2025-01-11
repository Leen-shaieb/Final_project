import 'package:flutter/material.dart';
class Utils {
  Future <void> ShowMyDialog(context, title, content) async {
    print(title);
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
      builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(content)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
        )
            ],
          );

      }
    );
  }
}