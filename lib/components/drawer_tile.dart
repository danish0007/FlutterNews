import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final Icon icon;
  final String name;
  final Function page;

  DrawerTile({this.icon, this.name, this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: icon,
        title: Text(
          "$name",
          style: TextStyle(fontSize: 20),
        ),
        onTap: page,
      ),
    );
  }
}
