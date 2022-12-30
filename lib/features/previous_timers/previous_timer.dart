import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:tracker/constants/colors.dart';
import 'package:tracker/features/home/home.dart';
import 'package:tracker/features/tracker/models/timer.dart';

class PreviousTimersScreen extends ConsumerWidget {
  const PreviousTimersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = Timer(
      status: true,
      // start: Timestamp.fromDate(DateTime.)
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracks"),
        backgroundColor: darkBlue,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Container(
        // width: double.infinity,
        // // decoration: BoxDecoration(
        // //     gradient: LinearGradient(
        // //   begin: Alignment.topRight,
        // //   end: Alignment.bottomLeft,
        // //   colors: [
        // //     Colors.blue,
        // //     Colors.red,
        // //   ],
        // // )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingSection(
              title: "today's previous tracks",
              subtitle: '',
            ),
            Flexible(
              child: ListView(
                children: [TimerRow()],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimerRow extends StatelessWidget {
  const TimerRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("45:45"),
        SizedBox(),
        Text("status true"),
      ],
    );
  }
}
