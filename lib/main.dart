import 'package:contri/apis/auth_api.dart';
import 'package:contri/core/error_page.dart';
import 'package:contri/features/auth/controller/auth_controller.dart';
import 'package:contri/features/auth/view/login_view.dart';
import 'package:contri/features/home/screen/home_screeen.dart';
import 'package:contri/models/user.dart';
import 'package:contri/router.dart';
import 'package:contri/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  User? userData;
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setString('x-auth-token', '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(data: (user) {
        if (user != null) {
          return const HomeScreen();
        } else {
          return const LoginView();
        }
      }, error: (error, stackTrace) {
        return ErrorPage(error: error.toString());
      }, loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}
