import 'dart:convert';

import 'package:dixels_sdk/features/commerce/visit/models/visitor_model.dart';

class VisitsModel {
  VisitsModel({
    this.id,
    this.startDateTimeVisit,
    this.endDateTimeVisit,
    this.visitModel,
  });

  final int? id;
  final DateTime? startDateTimeVisit;
  final DateTime? endDateTimeVisit;
  final List<VisitorModel>? visitModel;
}