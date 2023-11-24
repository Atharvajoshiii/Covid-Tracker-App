import 'package:covid/Services/world_states_api.dart';
import 'package:covid/View/contries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>{
    Color(0xff44285f4),
    Color.fromARGB(0, 7, 150, 57),
    Color(0xffde5246)
  };
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            FutureBuilder(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "total": double.parse(snapshot.data!.cases!.toString()), 
                            "recovered": double.parse(snapshot.data!.recovered!.toString()),
                             "deaths": double.parse(snapshot.data!.deaths!.toString())},
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                          color: Colors.redAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                ResusableRow(title: 'total', value: snapshot.data!.cases!.toString()),
                                ResusableRow(title: 'todays cases', value: snapshot.data!.todayCases!.toString()),
                                ResusableRow(title: 'deaths', value: snapshot.data!.deaths!.toString()),
                                ResusableRow(title: 'recovered', value: snapshot.data!.recovered!.toString()),
                                ResusableRow(title: 'todays deaths', value: snapshot.data!.todayDeaths!.toString()),
                                ResusableRow(title: 'todays recovered', value: snapshot.data!.todayRecovered!.toString()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=> CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(" Track Countries "),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    ));
  }
}

class ResusableRow extends StatelessWidget {
  String title, value;
  ResusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
