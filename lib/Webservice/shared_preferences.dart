import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/*
 * access_token será usado para autenticação
*/

Future getSharedPreferences(String string) async {
  return await SharedPreferences.getInstance()
      .then((prefs) => prefs.getString(string));
}

saveSharedPreferences(String string, String value) async {

  log([string, value].toString());

  return await SharedPreferences.getInstance().then((prefs) => prefs.setString(string, value));
}
