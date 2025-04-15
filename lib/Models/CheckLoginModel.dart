/*class checkLoginModel
{
  String? result;
  String? userTypeID;
  String? UserName;

  checkLoginModel({
    this.result,
    this.userTypeID,
    this.UserName,
  });
  factory checkLoginModel.fromJson(Map<String, dynamic> json) {
    return checkLoginModel(
      result: json['result'],
      userTypeID: json['userTypeID'],
      UserName: json['fullName'],
    );
  }
}*/
class checkLoginModel {
  int? result;
  int? userTypeID;
  String? fullName;

  checkLoginModel({
    this.result,
    this.userTypeID,
    this.fullName,
  });

  factory checkLoginModel.fromJson(Map<String, dynamic> json) {
    return checkLoginModel(
      result: json['userID'],
      userTypeID: json['userTypeID'],
      fullName: json['fullName'], // Changed to match PHP response
    );
  }
}
