import 'dart:convert';
import 'package:booky/core/data/local/store_manager.dart';

abstract class BooksStoreProvider {
  final StoreManager _storeManager;
  BooksStoreProvider(this._storeManager);
  
  List<String> getFavoriteBooks();
  Future addFavoriteBook(String workId);
  Future<List<String>> addFavoriteBooks(List<String> workIds);
  Future removeFavoriteBook(String workId);
}

class AppBooksStoreProvider extends BooksStoreProvider {
  AppBooksStoreProvider(super.storeManager);

  @override
  Future addFavoriteBook(String workId) async {
    final favoriteBooks = getFavoriteBooks();
    favoriteBooks.add(workId);
    await addFavoriteBooks(favoriteBooks);
  }

  @override
  List<String> getFavoriteBooks() {
    final favoriteObject = _storeManager.get(_BooksStoreKeys.favorite);
    if(favoriteObject == null) return [];
    return (jsonDecode(favoriteObject) as List<dynamic>).map((e) => e.toString()).toList();
  }

  @override
  Future removeFavoriteBook(String workId) async {
    final favoriteBooks = getFavoriteBooks();
    favoriteBooks.removeWhere((element) => element == workId);
    await addFavoriteBooks(favoriteBooks);
  }

  @override
  Future<List<String>> addFavoriteBooks(List<String> workIds) async {
    final value = await _storeManager.set(_BooksStoreKeys.favorite, jsonEncode(workIds));

    if(!value) return [];

    return getFavoriteBooks();
  }
}

abstract class _BooksStoreKeys {
  static const String favorite = 'FAVORITE_WORK_KEY';
}