import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tionico/Webservice/chamadas.dart';

import 'Class/Usuario.dart';
import 'MOBX/STORE.dart';

final TextStyle fonteTexto = GoogleFonts.poppins(fontSize: 14);
final TextStyle fonteObs = GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);

final MaskTextInputFormatter maskDateFormatter = MaskTextInputFormatter(mask: '##/##/####');
final MaskTextInputFormatter maskCpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
final MaskTextInputFormatter maskTelefoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####');

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

    if(response.data.isEmpty){
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
