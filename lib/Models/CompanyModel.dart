class CompanyModel {

  int? companyID;
  String? companyName;
  String? location;


  CompanyModel({
    this.companyID,
    this.companyName,
    this.location,


  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(

      companyID: json['companyID'],
      location: json['location'],
      companyName: json['companyName'],
    );
  }
}
