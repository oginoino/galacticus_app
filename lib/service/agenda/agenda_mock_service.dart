import 'dart:convert';

import 'package:flutter/services.dart';

import 'agenda_service_interface.dart';

class AgendaMockService implements AgendaServiceInterface {
  static const _assetPath = 'assets/data/agendas_page.json';

  @override
  Future<Map<String, dynamic>> fetchAgenda() async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
