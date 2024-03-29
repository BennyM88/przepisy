import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:przepisy/config/environment.dart';

abstract class ConfigReader {
  static late Map<String, dynamic> _config;

  static Future<void> initialize(String env) async {
    String configString;

    switch (env) {
      case Environment.prod:
        configString = await rootBundle.loadString('config/prod.json');
        break;
      case Environment.dev:
      default:
        configString = await rootBundle.loadString('config/dev.json');
        break;
    }

    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getApiURL() => _config['apiURL'] as String;
}
