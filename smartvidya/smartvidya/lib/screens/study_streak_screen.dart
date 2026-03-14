import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class StudyStreakScreen extends StatefulWidget {
  const StudyStreakScreen({super.key});

  @override
  State<StudyStreakScreen> createState() => _StudyStreakScreenState();
}

class _StudyStreakScreenState extends State<StudyStreakScreen> {

  Map<DateTime, int> heatMapData = {};

  DateTime clean(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final prefs = await SharedPreferences.getInstance();

    Map<DateTime,int> data = {};

    List<String> saved = prefs.getStringList("studyData") ?? [];

    /// LOAD EXISTING DATA
    for(var entry in saved){

      var parts = entry.split("|");

      DateTime date = DateTime.parse(parts[0]);

      int minutes = int.parse(parts[1]);

      data[clean(date)] = minutes;

    }

    /// ENSURE LAST 30 DAYS ARE FILLED
    DateTime today = clean(DateTime.now());

    for(int i = 0; i < 30; i++){

      DateTime day = today.subtract(Duration(days: i));

      if(!data.containsKey(day)){

        int minutes;

        if(i % 5 == 0){
          minutes = 120;
        }
        else if(i % 3 == 0){
          minutes = 60;
        }
        else{
          minutes = 25;
        }

        data[day] = minutes;

      }

    }

    await saveMap(data);

    setState(() {
      heatMapData = data;
    });

  }

  Future<void> saveMap(Map<DateTime,int> map) async {

    final prefs = await SharedPreferences.getInstance();

    List<String> list = [];

    map.forEach((date, minutes) {

      list.add("${date.toIso8601String()}|$minutes");

    });

    await prefs.setStringList("studyData", list);

  }

  void showDayDetails(DateTime date){

    int minutes = heatMapData[clean(date)] ?? 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),

      builder:(context){

        return Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              const Text(
                "Study Details",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height:20),

              Text(
                "Date: ${date.year}-${date.month}-${date.day}",
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height:10),

              Text(
                "Study Time: $minutes minutes",
                style: const TextStyle(color: Colors.green),
              ),

              const SizedBox(height:20),

            ],
          ),
        );

      },
    );

  }

  int totalActiveDays(){
    return heatMapData.length;
  }

  int maxStreak(){

    List<DateTime> days = heatMapData.keys.toList()..sort();

    int max = 0;
    int current = 1;

    for(int i=1;i<days.length;i++){

      if(days[i].difference(days[i-1]).inDays==1){
        current++;
      }else{
        if(current > max) max = current;
        current = 1;
      }

    }

    if(current > max) max = current;

    return max;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Study Contributions"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "${heatMapData.length} study sessions in the past year",
              style: const TextStyle(
                color: Colors.white,
                fontSize:18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height:10),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  "Total active days: ${totalActiveDays()}",
                  style: const TextStyle(color: Colors.white70),
                ),

                Text(
                  "Max streak: ${maxStreak()}",
                  style: const TextStyle(color: Colors.white70),
                ),

              ],
            ),

            const SizedBox(height:20),

            Expanded(

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: HeatMap(

                  startDate: DateTime.now().subtract(const Duration(days: 365)),
                  endDate: DateTime.now(),

                  datasets: heatMapData,

                  size:16,

                  defaultColor: Colors.grey.shade800,

                  textColor: Colors.white,

                  showColorTip: false,

                  colorMode: ColorMode.color,

                  colorsets: const {

                    10: Color(0xFFA5D6A7),
                    25: Color(0xFF81C784),
                    40: Color(0xFF66BB6A),
                    60: Color(0xFF43A047),
                    120: Color(0xFF1B5E20),

                  },

                  onClick:(date){
                    showDayDetails(date);
                  },

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}