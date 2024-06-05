import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_task_e_commerce/core/api_key.dart';
import 'package:machine_task_e_commerce/domain/model/model.dart';

class ApiServices {
  Future<ItemsList> fetchData() async {
    final response = await http.get(Uri.parse(apiKey));

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      ItemsList itemsList = ItemsList.fromJsonList(responseBody);
      return itemsList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
