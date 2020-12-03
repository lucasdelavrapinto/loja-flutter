import 'package:mobx/mobx.dart';
import 'package:tionico/Class/Usuario.dart';

part 'User.g.dart';

// This is the class used by rest of your codebase
class UserStore = _UserStore with _$UserStore;

// The store-class
abstract class _UserStore with Store {

  @observable
  Usuario usuario;

  @action
  void setUser(Usuario user) => usuario = user;

}