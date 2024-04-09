class PostModel {
  final int postId;
  final String caption;
  final String postAge;
  final List<String> mediaUrls;

  PostModel(
      {required this.postId,
      required this.caption,
      required this.postAge,
      required this.mediaUrls});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        postId: json['postid'],
        caption: json['caption'],
        postAge: json['post-age'],
        mediaUrls: List<String>.from(json['media-urls']));
  }
  Map<String, dynamic> toJson() {
    return {
      'postid': postId,
      'caption': caption,
      'post-age': postAge,
      'media-urls': mediaUrls
    };
  }
}
