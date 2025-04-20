class checkLoginModel {
  int? result;
  int? userTypeID;
  int? companyID;
  String? fullName;

  checkLoginModel({
    this.result,
    this.userTypeID,
    this.fullName,
    this.companyID,
  });

  factory checkLoginModel.fromJson(Map<String, dynamic> json) {
    return checkLoginModel(
      result: json['userID'],
      userTypeID: json['userTypeID'],
     companyID: json['companyID'],
      fullName: json['fullName'], // Changed to match PHP response
    );
  }
}
