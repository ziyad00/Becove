import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui_auth;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:tracker/constants/colors.dart';
import 'package:tracker/features/home/home.dart';
import 'package:tracker/features/previous_timers/previous_timer.dart';
import 'package:tracker/features/stats/stats.dart';
import 'package:tracker/features/stats/stats_viewmodel.dart';
import 'package:tracker/features/tracker/tracker.dart';
import 'package:tracker/features/tracker/tracker_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'firebase/firebase_options.dart';
import 'package:calendar_view/calendar_view.dart';

void main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebase_ui_auth.FirebaseUIAuth.configureProviders([
    GoogleProvider(
        clientId:
            '215782954937-hfkvuq1fuaprjgraburjta1od4cqa1c8.apps.googleusercontent.com')
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var providers = [
      firebase_ui_auth.EmailAuthProvider(),
      // firebase_ui_auth.OAuthProviderButton(
      //   provider: GoogleProvider(clientId: ''),
      // ),
    ];

    return MultiProvider(
      providers: [
        Provider<TrackerRepository>(create: (_) => TrackerRepository()),
        Provider<StatsViewModel>(create: (_) => StatsViewModel()),
      ],
      child: riverpod.ProviderScope(
        child: MaterialApp(
          initialRoute:
              FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            '/sign-in': (context) {
              // TODO: Test it
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.pushReplacementNamed(context, '/home');
              }
              return firebase_ui_auth.SignInScreen(
                providers: [
                  firebase_ui_auth.EmailAuthProvider(),
                  GoogleProvider(
                      clientId:
                          '215782954937-hfkvuq1fuaprjgraburjta1od4cqa1c8.apps.googleusercontent.com')
                ],
                actions: [
                  firebase_ui_auth.AuthStateChangeAction<
                      firebase_ui_auth.SignedIn>((context, state) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }),
                ],
              );
            },
            '/profile': (context) {
              return firebase_ui_auth.ProfileScreen(
                providers: providers,
                actions: [
                  firebase_ui_auth.SignedOutAction((context) {
                    Navigator.pushReplacementNamed(context, '/sign-in');
                  }),
                ],
              );
            },
            '/home': (context) {
              return HomeScreen();
            },
            '/tracker': (context) {
              return TrackerScreen();
            },
            '/stats': (context) {
              return StatsScreen();
            },
            '/previous_timers': (context) {
              return PreviousTimersScreen();
            },
          },
          // home: const MyHomePage(),
        ),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({
    super.key,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: darkBlue,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would because?
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello!\nI\'m Becovo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )),
            Text(
              'Track your time in the\ncoolest possible way',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 22),
            ),
            SizedBox(
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Continue"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFCA311),
                  minimumSize: Size(200, 40)),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
