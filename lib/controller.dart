
import 'dart:convert' as convert;
import 'package:gsheets/gsheets.dart';
import 'package:http/http.dart' as http;
import 'package:site_reporter/spreed_sheet_model.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
// class FormController {
  
//   // Google App Script Web URL.
//   static const String URL = "https://script.google.com/macros/s/AKfycbxnrJiw4FBN4ZJP_V1W_b2T-EzZDhF0qBiDhaP989aM229O48NiGouddKWo1RiMeLyT/exec";
  
//   // Success Status Message
//   static const STATUS_SUCCESS = "SUCCESS";

//   /// Async function which saves feedback, parses [feedbackForm] parameters
//   /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
//    void submitForm(
//       FeedbackForm feedbackForm, void Function(String) callback) async {
//     try {
//       await http.post(Uri.parse(URL)   , body: feedbackForm.toJson()).then((response) async {
//         if (response.statusCode == 302) {
//           var url = response.headers['location'];
//           await http.get( Uri.parse(url ?? '')).then((response) {
//             callback(convert.jsonDecode(response.body)['status']);
//           });
//         } else {
//           callback(convert.jsonDecode(response.body)['status']);
//         }
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
// }
class UserSheetApi{
  static final _spreadSheetId ='14r91vSBfRiEyvB65V25xhWr6fhZai0xmYTJrIeLaCSk';
  static const _credentials =r'''
{
  "type": "service_account",
  "project_id": "sigma-tractor-410515",
  "private_key_id": "989c693fec48d0391ea18e7181953afe62870281",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDM4i1gZO+hw/1w\nh/qxmbdsladmYpv734WYlsQE/TRCq0WXHhjsuup43gdqDyd3Fk0G0Ba3Iepra+Kz\nt/GAD3vt/FD/dba5alyNpnISBqawLuhyNS1T+p0RgPXPHGldpwXtANOSt5WmQWVt\n7J4bZLoxnYHBS9Xsyh+NvRs9W0uEkKYOtdMIy732DbZBDc7x93IAvjMkiG3ODdxG\nrOaQoQlwt6sznuYNcFj4F8YVIw2MQAKclDTjK2RS8eTtd/1OAsmv0b48fHW430II\nljnk4ZayNn5udFy2VLzab45+LV4EpVk29GAzX6GJsulO2uNIC3CLEM4rPS0Z/HcQ\n1GUKYWB9AgMBAAECggEABWyLdPzXFzpAEGWZLnB6WaaQmvZLWNyvBb4gDF3Dr2wn\nWHvUfxfnszF1kso56j4t5dtGbqy4LwXZJ5bcDt7aEg/W+RxdrQTy1FEuveltKkbj\nonpj69A7rkXyu/vtkiwkzQRzlXPEw3UBwWo9OU5uW3fnAn4GeNFVCoSSHwq2shiy\nCVmwoIVGK8E5S6hQOCmUGnXd4s4J4oa2bTTBBIT6fozv14kcso5QDHmWdAQ5qn4v\nugdnjvsVnQMQKANsfw7cATxj8lDu3MlhZS+3oC8DBKdT6OqXLPMgUU3Q7cP2A0f7\n+Bgar5j8MRhbjU/I9KtIDRbVsIDOLh8ekx9ZosVWgQKBgQD/3ULKdRxxHWesSYeN\nAL19oPJMIItN758SagRtxXa4F4G3KjF1ZhGWDHneR1Ff5sf7yNtUQQhFimo3bkvo\nLD4/zFVqLxcwMhgj++1qT+dpyuejnH+n7wncEJ8iut5gJMeopK+mFJZMRbQQayVJ\nXy5EW5M66rp86tao3O6j5JC5XQKBgQDM/f6emsgiWPWPqkQGjouCwS8nGdZdUGau\nImw8/s77ZWTQ/2aeS71mSkAS8nWBkgOTtLecQrmItda9a8HrKA9WYSPrL/CuLlv4\nC5wmNWsFjpREk+kvBKECEj3eeKoQIo8n7ZdjQc3wLoUFyyqRujP5OdX9lgRIwxi3\n4w0J30oxoQKBgDAOSZ4m8smYAUHNqaTlD7IJyZhcwG1J5TGbMevAG7UlzRou1Y08\nN29cNoN2F6WQfd0fc3pWoIwXHC3/DEi2DpcC9MP1xkAqGHiht4yxJ0CqeGk1WpCb\nB9oKUSk/ucaLAej9zXO/CB+ZM+GljiJCuzjhjjyRm6ccoGak4DluE3SNAoGAW3Zk\nee3DqBebEQu+KFLHioKZgE+15pKuDboMIzbpsR9vWRTre2t9yTsN1aZaqYI1mFzE\no7Ldx1Kiyode0YZhOYBEH3aXY5AJtuWvORkSdDtGikaYf0MId70d37pk3qgcyYrn\nxgChWy3WalxY1QaIlAWrJeceaDysNbfXpHT9TKECgYEAt+istFKOm0Wf0b6AKRxx\nkZUXIouaFPlnJm6mr9Dzay9jmMOPuvbQDKJt6RaqhXJErdSb40iZI5IlwuRajF0W\nbmHS2x/a2SfhGu2lBRAOAZhsP8odMDNkrWkBf2aXTMUR4TfkAKg//zbERnCIZTnX\nGYPiL6PIN4f6z6qVKmdC3z0=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheet@sigma-tractor-410515.iam.gserviceaccount.com",
  "client_id": "105108870193328919094",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet%40sigma-tractor-410515.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

  ''';
  static final _gSheets = GSheets(_credentials);
static Worksheet? _userWorkSheet;
static Future init() async {
   final spreadSheet = await _gSheets.spreadsheet(_spreadSheetId);
   _userWorkSheet = await _getWorkSheet(spreadSheet,title:'Report');
  final firstRow = UserFields.getFields();
  try{
       _userWorkSheet?.values.insertRow(1,firstRow);
  }catch(e){
    print(e);
  }
}
static Future<Worksheet> _getWorkSheet(
  Spreadsheet spreadsheet,
{required String title}
)async{
  try{
      return await spreadsheet.addWorksheet(title);

  }catch(e){
      return  spreadsheet.worksheetByTitle(title)!;

  }
}
static Future insert(List<Map<String,dynamic>> rowList)async{
if (_userWorkSheet == null)
return; 
  _userWorkSheet!.values.map.appendRows(rowList);
}
}