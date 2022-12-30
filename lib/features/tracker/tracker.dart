import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/constants/colors.dart';
import 'package:tracker/features/tracker/models/timer.dart';
import 'package:tracker/features/tracker/tracker_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/tracker/viewmodel.dart';

class TrackerScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Time"),
        backgroundColor: darkBlue,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // AppBarTrackerScreen(),
            SizedBox(),
            Center(child: MiddleSection()),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("End Session"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF14213D),
                    minimumSize: Size(350, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiddleSection extends ConsumerWidget {
  getDateInForm(seconds) {
    var current = seconds;
    var hours = (current / 3600).floor();
    var minutes = ((current % 3600) / 60).floor();
    var seconds2 = current % 60;
    if (hours == 0) {
      return "${minutes}:${seconds2}";
    } else {
      return "${hours}:${minutes}:${seconds2}";
    }
  }

  Stream<String> calcTimerPeriodically(DateTime date) async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      final DateTime now = DateTime.now();
      a = now.difference(date).inSeconds;
      return getDateInForm(a);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerProviderRev = ref.watch(timerProvider);
    AsyncValue<Timer> timerStream = ref.watch(lastTimer);
    // rebuild the widget when the todo list changes
    // List<Timer> todos = ref.watch(todosProvider).todos;
    return timerStream.when(
        data: (timer) {
          print(timer);
          return Column(
            children: [
              timer.status!
                  ? StreamBuilder(
                      initialData: "",
                      stream: calcTimerPeriodically(timer.start!.toDate()),
                      builder: (context, snapshot) {
                        return Text(
                          "${snapshot.data.toString()}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40, color: textBlue),
                        );
                      },
                    )
                  : Text(""),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   "${getDateHourly(Timestamp.now().seconds - timer.start!.seconds)}",
              //   style: TextStyle(fontSize: 30, color: Color(0xFF371B34)),
              // ),
              Text(
                "Start Timer",
                style: TextStyle(fontSize: 30, color: darkBlue),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Be Productive With Us",
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(.50)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 150,
                  // ),
                  Image.asset('images/1.png'),
                  Image.asset('images/2.png'),

                  GestureDetector(
                    child: timer.status!
                        ? Icon(
                            Icons.stop_circle,
                            size: 80,
                          )
                        : Icon(
                            Icons.play_circle,
                            size: 80,
                          ),
                    onTap: () {
                      timerProviderRev.onStartPauseTimer(timer);
                    },
                  ),
                  Image.asset('images/4.png'),
                  Image.asset('images/5.png'),
                ],
              ),
            ],
          );
        },
        error: (err, stack) {
          print(err);
          final x = false
              ? Center(child: Text('Error: $err'))
              : Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   "${getDateHourly(Timestamp.now().seconds - timer.start!.seconds)}",
                    //   style: TextStyle(fontSize: 30, color: Color(0xFF371B34)),
                    // ),
                    Text(
                      "Start Timer",
                      style: TextStyle(fontSize: 30, color: textBlue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Be Productive With Us",
                      style: TextStyle(
                          fontSize: 13, color: Colors.black.withOpacity(.50)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   width: 150,
                        // ),
                        Image.asset('images/1.png'),
                        Image.asset('images/2.png'),

                        GestureDetector(
                          child: Icon(
                            Icons.play_circle,
                            size: 80,
                          ),
                          onTap: () {
                            timerProviderRev
                                .onStartPauseTimer(Timer(status: false));
                          },
                        ),
                        Image.asset('images/4.png'),
                        Image.asset('images/5.png'),
                      ],
                    ),
                  ],
                );
          return x;
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class AppBarTrackerScreen extends StatefulWidget {
  const AppBarTrackerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBarTrackerScreen> createState() => _AppBarTrackerScreenState();
}

class _AppBarTrackerScreenState extends State<AppBarTrackerScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() async {
    user = await FirebaseAuth.instance.currentUser;
    print(user!.photoURL!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
          child: Icon(
            Icons.arrow_downward_rounded,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 20, 0),
          child: user != null
              ? Image.network(
                  user!.photoURL!,
                  scale: 1.5,
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  // errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : CircularProgressIndicator(),
        )
      ],
    );
  }
}
