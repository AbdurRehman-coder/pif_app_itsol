class CompanyDetailsModel {
  CompanyDetailsModel({
    this.companyService,
    this.id,
    this.selected,
  });
  String? companyService;
  int? id;
  bool? selected;
}

class CompanyDetailsUserModel {
  CompanyDetailsUserModel({
    this.userName,
    this.designation,
  });
  String? userName;
  String? designation;
}
