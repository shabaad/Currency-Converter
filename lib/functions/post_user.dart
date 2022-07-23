import 'dart:developer';

import 'package:currency_converter/models/user_model.dart';
import 'package:http/http.dart' as http;

Future<UserModel?> submitData(String name, String email, String result) async {
  var response = await http.post(Uri.https('dev.matsio.com', "interview"),
      body: {"name": name, "email": email, "result": result});
  var data = response.body;
  log(data);

  if (response.statusCode == 201) {
    String responseString = response.body;
    userModelFromJson(responseString);
  } else
    return null;
}
