import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_colours.dart';
import 'providers/booking_provider.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/admin/admin_navigation_screen.dart';

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

  Future<Widget> _getDestinationScreen(String userId) async {
    const adminUserTypeId = '76acea62-0282-4d95-9df3-42dba48f1102';

    try {
      final response = await Supabase.instance.client
          .from('tblUser')
          .select('UserTypeID')
          .eq('UserID', userId)
          .maybeSingle();

      if (response != null && response['UserTypeID'] == adminUserTypeId) {
        return const AdminNavigationScreen();
      }
    } catch (e) {
      debugPrint('Error fetching user role: $e');
    }
    return const MainNavigationScreen();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;

        if (session != null) {
          return FutureBuilder<Widget>(
            future: _getDestinationScreen(session.user.id),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryOrange,
                    ),
                  ),
                );
              }
              return roleSnapshot.data ?? const MainNavigationScreen();
            },
          );
        }

        return const SplashScreen();
      },
    );
  }
}
