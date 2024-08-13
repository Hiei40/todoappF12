import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customcard extends StatelessWidget {
  const Customcard({super.key, required this.title, required this.desc, required this.onPressed1, required this.onPressed2});
final String title;
final String desc;
final  void Function() onPressed1;
  final  void Function() onPressed2;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(title),
        ),
        subtitle: Text(desc),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onPressed1,
              icon: Icon(Icons.edit),
              color: Colors.indigo,
            ),
            IconButton(
                onPressed: onPressed2,
                icon: Icon(Icons.delete, color: Colors.redAccent))
          ],
        ),
      ),
    );
  }
}
