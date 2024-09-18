import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseRepository<T> {
  Future<SharedPreferences> get sharedPreferencies async =>
      await SharedPreferences.getInstance();

  final Dio dio = Dio();

  BaseRepository() {
    dio
      ..options.baseUrl = "https://api.coincap.io"
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30);
  }

  @mustBeOverridden
  String get nameSpace => "";
  @mustBeOverridden
  String get queryName => "";
  @mustBeOverridden
  Function(Map<String, dynamic> json) get fromJson => (json) => json;

  Future<Iterable<T>> fetchIterable({
    String? method,
    Map<String, dynamic>? queryParameters,
  }) async {
    final query = "$nameSpace$queryName${method ?? ""}";
    try {
      final response = await dio.get(
        query,
        queryParameters: queryParameters,
      );
      final data = response.data["data"] as Iterable;
      return data.map((v) => fromJson(v));
    } catch (error) {
      debugPrint(query);
      debugPrint(error.toString());
      return Future.error(error);
    }
  }
}
