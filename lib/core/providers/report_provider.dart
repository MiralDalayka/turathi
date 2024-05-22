import 'package:flutter/cupertino.dart';
import '../data_layer.dart';

class ReportProvider extends ChangeNotifier {
  final ReportService _reportService = ReportService();

  Future<String> addReport(ReportModel model) async {
    String msg = (await _reportService.addReport(model).whenComplete(() {}));
    return msg;
  }
}