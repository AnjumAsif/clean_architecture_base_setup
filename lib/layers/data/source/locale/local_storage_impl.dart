import 'package:clean_architecture_base_setup/layers/data/dto/character_dto.dart';
import 'package:clean_architecture_base_setup/layers/data/source/locale/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences _sharedPreferences;

  LocalStorageImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  List<CharacterDto> loadCharactersPage({required int page}) {
    final key = getKeyToPage(page);
    final jsonList = _sharedPreferences.getStringList(key);

    return jsonList != null
        ? jsonList.map((e) => CharacterDto.fromRawJson(e)).toList()
        : [];
  }

  @override
  Future<bool> saveCharactersPage(
      {required int page, required List<CharacterDto> list}) {
    final jsonList = list.map((e) => e.toRawJson()).toList();
    final key = getKeyToPage(page);
    return _sharedPreferences.setStringList(key, jsonList);
  }

  @visibleForTesting
  static String getKeyToPage(int page) {
    return '${cachedCharacterListKey}_$page';
  }
}
