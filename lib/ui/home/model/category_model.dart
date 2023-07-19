class CategoryModel {
  CategoryModel({
    this.image,
    this.text,
    this.onTap,
  });

  String? image;
  String? text;
  void Function()? onTap;
}
