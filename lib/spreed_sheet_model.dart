class UserFields {
  static final String name = 'name';
  static final  String email = 'email';
  static final String mobileNo = 'mobileNo';
  static final String siteReport = 'siteReport';

  // FeedbackForm(this.name, this.email, this.mobileNo, this.siteReport);

  // factory FeedbackForm.fromJson(dynamic json) {
  //   return FeedbackForm("${json['name']}", "${json['email']}",
  //       "${json['mobileNo']}", "${json['siteReport']}");
  // }

  // // Method to make GET parameters.
  // Map toJson() => {
  //       'name': name,
  //       'email': email,
  //       'mobileNo': mobileNo,
  //       'siteReport': siteReport
  //     };
      static List<String> getFields() =>[name,email,mobileNo,siteReport];
}
class UserField{
  final String date;
  final String location;
  final String name;
  final String description;

  const UserField({
required this.date,required this.location,required this.name,required this.description
  });
  Map<String,dynamic> toJson() => {
UserFields.email:date,
UserFields.mobileNo:location,
UserFields.name:name,
UserFields.siteReport:description
  };
}