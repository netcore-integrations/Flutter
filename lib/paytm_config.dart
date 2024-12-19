// import 'dart:convert';
//
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
//
// import 'presentation/payment_method_screen/models/TxnToken.dart';
// import 'package:dio/dio.dart' as dio;
//
// class PaytmConfig {
//   final String _mid = "ROEeGY18492188732784";
//   final String _mKey = "w0mRkw02QhJIF18Q";
//   final String _website = "DEFAULT";
//   final String _url =
//       'https://fabfurni.com/api/Webservice/get_Paytm_Tranjection_Token';
//
//   String get mid => _mid;
//   String get mKey => _mKey;
//   String get website => _website;
//   String get url => _url;
//
//   String getMap(String amount, String callbackUrl, String orderId,String userid) {
//     return json.encode({
//       "MID": mid,
//       // "key_secret": mKey,
//       "CHANNEL_ID":"WEB",
//       "WEBSITE": website,
//       "ORDER_ID": orderId,
//       "TXN_AMOUNT": amount,
//       "CALLBACK_URL": callbackUrl,
//       "CUST_ID": userid,
//     });
//   }
//
//   Future<void> generateTxnToken(String amount, String orderId,String userid) async {
//     final callBackUrl =
//         'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';
//     final body = json.encode({
//       "MID": "ROEeGY18492188732784",
//       "key_secret": "w0mRkw02QhJIF18Q",
//       "CHANNEL_ID":"WEB",
//       "WEBSITE": "DEFAULT",
//       "ORDER_ID": orderId,
//       "TXN_AMOUNT": amount,
//       "CALLBACK_URL": callBackUrl,
//       "CUST_ID": userid,
//     });
//
//     try {
//       var response =
//       await dio.Dio().post("https://fabfurni.com/api/Webservice/get_Paytm_Tranjection_Token",
//           options: dio.Options(
//             headers: {
//               "Content-Type": "application/json",
//               "Accept": "*/*",
//             },
//           ),
//           data: body);
//       // final response = await http.post(
//       //   Uri.parse(url),
//       //   body: body,
//       //   headers: {'Content-type': "application/json"},
//       // );
//       var jsonObject = jsonDecode(response.toString());
//       print(jsonObject["txnToken"]);
//       // if(response.statusCode==200){
//       //   return TxnToken.fromJson(jsonObject);
//       // }
//       String txnToken = jsonObject["txnToken"];
//       print("txntoken:"+txnToken);
//
//       await initiateTransaction(orderId, amount, txnToken, callBackUrl,userid);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> initiateTransaction(String orderId, String amount,
//       String txnToken, String callBackUrl,String userid) async {
//     String result = '';
//     try {
//       var response = AllInOneSdk.startTransaction(
//         mid,
//         orderId,
//         amount.toString(),
//         txnToken,
//         callBackUrl,
//         false,
//         false,
//       );
//       response.then((value) {
//         // Transaction successfull
//         print(value);
//       }).catchError((onError) {
//         if (onError is PlatformException) {
//           result = onError.message + " \n  " + onError.details.toString();
//           print(result);
//         } else {
//           result = onError.toString();
//           print(result);
//         }
//       });
//     } catch (err) {
//       // Transaction failed
//       result = err.toString();
//       print(result);
//     }
//   }
// }
