import 'package:clean_architecture_base_setup/layers/domain/entity/character_modal.dart';
import 'package:clean_architecture_base_setup/layers/domain/repository/a_repository.dart';

class GetAllCharacters {
  final ARepository _aRepository;

  GetAllCharacters({required ARepository repository})
      : _aRepository = repository;

  Future<List<CharacterModal>> call({int page = 0}) async {
    final list = await _aRepository.getData(page: page);
    return list;
  }
}
