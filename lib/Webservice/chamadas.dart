import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:tionico/Webservice/shared_preferences.dart';
import 'package:tionico/utils.dart';

String host = "http://192.168.2.103:8080";

Future<dynamic> getConsultaProdutos() async {
  log("consultando API");

  String url = "$host/api/v1/produtos";
  String _token = await getSharedPreferences("access_token");

  print('---');

  return await Dio()
      .get(url,
          options: Options(headers: {"Authorization": "Bearer " + _token}))
      .then((Response response) => response)
      .catchError((onError) {
    log(onError.toString());
  });
}

Future getBearerToken(String email, String password) async {
  String url = "$host/api/auth/login";

  return await http
      .post(url, body: {"email": email, "password": password}).then((value) {
    switch (value.statusCode) {
      case 200:
        return value;
        break;

      case 401:
        toastAviso("Não Autorizado");
        return value;
        break;

      default:
        toastAviso("falhou");
        return value;
    }
  });
}

Future getMe() async {
  log("consultando Meus Dados");

  String url = "$host/api/auth/me";
  String _token = await getSharedPreferences("access_token");

  print('---');

  return await Dio()
      .post(url,
          options: Options(headers: {"Authorization": "Bearer " + _token}))
      .then((Response response){
        return response;
      })
      .catchError((onError) {
    // log(onError.toString());
    print('@> ERRROR: $onError');
  });
}

Future logout() async {
  String url = "$host/api/auth/logout";
  String _token = await getSharedPreferences("access_token");

  return await Dio()
      .post(url,
          options: Options(headers: {"Authorization": "Bearer " + _token}))
      .then((Response value) => value);
}

Future doCadastro(Map dados) async {
  
  String url = "$host/api/auth/cadastro";

  return await http
      .post(url, body: dados).then((value) {
    switch (value.statusCode) {
      case 200:
        return value;
        break;

      case 400:
        var res = json.decode(value.body);
        toastAviso(res['error']);
        return value;
        break;

      case 401:
        toastAviso("Não Autorizado");
        return value;
        break;
        

      default:
        toastAviso("falhou");
        return value;
    }
  });
}
