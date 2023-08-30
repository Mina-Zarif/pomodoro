import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro/constants.dart';
import 'package:pomodoro/core/utils/app_data.dart';
import 'package:pomodoro/core/utils/theming.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_cubit.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_state.dart';

import 'features/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AppDataAdapter());
  await Hive.openBox<AppData>(boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomoCubit()..getAppData(),
      child: BlocBuilder<PomoCubit, PomoState>(
        builder: (context, state) {
          isDark = BlocProvider.of<PomoCubit>(context).darkMode;
          return MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
            theme: (isDark) ? AppThemes.darkTheme : AppThemes.lightTheme,
          );
        },
      ),
    );
  }
}
