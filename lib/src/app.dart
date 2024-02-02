import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wik/src/fetch_user_data.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        User? verifiedUser = FirebaseAuth.instance.currentUser;
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FirebaseUILocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ko'),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          initialRoute: verifiedUser == null ? '/sign-in' : '/',
          routes: {
            '/': (context) => FetchUserData(uid: verifiedUser!.uid),
            '/sign-in': (context) {
              return SignInScreen(actions: [
                AuthStateChangeAction<UserCreated>((context, state) {
                  Navigator.pushReplacementNamed(context, '/verify-email');
                }),
                AuthStateChangeAction<SignedIn>((context, state) {
                  if (!state.user!.emailVerified) {
                    Navigator.pushReplacementNamed(context, '/verify-email');
                  }
                }),
              ]);
            },
            /*
             * Problems
             * 1. For quick impl, I used pushReplacementNamed instead 
             * ReplacementNamed so back button not work in verifify screen.
             * 2. user exit when verify, and re-connect right after it blocked
             * by firebase(to-many-request) so even finished verified email,
             * it's not passed to next screen, verification successed.
             */
            '/verify-email': (context) => EmailVerificationScreen(
                  // actionCodeSettings: ActionCodeSettings(...),
                  actions: [
                    EmailVerifiedAction(() {
                      Navigator.pushReplacementNamed(context, '/');
                    }),
                    AuthCancelledAction((context) {
                      // TODO(me): check page stack
                      FirebaseUIAuth.signOut();
                    }),
                  ],
                ),
            '/setting': (context) =>
                SettingsView(controller: settingsController),
            // '/profile':
          },
        );
      },
    );
  }
}