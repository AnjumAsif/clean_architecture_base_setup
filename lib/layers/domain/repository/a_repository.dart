import 'package:clean_architecture_base_setup/layers/domain/entity/character_modal.dart';

abstract class ARepository {
  Future<List<CharacterModal>> getData({int page = 0});
}
