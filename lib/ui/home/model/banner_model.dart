class BannerModel {
  BannerModel({
    this.title,
    this.image,
    this.videoUrl,
    this.bannerType,
  });
  String? title;
  String? image;
  String? videoUrl;
  BannerEnum? bannerType;
}

enum BannerEnum {
  image,
  text,
  video,
}
