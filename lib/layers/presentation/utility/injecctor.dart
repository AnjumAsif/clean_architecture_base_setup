import 'package:clean_architecture_base_setup/layers/data/a_repository_impl.dart';
import 'package:clean_architecture_base_setup/layers/data/source/locale/local_storage.dart';
import 'package:clean_architecture_base_setup/layers/data/source/locale/local_storage_impl.dart';
import 'package:clean_architecture_base_setup/layers/data/source/network/api.dart';
import 'package:clean_architecture_base_setup/layers/domain/repository/a_repository.dart';
import 'package:clean_architecture_base_setup/layers/domain/usecase/get_all_character.dart';
import 'package:clean_architecture_base_setup/layers/presentation/ui/list_page/controller/character_page_controller.dart';
import 'package:clean_architecture_base_setup/main.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeGetIt() async {
  //..............
  // data layer
  // ..........
  getIt.registerLazySingleton<Api>(() => ApiImpl());
  getIt.registerFactory<LocalStorage>(
      () => LocalStorageImpl(sharedPreferences: sharedPref));
  getIt.registerFactory<ARepository>(
      () => ARepositoryImpl(api: getIt(), localStorage: getIt()));

  //..............
  // domain layer
  // ..........
  getIt.registerFactory(() => GetAllCharacters(repository: getIt()));

  //..............
  // presentation layer
  // ..........
  getIt.registerLazySingleton(
      () => CharacterPageController(allCharacters: getIt()));
}
