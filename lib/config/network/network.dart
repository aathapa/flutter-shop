import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Network {
  static Future<Map<String, Object>> postApi({
    String url,
    Map<String, Object> body,
  }) async {
    try {
      http.Response response = await http.post(
        url,
        body: convert.jsonEncode(body),
      );

      var jsonResponse = convert.jsonDecode(response.body);

      return {"error": null, "response": jsonResponse};
    } catch (error) {
      print(error);
      return {"error": error, "response": null};
    }
  }

  static Future<Map<String, Object>> getApi(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return {
        "error": null,
        "response": jsonResponse,
        "statusCode": response.statusCode
      };
    }
    return {
      "error": true,
      "response": null,
      "statusCode": response.statusCode,
    };
  }

  static Future<Map<String, Object>> updateApi({
    String url,
    Map<String, Object> body,
  }) async {
    http.Response response = await http.patch(
      url,
      body: convert.jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return {
        "error": null,
        "response": jsonResponse,
        "statusCode": response.statusCode
      };
    }
    return {
      "error": true,
      "response": null,
      "statusCode": response.statusCode,
    };
  }

  static Future<bool> deleteApi(String url) async {
    http.Response response = await http.delete(url);
    return response.statusCode == 200;
  }
}
