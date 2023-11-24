import 'package:covid/Services/world_states_api.dart';
import 'package:covid/View/detail_screen.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  hintText: "Search Countries",

                ),
              
              ),
              
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.fetchCountriesList(),
                 builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                  if(!snapshot.hasData){
                    return Text("Loading");

                  }
                  else{
                    return ListView.builder(
                    itemCount:snapshot.data!.length,
                    itemBuilder: (context,index){

                      String name = snapshot.data![index]['country'];
                      if(searchController.text.isEmpty){
                        return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                name: snapshot.data![index]['country'],
                                image: snapshot.data![index]['countryInfo']['flag'],
                                totalCases: snapshot.data![index]['cases'],
                                totalDeaths: snapshot.data![index]['recovered'],
                                active: snapshot.data![index]['active'],
                                test: snapshot.data![index]['tests'],
                                TodayRecovered: snapshot.data![index]['todayRecovered'],
                                critical: snapshot.data![index]['critical'],

                              )));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                
                                snapshot.data![index]['countryInfo']['flag']
                              )),
                            
                            ),
                          )
                        ],
                      );
                      }
                      else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                        return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                name: snapshot.data![index]['country'],
                                image: snapshot.data![index]['countryInfo']['flag'],
                                totalCases: snapshot.data![index]['cases'],
                                totalDeaths: snapshot.data![index]['recovered'],
                                active: snapshot.data![index]['active'],
                                test: snapshot.data![index]['tests'],
                                TodayRecovered: snapshot.data![index]['todayRecovered'],
                                critical: snapshot.data![index]['critical'],

                              )));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                
                                snapshot.data![index]['countryInfo']['flag']
                              )),
                            
                            ),
                          )
                        ],
                      );
                      }
                      else{
                        return Container();
                      }
                      
                    });

                  }

                  
                 })
            )
          ],
        ),
      ),

    );
  }
}