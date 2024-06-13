import 'dart:convert';

import 'package:dairy_app/data/datasources/config.dart';
import 'package:dairy_app/data/model/request/register_request_model.dart';
import 'package:dairy_app/data/model/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel data) async {
    final response = await http.post(Uri.parse('${Config.baseUrl}/register'),
        body: data.toJson(),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 201) {
      return Right(AuthResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final response =
        await http.post(Uri.parse('${Config.baseUrl}/login'), body: {
      'email': email,
      'password': password,
    }, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
