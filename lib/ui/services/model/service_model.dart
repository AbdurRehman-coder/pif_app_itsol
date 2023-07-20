class CategoryModel {
  CategoryModel({
    this.categoryName,
    this.categoryId,
    this.isSelected,
  });
  String? categoryName;
  int? categoryId;
  bool? isSelected;
}

class ServiceModel {
  ServiceModel({
    this.image,
    this.text,
    this.onTap,
  });
  String? image;
  String? text;
  void Function()? onTap;
}
