import 'dart:convert';

import 'package:covid/Models/world_states_model.dart';
import 'package:covid/Services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{

  Future<WorldStatesModel> fetchWorldStatesRecord () async{

    final response = await http.get(Uri.parse(AppUrl.worldstatesapi));
    
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('error');

    }



  }

  Future<List<dynamic>> fetchCountriesList () async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
      return data; 
    }else{
      throw Exception('error');

    }



  }





}