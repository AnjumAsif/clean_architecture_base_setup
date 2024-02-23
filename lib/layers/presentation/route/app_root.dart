import 'package:clean_architecture_base_setup/layers/data/a_repository_impl.dart';
import 'package:clean_architecture_base_setup/layers/domain/usecase/get_all_character.dart';
import 'package:clean_architecture_base_setup/layers/presentation/ui/list_page/view/character_page.dart';
import 'package:clean_architecture_base_setup/layers/presentation/utility/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../main.dart';
import '../../data/source/locale/local_storage_impl.dart';
import '../../data/source/network/api.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final GetAllCharacters _getAllCharacters;
  var themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();
    return MaterialApp(
      themeMode: themeMode,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final tt = Theme.of(context).textTheme;
          final cs = Theme.of(context).colorScheme;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Transform.translate(
                offset: const Offset(10, 0),
                child: Text(
                  'Asif\n(GetIt)',
                  style: tt.headlineLarge!.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
              actions: [
                IconButton(
                  onPressed: () {
                    final useLight = themeMode == ThemeMode.dark ? true : false;
                    handleBrightnessChange(useLight);
                  },
                  icon: const Icon(Icons.light_mode),
                ),
              ],
            ),
            body: const CharacterPage()
                .animate()
                .fadeIn(delay: 1.2.seconds, duration: .7.seconds),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final api = ApiImpl();
    final localStorage = LocalStorageImpl(sharedPreferences: sharedPref);
    final repo = ARepositoryImpl(api: api, localStorage: localStorage);
    _getAllCharacters = GetAllCharacters(repository: repo);
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }
}
