import 'package:flutter/material.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../profile_screen/models/profileget.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

class WalletScreen extends StatefulWidget {
  otp.Data data;
  WalletScreen(this.data);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  Future<ProfileGet>? myProfile;
  String? wallet_balance;

  Future<ProfileGet> getProfileData() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Auth/myprofile",
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "*/*",
              },
            ),
            data: body);
    var jsonObject = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      print(jsonObject);

      if (ProfileGet.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return ProfileGet.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (ProfileGet.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(ProfileGet.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (ProfileGet.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            jsonObject['message'] + ' Please check after sometime.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        throw Exception('Failed to load');
      }
    } else {
      throw Exception('Failed to load');
    }
    return jsonObject;
  }

  @override
  void initState() {
    myProfile = getProfileData();
    myProfile!.then((value) {
      setState(() {
        wallet_balance = value.data!.walletBalence!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        appBar: CustomAppBar(
            height: getVerticalSize(70),
            leadingWidth: 41,
            leading: AppbarImage(
                onTap: () {
                  Navigator.pop(context);
                },
                height: getVerticalSize(15),
                width: getHorizontalSize(9),
                svgPath: ImageConstant.imgArrowleft,
                margin: getMargin(left: 20, top: 30, bottom: 25)),
            title: AppbarTitle(
                text: "WALLET",
                margin: getMargin(left: 19, top: 49, bottom: 42)),
            // AppbarImage(
            //     height: getVerticalSize(32),
            //     width: getHorizontalSize(106),
            //     imagePath: ImageConstant.imgFinallogo03,
            //     margin: getMargin(left: 13, top: 44, bottom: 15)),
            styleType: Style.bgOutlineGray40003),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: _buildGradientBalanceCard(),
        )
        // Padding(
        //   padding: EdgeInsets.all(16.0),
        //   child: Container(
        //     height: 25.h,
        //     decoration:  BoxDecoration(
        //         color: Colors.greenAccent,
        //         border: Border.all(
        //           color: Colors.purple,  // Set the desired border color here
        //           width: 1.0,  // Set the desired border width here
        //         ),
        //         borderRadius:
        //         BorderRadius.all(Radius.circular(12))),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SizedBox(height: 10,),
        //         Text(
        //           '    Available Balance',
        //           style: TextStyle(
        //             fontSize: 24,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         SizedBox(height: 16.0),
        //         Row(
        //           children: [
        //             CircleAvatar(
        //               radius: 36,
        //               backgroundColor: Colors.green,
        //               child: Icon(
        //                 Icons.attach_money,
        //                 size: 40,
        //                 color: Colors.white,
        //               ),
        //             ),
        //             SizedBox(width: 16.0),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   '₹500',
        //                   style: TextStyle(
        //                     fontSize: 32,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //                 SizedBox(height: 4.0),
        //                 Text(
        //                   'Expires in 30 days',
        //                   style: TextStyle(fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //         // SizedBox(height: 32.0),
        //         // Text(
        //         //   'Transactions',
        //         //   style: TextStyle(
        //         //     fontSize: 20,
        //         //     fontWeight: FontWeight.bold,
        //         //   ),
        //         // ),
        //         // SizedBox(height: 16.0),
        //         // _buildTransactionCard(
        //         //   '₹100',
        //         //   'Food order',
        //         //   '12 June 2023',
        //         // ),
        //         // _buildTransactionCard(
        //         //   '₹50',
        //         //   'Delivery fee refund',
        //         //   '10 June 2023',
        //         // ),
        //         // _buildTransactionCard(
        //         //   '₹200',
        //         //   'Cashback from offer',
        //         //   '8 June 2023',
        //         // ),
        //         // Add more transaction cards as needed
        //       ],
        //     ),
        //   ),
        // ),
        );
  }

  Container _buildGradientBalanceCard() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purpleAccent.withOpacity(0.9),
            Color(0xff466aff),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rs " + wallet_balance! ?? '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Total Balance",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Widget _buildTransactionCard(String amount, String description, String date) {
  //   return Card(
  //     elevation: 2.0,
  //     child: ListTile(
  //       leading: CircleAvatar(
  //         backgroundColor: Colors.green,
  //         child: Icon(
  //           Icons.attach_money,
  //           color: Colors.white,
  //         ),
  //       ),
  //       title: Text(
  //         amount,
  //         style: TextStyle(
  //           fontSize: 24,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       subtitle: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(description),
  //           Text(
  //             date,
  //             style: TextStyle(fontSize: 12),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
