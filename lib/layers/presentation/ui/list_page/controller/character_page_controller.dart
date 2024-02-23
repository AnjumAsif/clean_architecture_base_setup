import 'package:clean_architecture_base_setup/layers/domain/entity/character_modal.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/get_all_character.dart';

enum CharacterPageStatus { initial, loading, success, failed }

class CharacterPageController {
  final GetAllCharacters _getAllCharacters;

  CharacterPageController({required GetAllCharacters allCharacters})
      : _getAllCharacters = allCharacters;

  final status = ValueNotifier(CharacterPageStatus.initial);
  final characters = ValueNotifier(<CharacterModal>[]);
  final currentPage = ValueNotifier(1);
  final hasReachedEnd = ValueNotifier(false);

  Future<void> fetchNextPage() async {
    if (hasReachedEnd.value) {
      return;
    }
    status.value = CharacterPageStatus.loading;
    final list = await _getAllCharacters.call(page: currentPage.value);

    currentPage.value = currentPage.value + 1;
    characters.value = characters.value..addAll(list);
    status.value = CharacterPageStatus.success;
    hasReachedEnd.value = list.isEmpty;
  }
}
