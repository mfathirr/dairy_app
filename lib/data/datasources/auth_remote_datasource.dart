import 'dart:convert';

import 'package:dairy_app/data/datasources/auth_local_datasource.dart';
import 'package:dairy_app/data/datasources/config.dart';
import 'package:dairy_app/data/model/request/register_request_model.dart';
import 'package:dairy_app/data/model/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel data) async {
    final response = await http.post(
        Uri.parse('${Config.baseUrl}/api/register'),
        body: data.toJson(),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 201) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final response = await http.post(Uri.parse('${Config.baseUrl}/api/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response =
        await http.post(Uri.parse('${Config.baseUrl}/api/logout'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.accessToken}'
    });

    if (response.statusCode == 200) {
      return const Right('Logout Success');
    } else {
      return Left(response.body);
    }
  }
}
