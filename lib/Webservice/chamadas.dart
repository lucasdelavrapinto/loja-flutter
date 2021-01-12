import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:tionico/MOBX/STORE.dart';

import 'package:tionico/Webservice/shared_preferences.dart';
import 'package:tionico/utils.dart';

import '../env.dart';

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
  print("getBearerToken from url: $url");

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
      
      case 404:
        toastAviso("Usuário não encontrado!");
        return value;
        break;

      default:
        toastAviso("falhou");
        return value;
    }
  });
}

Future getMe() async {
  log("consultando Meus Dados GETME");

  String url = "$host/api/auth/me";
  String _token = await getSharedPreferences("access_token");

  print('--- $url');

  print(_token);

  print('---');

  return await Dio()
      .post(url,
          options: Options(headers: {"Authorization": "Bearer " + _token}))
      .then((Response response) {
    return response;
  }).catchError((onError) {
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

  return await http.post(url, body: dados).then((value) {
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

Future atualizarSenha(String novaSenha) async {
  String url = "$host/api/auth/atualizar-senha";

  String _token = await getSharedPreferences("access_token");

  print('--- $url');

  Map dados = {
    "user_cpf" : userStore.usuario.cpf,
    "user_email": userStore.usuario.email,
    "novaSenha": "$novaSenha",
  };

  return await Dio()
      .post(url,
          data: dados,
          options: Options(headers: {"Authorization": "Bearer " + _token}))
      .then((Response response) {
        log(response.data.toString());
    return response;
  }).catchError((onError) {
    // log(onError.toString());
    print('@> ERRROR: $onError');
  });
}
