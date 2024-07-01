import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_raho/firebase_options.dart';
import 'package:fit_raho/loading_splash_screen.dart';
import 'package:fit_raho/src/admin/screens/admin_home_screen.dart';
import 'package:fit_raho/src/admin/screens/gym_onboarding_screen.dart';
import 'package:fit_raho/src/auth/screens/signin_screen.dart';
import 'package:fit_raho/src/auth/screens/signup_screen.dart';
import 'package:fit_raho/src/gym/screens/client_on_boarding_screen.dart';
import 'package:fit_raho/src/gym/screens/member_list_screen.dart';
import 'package:fit_raho/src/gym/screens/trainer_list_screen.dart';
import 'package:fit_raho/src/gym/screens/trainer_on_bording_screen.dart';
import 'package:fit_raho/src/home/screens/client_home_screen.dart';
import 'package:fit_raho/src/home/screens/gym_home_screen.dart';
import 'package:fit_raho/src/home/screens/trainer_home_screen.dart';
import 'package:fit_raho/src/home/widgets/home_screen_widget.dart';
import 'package:fit_raho/src/trainer/screens/create_workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.001),
      statusBarColor: Colors.amber.withOpacity(0.001),
    ),
  );
//Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Raho',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          background: const Color(0xFFF9FEFF),
          primary: const Color(0xFFD32F2F), // Red primary color
          secondary: const Color(0xFFEF5350), // Red secondary color
          tertiary: const Color(0xFFFDF2F2), // Light red tertiary color
          primaryContainer: const Color(0xFFE57373), // Light red for containers
          onPrimary: const Color(0xFFB71C1C), // Dark red for text on primary
          outline: const Color(0xFFEF5350), // Red outline
          outlineVariant:
              const Color(0xFFC62828), // Darker red variant for outline
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(1),
          ),
        ),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSplashScreen();
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        AdminHomeScreen.routeName: (context) => const AdminHomeScreen(),
        ClientHomeScreen.routeName: (context) => const ClientHomeScreen(),
        TrainerHomeScreen.routeName: (context) => const TrainerHomeScreen(),
        GymHomeScreen.routeName: (context) => const GymHomeScreen(),
        ClientOnBoardingScreen.routeName: (context) =>
            const ClientOnBoardingScreen(),
        TrainerOnboardingScreen.routeName: (context) =>
            const TrainerOnboardingScreen(),
        GymOnboardingScreen.routeName: (context) => const GymOnboardingScreen(),
        TrainerListScreen.routeName: (context) => const TrainerListScreen(),
        MemberListScreen.routeName: (context) => const MemberListScreen(),
        CreateWorkoutScreen.routeName: (context) => const CreateWorkoutScreen(),
      },
    );
  }
}
