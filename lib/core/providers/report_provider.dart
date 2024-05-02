import 'package:flutter/cupertino.dart';
import 'package:turathi/core/models/report_model.dart';
import 'package:turathi/core/services/report_service.dart';

class ReportProvider extends ChangeNotifier {
  final ReportService _reportService = ReportService();

  Future<String> addReport(ReportModel model) async {
    String msg = (await _reportService.addReport(model).whenComplete(() {}));
    return msg;
  }
}