import 'package:mobx/mobx.dart';
import 'package:tionico/Class/Produto.dart';

// Include generated file
part 'produto.g.dart';

// This is the class used by rest of your codebase
class ProdutoStore = _ProdutoStore with _$ProdutoStore;

// The store-class
abstract class _ProdutoStore with Store {
  @observable
  List<Produto> listaDeProdutos = [];

  // @action
  // void setListaDeProdutos(List value) => listaDeProdutos = value;

  @action
  addProdutoToList(Produto produto) => listaDeProdutos.add(produto);
}
