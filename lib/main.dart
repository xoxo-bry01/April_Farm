import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_colours.dart';
import 'providers/booking_provider.dart';
import 'Screens/main_navigation_screen.dart';
import 'Screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pouiyfsuoedfwyqysmqy.supabase.co',
    publishableKey: 'sb_publishable_R7eN8lUM56AcVl_fvdUM5Q_KB_ezAr3',
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BookingProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'April Farm',
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;

        // If logged in, send to the main app
        if (session != null) {
          return const MainNavigationScreen();
        }

        // If not logged in, render the login/signup UI
        return const AuthScreen();
      },
    );
  }
}
