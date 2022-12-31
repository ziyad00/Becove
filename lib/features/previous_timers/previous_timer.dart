import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tracker/constants/colors.dart';
import 'package:tracker/features/home/home.dart';
import 'package:tracker/features/previous_timers/viewmodel.dart';
import 'package:tracker/features/tracker/models/timer.dart';
import 'package:tracker/features/home/home.dart' as home;
import 'package:flutter/foundation.dart';
import 'package:tracker/features/tracker/tracker_repository.dart';

class PreviousTimersScreen extends StatefulWidget {
  PreviousTimersScreen({super.key});

  @override
  State<PreviousTimersScreen> createState() => _PreviousTimersScreenState();
}

class _PreviousTimersScreenState extends State<PreviousTimersScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    ListViewCustom(),
    CalenderView(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          // backgroundColor: Color.fromARGB(255, 80, 31, 31),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 32,
              ),
              label: 'List View',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                size: 32,
              ),
              label: 'Calender View',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class ListViewCustom extends ConsumerWidget {
  const ListViewCustom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Timer>> timers = ref.watch(Timers);
    final previousTimersProvider = ref.watch(PreviousTimersProvider);
    final timersFuture = ref.watch(TimersFuture);
    return Scaffold(
        appBar: AppBar(
          title: Text("Tracks"),
          backgroundColor: darkBlue,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: timers.when(
          data: (data) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingSection(
                    title: "today's previous tracks",
                    subtitle: '',
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final date = data[index].start!.toDate();
                        final timer = data[index];

                        return Column(
                          children: [
                            home.Card(
                              title:
                                  "Duration: ${previousTimersProvider.getDateInForm(timer.end != null ? (timer.end!.seconds - timer.start!.seconds) : 0)}",
                              body:
                                  "${date.year}:${date.month}:${date.day}:${date.hour}:${date.minute} ",
                              clickbait: "Status: ${timer.status}",
                              imagePath: 'MeetupIcon',
                              color: orangeYellow,
                              textColor: darkBlue,
                              isImage2: true,
                              isImage: true,
                              screen: "/tracker",
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
        ));
  }
}

class TimerRow extends ConsumerWidget {
  final Timer timer;
  const TimerRow({
    required this.timer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previousTimersProvider = ref.watch(PreviousTimersProvider);
    final date = timer.start!.toDate();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Duration: ${previousTimersProvider.getDateInForm(timer.end != null ? (timer.end!.seconds - timer.start!.seconds) : 0)}",
          style: TextStyle(color: lightBlue, fontSize: 16),
        ),
        Text(
          "Start: ${date.year}:${date.month}:${date.day}:${date.hour}:${date.minute} ",
          style: TextStyle(color: lightBlue, fontSize: 16),
        ),
        Text(
          "Status: ${timer.status}",
          style: TextStyle(color: lightBlue, fontSize: 16),
        ),
      ],
    );
  }
}

class CalenderView extends ConsumerStatefulWidget {
  const CalenderView({super.key});

  @override
  ConsumerState<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends ConsumerState<CalenderView> {
  @override
  void initState() {
    super.initState();

    // final value = ref.read(helloWorldProvider);
    // print(value); // Hello world
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Timer>> timers = ref.watch(Timers);
    var timersStream = TrackerRepository().getAllEntryStream();

    final previousTimersProvider = ref.watch(PreviousTimersProvider);
    final toggle = ref.watch(PreviousTimersProvider).isDay;
    List<Text> intervals = [
      Text(
        "Day View",
        style: TextStyle(color: Colors.white),
      ),
      Text("Month View"),
      Text("Schedule View")
    ];

    return Scaffold(
        appBar: AppBar(
            title: toggle ? Text("Tracks") : Text("data"),
            backgroundColor: darkBlue,
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Change')));
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (
                      BuildContext context,
                    ) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: darkBlue,
                            ),
                            width: 350,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                              child: Wrap(
                                children: List<Widget>.generate(
                                  3,
                                  (int index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0, 10, 0),
                                      child: ChoiceChip(
                                        selectedColor: orangeYellow,
                                        backgroundColor: lightBlue,
                                        label: intervals[index],
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        selected:
                                            previousTimersProvider.interval ==
                                                index,
                                        onSelected: (bool selected) {
                                          previousTimersProvider.chooseInterval(
                                              selected ? index : null);
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Close'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  setState(() {});
                },
              ),
            ]),
        body: timers.when(
          data: ((data) {
            previousTimersProvider.getDataSource(data);
            if (previousTimersProvider.interval == 0) {
              return SfCalendar(
                view: CalendarView.day,
                dataSource: MeetingDataSource(previousTimersProvider.meetings),
                monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
              );
            } else if (previousTimersProvider.interval == 1) {
              return SfCalendar(
                view: CalendarView.month,
                dataSource: MeetingDataSource(previousTimersProvider.meetings),
                monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
              );
            } else {
              return SfCalendar(
                view: CalendarView.schedule,
                dataSource: MeetingDataSource(previousTimersProvider.meetings),
                monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
              );
            }
          }),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
        ));
  }
}

// class CalenderView extends ConsumerStatefulWidget {
//   const CalenderView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<Timer>> timers = ref.watch(Timers);
//     var timersStream = TrackerRepository().getAllEntryStream();

//     final previousTimersProvider = ref.watch(PreviousTimersProvider);
//     final toggle = ref.watch(PreviousTimersProvider).isDay;

//     return Scaffold(
//         appBar: AppBar(
//             title: toggle ? Text("Tracks") : Text("data"),
//             backgroundColor: darkBlue,
//             iconTheme: IconThemeData(
//               color: Colors.white, //change your color here
//             ),
//             actions: <Widget>[
//               IconButton(
//                 icon: const Icon(Icons.add_alert),
//                 tooltip: 'Show Snackbar',
//                 onPressed: () {
//                   // ScaffoldMessenger.of(context).showSnackBar(
//                   //     const SnackBar(content: Text('Change')));
//                   bottomSheet(context, ref);
//                 },
//               ),
//             ]),
//         body: timers.when(
//           data: ((data) {
//             previousTimersProvider.getDataSource(data);
//             if (previousTimersProvider.interval == 0) {
//               return SfCalendar(
//                 view: CalendarView.day,
//                 dataSource: MeetingDataSource(previousTimersProvider.meetings),
//                 monthViewSettings: MonthViewSettings(
//                   showAgenda: true,
//                   appointmentDisplayMode:
//                       MonthAppointmentDisplayMode.appointment,
//                 ),
//               );
//             } else if (previousTimersProvider.interval == 1) {
//               return SfCalendar(
//                 view: CalendarView.month,
//                 dataSource: MeetingDataSource(previousTimersProvider.meetings),
//                 monthViewSettings: MonthViewSettings(
//                   showAgenda: true,
//                   appointmentDisplayMode:
//                       MonthAppointmentDisplayMode.appointment,
//                 ),
//               );
//             } else {
//               return SfCalendar(
//                 view: CalendarView.schedule,
//                 dataSource: MeetingDataSource(previousTimersProvider.meetings),
//                 monthViewSettings: MonthViewSettings(
//                   showAgenda: true,
//                   appointmentDisplayMode:
//                       MonthAppointmentDisplayMode.appointment,
//                 ),
//               );
//             }
//           }),
//           loading: () => const CircularProgressIndicator(),
//           error: (err, stack) => Text('Error: $err'),
//         ));
//   }

//
// }

class Bottom extends ConsumerWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

Future<void> bottomSheet(BuildContext context, WidgetRef ref) {
  List<Text> intervals = [
    Text(
      "Day View",
      style: TextStyle(color: Colors.white),
    ),
    Text("Month View"),
    Text("Schedule View")
  ];
  final previousTimersProvider = ref.watch(PreviousTimersProvider);
  final state = ref.read(PreviousTimersProvider);

  return showModalBottomSheet<void>(
    context: context,
    builder: (
      BuildContext context,
    ) {
      return Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: darkBlue,
            ),
            width: 350,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
              child: Wrap(
                children: List<Widget>.generate(
                  3,
                  (int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                      child: ChoiceChip(
                        selectedColor: orangeYellow,
                        backgroundColor: lightBlue,
                        label: intervals[index],
                        labelStyle: TextStyle(color: Colors.white),
                        selected: previousTimersProvider.interval == index,
                        onSelected: (bool selected) {
                          previousTimersProvider
                              .chooseInterval(selected ? index : null);
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          Container(
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Close'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
