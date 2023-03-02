class userModel{
  String? Name;
  String? phoneNumber;
  String? address;

  userModel({this.Name, this.phoneNumber, this.address});


  userModel.fromJson(Map<String, dynamic> json) {
    Name = json['Name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.Name;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}