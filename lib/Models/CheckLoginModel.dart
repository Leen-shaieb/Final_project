class checkLoginModel {
  int? result;
  int? userTypeID;
  int? DegreeID;
  int? companyID;
  String? fullName;

  checkLoginModel({
    this.result,
    this.userTypeID,
    this.fullName,
    this.companyID,
    this.DegreeID,
  });

  factory checkLoginModel.fromJson(Map<String, dynamic> json) {
    return checkLoginModel(
      result: json['userID'],
      userTypeID: json['userTypeID'],
     companyID: json['companyID'],
      DegreeID: json['DegreeID'],
      fullName: json['fullName'], // Changed to match PHP response
    );
  }
}
