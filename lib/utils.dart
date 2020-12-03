import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tionico/Webservice/chamadas.dart';

import 'Class/Usuario.dart';
import 'MOBX/STORE.dart';

toastAviso(String texto,
    {ToastGravity position = ToastGravity.BOTTOM,
    Color cor = Colors.teal,
    double textoSize = 18,
    double opacity = 0.9}) async {
  await Fluttertoast.showToast(
      msg: toBeginningOfSentenceCase(texto.toLowerCase()),
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
      gravity: position,
      backgroundColor: cor.withOpacity(opacity),
      textColor: Colors.white,
      fontSize: textoSize);
}

Future<bool> refreshMe() async {
  print('consultando meus dados');

  return await getMe().then((response) async {
    print(">>>>>>>>>>>>>>");
    print(response.data);

    if (response.data['status'] == "Token de Autorização não encontrada!") {
      // toastAviso("Falha ao consultar dados.");

      return false;
    }

    Usuario user = Usuario.fromMap(response.data);
    print([user.name, user.email].toString());
    userStore.setUser(user);
    print('passou');
    return true;
  }).catchError((onError) {
    return false;
  });
}
