import 'dart:convert';
import 'package:crud_bloc_api/model/spice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class BaseURL {
  static String url = "https://1665-103-99-27-42.ngrok-free.app";
}

class RestAPIService {
  Future<bool> addSpiceService(String nama_rempah, String nama_latin,
      String image, String deskripsi) async {
    try {
      http.Response response = await http.post(
        Uri.parse("${BaseURL.url}/rempah"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "nama_rempah": nama_rempah,
          "nama_latin": nama_latin,
          "image": image,
          "deskripsi": deskripsi
        }),
      );
      debugPrint("Response body: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  UserSpice _spiceModel = UserSpice();

  Future<UserSpice> readSpiceService() async {
    try {
      http.Response response = await http.get(
        Uri.parse("${BaseURL.url}/rempah"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        _spiceModel = await compute(_pareJson, response.body);
      }
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
    return _spiceModel;
  }

  Future<bool> updateSpiceService(String id, String nama_rempah,
      String nama_latin, String image, String deskripsi) async {
    try {
      http.Response response = await http.put(
        Uri.parse("${BaseURL.url}/rempah/$id"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "nama_rempah": nama_rempah,
          "nama_latin": nama_latin,
          "image": image,
          "deskripsi": deskripsi
        }),
      );
      debugPrint("Response body: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> deleteSpiceService(String id) async {
    try {
      http.Response response = await http.delete(
        headers: {
          "Content-Type": "application/json",
        },
        Uri.parse("${BaseURL.url}/rempah/$id"),
      );
      debugPrint("Response body: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}

UserSpice _pareJson(String json) => UserSpice.fromJson(jsonDecode(json));
