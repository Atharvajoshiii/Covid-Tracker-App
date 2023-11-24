import 'package:covid/View/contries_list.dart';
import 'package:covid/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String image;
  String name;
  int totalCases,totalDeaths,active,critical,TodayRecovered,test;
  


  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.active,
    required this.critical,
    required this.TodayRecovered,
    required this.test,
  });
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 40,),
                                  ResusableRow(title: 'total', value: widget.totalCases.toString()),
                                  ResusableRow(title: 'active', value: widget.active.toString()),
                                  ResusableRow(title: 'deaths', value: widget.totalDeaths.toString(),),
                                  ResusableRow(title: 'Today recovered', value: widget.TodayRecovered.toString()),
                                  ResusableRow(title: 'critical', value: widget.critical.toString()),
                                  ResusableRow(title: 'test', value: widget.test.toString()),
                                ],
                              ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )

            ],
          )
        ],
      )
      ,
    );
  }
}

