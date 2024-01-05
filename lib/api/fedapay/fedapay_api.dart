import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FedapayClient extends GetConnect{
  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      return request;
    });

    void createTransaction(){

    }

    void createTransfert(){

    }
  }
}