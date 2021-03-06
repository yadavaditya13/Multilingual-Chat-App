import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter_chat_app/Language.dart';
import 'package:flutter_chat_app/models/curuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Settings",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        SizedBox(height: 5.0),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Language",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          child: DropDownField(
            controller: lang_selected,
            hintText: "Choose Prefered Language(eg. "+CurUser.language+")",
            enabled: true,
            items: st,
            onValueChanged: (value) {
              print(value);
              CurUser.language = value;
              CurUser.lang = codes[value];
              saveLanguageToLocalStorage();
            },
          ),
        ),
        SizedBox(height: 15.0),
      ]),
    );
  }

  Future<void> saveLanguageToLocalStorage() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('cur_lang', CurUser.lang);
      prefs.setString('cur_language', CurUser.language);
  }
}

final lang_selected = TextEditingController();
List<String> st = codes.keys.toList();
