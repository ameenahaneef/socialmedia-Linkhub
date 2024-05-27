class CommentModel {
  int statusCode;
  String message;
  AfterExecution afterExecution;

  CommentModel({
    required this.statusCode,
    required this.message,
    required this.afterExecution,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      statusCode: json['status_code'],
      message: json['message'],
      afterExecution: AfterExecution.fromJson(json['after execution']),
    );
  }
}

class AfterExecution {
  int parentCommentsCount;
  List<ParentComment> parentComments;

  AfterExecution({
    required this.parentCommentsCount,
    required this.parentComments,
  });

  factory AfterExecution.fromJson(Map<String, dynamic> json) {
    List<dynamic> commentsList = json['ParentComments'];
    List<ParentComment> parsedComments = commentsList.map((comment) => ParentComment.fromJson(comment)).toList();

    return AfterExecution(
      parentCommentsCount: json['ParentCommentsCount'],
      parentComments: parsedComments,
    );
  }
}

class ParentComment {
  int commentId;
  int postId;
  int userId;
  String userName;
  String?UserProfileimageUrl;
  String commentText;
  String commentAge;

  ParentComment({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.userName,
    this.UserProfileimageUrl,
    required this.commentText,
    required this.commentAge,
  });

  factory ParentComment.fromJson(Map<String, dynamic> json) {
    return ParentComment(
      commentId: json['CommentId'],
      postId: json['PostId'],
      userId: json['UserId'],
      UserProfileimageUrl: json['UserProfileImgURL'],
      userName: json['UserName'],
      commentText: json['CommentText'],
      commentAge: json['CommentAge'],
    );
  }
}
