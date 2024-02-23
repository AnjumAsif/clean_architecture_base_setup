import 'package:clean_architecture_base_setup/layers/data/source/locale/local_storage.dart';
import 'package:clean_architecture_base_setup/layers/domain/entity/character_modal.dart';
import 'package:clean_architecture_base_setup/layers/domain/repository/a_repository.dart';

import 'source/network/api.dart';

class ARepositoryImpl implements ARepository {
  final Api _api;
  final LocalStorage _localStorage;

  ARepositoryImpl({required Api api, required LocalStorage localStorage})
      : _api = api,
        _localStorage = localStorage;

  @override
  Future<List<CharacterModal>> getData({int page = 0}) async {
    final cachedList = _localStorage.loadCharactersPage(page: page);
    if (cachedList.isNotEmpty) {
      return cachedList;
    }

    final fetchedList = await _api.loadCharacters(page: page);
    await _localStorage.saveCharactersPage(page: page, list: fetchedList);
    return fetchedList;
  }
}
