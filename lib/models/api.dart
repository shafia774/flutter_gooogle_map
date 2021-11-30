import 'package:http/http.dart' as http;
import 'package:map4/models/list.dart';
import 'dart:convert';

class Api {



  static Future<List<Listmodel>> fetchList() async {
    var url = Uri.parse('https://foodmapglobal.com/nearby');
    final response = await http.get(url);
    final responseBody = json.decode(response.body);
    return listsFromJson(responseBody['data']);
  }
}



