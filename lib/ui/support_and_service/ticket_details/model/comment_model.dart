class CommentModel {
  CommentModel({
    required this.type,
    required this.viewType,
    this.desc,
    this.time,
    this.imageUrl,
    this.videoUrl,
    this.profilePic,
  });

  String? profilePic;
  String? desc;
  CommentTypeEnum? type;
  String? time;
  String? imageUrl;
  String? videoUrl;
  CommentViewEnum? viewType;
}

enum CommentTypeEnum { text, image, video }

enum CommentViewEnum { sender, receiver, join }
