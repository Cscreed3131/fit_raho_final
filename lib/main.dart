import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_raho/firebase_options.dart';
import 'package:fit_raho/src/auth/screens/client_signup_screen.dart';
import 'package:fit_raho/src/owner/screens/member_list_screen.dart';
import 'package:fit_raho/src/owner/screens/trainer_list_screen.dart';
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
          seedColor: Colors.green,
          background: const Color(0xFFF9FEFF),
          primary: const Color(0xFF276221),
          secondary: const Color(0xFF3B8132),
          tertiary: const Color(0xFFF1F9EC),
          primaryContainer: const Color(0xFFACD8A7),
          onPrimary: const Color(0xFF1DB233),
          outline: const Color(0xFF3B8132),
          outlineVariant: const Color(0xFF46923C),
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
      routes: {
        ClientSignUpScreen.routeName: (context) => const ClientSignUpScreen(),
        // TrainerSignUpScreen.routeName: (context) => const TrainerSignUpScreen(),
        // OwnerSignUpScreen.routeName: (context) => const OwnerSignUpScreen(),
        MemberListScreen.routeName: (context) => const MemberListScreen(),
        TrainerListScreen.routeName: (context) => const TrainerListScreen(),
      },
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       // Get the user data
      //       return const OwnerHomeScreen();
      //     }
      //     return const LoginScreen();
      //   },
      // ),
      home: const ClientSignUpScreen(),
      //OwnerHomePage(), //for drawer test by bikash
      //home: SignUpPage(isGymOwner: true), //changes by akash
    );
  }
}
