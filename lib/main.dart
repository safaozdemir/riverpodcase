import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodcase/services/sharedPrefencesService.dart';
import 'package:riverpodcase/view/homeScreen.dart';
import 'package:riverpodcase/view/loginView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TokenService.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final isTokenNull = StateProvider((ref) async {
  String? token = await TokenService.getStringData();
  return token;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(isTokenNull.state).state;
    print(token);
    if (token == null) {
      return MaterialApp(
        title: 'Flutter Demo',
        home: LogInView(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
      );
    }
  }
}
