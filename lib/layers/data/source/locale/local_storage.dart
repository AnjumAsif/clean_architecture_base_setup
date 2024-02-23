import 'package:clean_architecture_base_setup/layers/data/dto/character_dto.dart';

const cachedCharacterListKey = 'CACHED_CHARACTER_LIST_PAGE';
abstract class LocalStorage{
  Future<bool> saveCharactersPage({
    required int page,
    required List<CharacterDto> list,
  });

  List<CharacterDto> loadCharactersPage({required int page});
}