// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoStore on _ProdutoStore, Store {
  final _$listaDeProdutosAtom = Atom(name: '_ProdutoStore.listaDeProdutos');

  @override
  List<Produto> get listaDeProdutos {
    _$listaDeProdutosAtom.reportRead();
    return super.listaDeProdutos;
  }

  @override
  set listaDeProdutos(List<Produto> value) {
    _$listaDeProdutosAtom.reportWrite(value, super.listaDeProdutos, () {
      super.listaDeProdutos = value;
    });
  }

  final _$_ProdutoStoreActionController =
      ActionController(name: '_ProdutoStore');

  @override
  dynamic addProdutoToList(Produto produto) {
    final _$actionInfo = _$_ProdutoStoreActionController.startAction(
        name: '_ProdutoStore.addProdutoToList');
    try {
      return super.addProdutoToList(produto);
    } finally {
      _$_ProdutoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaDeProdutos: ${listaDeProdutos}
    ''';
  }
}
