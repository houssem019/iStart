import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notifs = true;
  Widget buildListtile(String title, Function()? tapHandler) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: ListTile(
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Color.fromARGB(255, 190, 210, 224),
        ),
        title: Text(title,
            style: TextStyle(
              color: Color.fromARGB(255, 190, 210, 224),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            )),
        onTap: tapHandler,
      ),
    );
  }

  Widget buildSwitchTile(String title, bool currentvalue, var updateValue) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 190, 210, 224),
          ),
        ),
        value: currentvalue,
        onChanged: updateValue,
        activeColor: Color.fromARGB(255, 190, 210, 224),
      ),
    );
  }

  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 190, 210, 224),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 64, 84).withOpacity(1),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 55, 134, 150),
                Color.fromARGB(255, 190, 210, 224),
              ],
            ),
          ),
        ),
        title: Text(
          "Settings & Privacy",
          style: TextStyle(
            color: Color.fromARGB(255, 46, 64, 84),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          title("My Profile"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              endIndent: 20,
              indent: 20,
              height: 1,
              thickness: 1,
              color: Color.fromARGB(255, 190, 210, 224),
            ),
          ),
          buildListtile("Edit profile", () {}),
          buildListtile("Change password", () {}),
          buildListtile("Privacy", () {}),
          title("Notifications"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              endIndent: 20,
              indent: 20,
              height: 1,
              thickness: 1,
              color: Color.fromARGB(255, 190, 210, 224),
            ),
          ),
          buildSwitchTile(
            "App notifications",
            notifs,
            (newValue) {
              setState(() {
                notifs = newValue;
              });
            },
          ),
          title("More"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              endIndent: 20,
              indent: 20,
              height: 1,
              thickness: 1,
              color: Color.fromARGB(255, 190, 210, 224),
            ),
          ),
          buildListtile("Language", () {}),
          buildListtile("Help & Support", () {}),
          buildListtile("About", () {}),
        ],
      ),
    );
  }
}
