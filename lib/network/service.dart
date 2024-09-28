import 'dart:convert';

import 'package:http/http.dart' as http;

class ServiceWithHeader {
  final String loginURL;

  ServiceWithHeader(
    this.loginURL,
  );

  Future data() async {
    final response = await http.get(Uri.parse(loginURL));

    var status = jsonDecode(response.body);

    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      return jsonDecode(data);
    } else {
      String data = response.body;
      return jsonDecode(data);
    }
  }
}
