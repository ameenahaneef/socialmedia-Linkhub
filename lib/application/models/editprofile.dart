class Edit{
  int? statusCode;
  String? message;

  Edit({required this.statusCode,required this.message});

  factory Edit.fromJson(Map<String,dynamic>json){
    return Edit(statusCode: json['status_code'], message: json['message']);
  }

}