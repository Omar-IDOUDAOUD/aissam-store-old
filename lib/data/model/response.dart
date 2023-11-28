// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aissam_store/data/respository/products_server.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

enum Status { success, serverError, connectionError }

class ResponsePayload<T> {
  final T? body;
  final int length;

  ResponsePayload({
    required this.body,
    this.length = 0,
  });

  factory ResponsePayload.fromMap(Map map, ResponseBodyConverter converter) {
    print('TEST 77: map: $map');
    return ResponsePayload<T>(
      body: converter(map['data']),
      length: map['length'] as int,
    );
  }

  @override
  String toString() =>
      'ResponsePayload(body: ${body.toString()}, length: $length)';
}

class ServerResponse<T> {
  final DioExceptionType? connectionError;
  final Status status;
  final String message;
  final int? statusCode;
  final String? statusMessage;
  final ResponsePayload<T>? payload;

  ServerResponse({
    required this.status,
    required this.message,
    this.connectionError,
    this.statusCode,
    this.statusMessage,
    this.payload,
  });

  /// In case that the response was received regardless the status code
  factory ServerResponse.success(
      Response response, ResponseBodyConverter converter) {
    Status getStatus() {
      final approvedStatusCodes = [200, 204];
      return approvedStatusCodes.contains(response.statusCode!)
          ? Status.success
          : Status.serverError;
    }

    String getMessage() {
      return response.statusCode != 204
          ? response.data['message']
          : response.statusMessage;
    }

    ResponsePayload<T> getPayload() {
      return response.statusCode != 204
          ? ResponsePayload.fromMap(response.data, converter)
          : ResponsePayload(body: converter(null));
    }

    return ServerResponse(
      status: getStatus(),
      message: getMessage(),
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      payload: getPayload(),
    );
  }

  /// In case that the response was not received for network or connection reasons
  factory ServerResponse.fail(DioException exception) {
    return ServerResponse(
      status: Status.connectionError,
      message: exception.message!,
      connectionError: exception.type,
    );
  }

  @override
  String toString() {
    return 'ServerResponse(connectionError: $connectionError, status: $status, message: $message, statusCode: $statusCode, statusMessage: $statusMessage, payload: ${payload.toString()})';
  }
}
