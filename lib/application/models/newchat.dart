class Fetchchat {
  int statusCode;
  String message;
  AfterExecution afterExecution;

  Fetchchat({
    required this.statusCode,
    required this.message,
    required this.afterExecution,
  });
}

class AfterExecution {
  List<Chatsummary> actualData;

  AfterExecution({
    required this.actualData,
  });
}

class Chatsummary {
  String userId;
  String userName;
  String? userProfileUrl;
  String lastMessageContent;
  String lastMessageTimeStamp;

  Chatsummary({
    required this.userId,
    required this.userName,
    this.userProfileUrl,
    required this.lastMessageContent,
    required this.lastMessageTimeStamp,
  });
  factory Chatsummary.fromJson(Map<String, dynamic> json) {
    return Chatsummary(
        userId: json['UserID'],
        userName: json['UserName'],
        userProfileUrl: json['UserProfileURL'],
        lastMessageContent: json['LastMessageContent'],
        lastMessageTimeStamp: json['LastMessageTimeStamp']);
  }
}
