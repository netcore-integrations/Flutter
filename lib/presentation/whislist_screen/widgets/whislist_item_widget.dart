import 'package:keshav_s_application2/presentation/product_detail_screen/models/AddWishlist.dart';
import 'package:keshav_s_application2/presentation/product_detail_screen/models/AddtoCart.dart';
import 'package:keshav_s_application2/presentation/product_detail_screen/models/addtocartfromwishlist.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/models/removewishlist.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/models/wishlist_model.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/models/wishlist_model.dart'
    as wishlist;
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';

import '../../otp_screen/models/otp_model.dart';
import '../controller/whislist_controller.dart';
import '../models/whislist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;

// ignore: must_be_immutable
class WhislistItemWidget extends StatefulWidget {
  WhislistItemWidget(this.data, this.productdata);

  // WhislistItemModel whislistItemModelObj;
  Data data;
  ProductData productdata;

  @override
  State<WhislistItemWidget> createState() => _WhislistItemWidgetState();
}

class _WhislistItemWidgetState extends State<WhislistItemWidget> {
  String? message;

  Future<AddtoCartfromwishlist> addtocart() async {
    Map data = {
      'user_id': widget.data.id,
      'product_id': widget.productdata.id,
      'qty': "1",
      "add_wishlist_cart": "1",
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/addtoCart",
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

      if (AddtoCartfromwishlist.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(
              "Added to Cart " +
                  AddtoCartfromwishlist.fromJson(jsonObject).message! +
                  "ly",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent));

        return AddtoCartfromwishlist.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (AddtoCartfromwishlist.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(AddtoCartfromwishlist.fromJson(jsonObject)
                .message!
                .capitalizeFirst!),
            backgroundColor: Colors.redAccent));
      } else if (AddtoCartfromwishlist.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 10.0),
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

  Future<RemoveWishlist> removefromwishlist() async {
    Map data = {
      'user_id': widget.data.id,
      'product_id': widget.productdata.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/addWishlist",
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

      if (RemoveWishlist.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
        if (RemoveWishlist.fromJson(jsonObject).data == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 10.0),
              content: Text(
                "Removed from Wishlist ",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.greenAccent));
        }
        return RemoveWishlist.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (RemoveWishlist.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(
                RemoveWishlist.fromJson(jsonObject).message!.capitalizeFirst!),
            backgroundColor: Colors.redAccent));
      } else if (RemoveWishlist.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 10.0),
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

  Future<wishlist.WishlistScreenModel> getWishlist() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/wishlist",
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

      if (wishlist.WishlistScreenModel.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return wishlist.WishlistScreenModel.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (wishlist.WishlistScreenModel.fromJson(jsonObject).status ==
          "false") {
        message = wishlist.WishlistScreenModel.fromJson(jsonObject).message;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                wishlist.WishlistScreenModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (wishlist.WishlistScreenModel.fromJson(jsonObject).data ==
          null) {
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

  // var controller = Get.find<WhislistController>();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.maxFinite,
        child: Container(
          padding: getPadding(
            left: 8,
            top: 6,
            right: 8,
            bottom: 6,
          ),
          decoration: AppDecoration.outlinePurple9004c,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: getPadding(
                  top: 1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomImageView(
                      url: widget.productdata.image!,
                      // imagePath: ImageConstant.imgImage5,
                      height: getSize(
                        65,
                      ),
                      width: getSize(
                        65,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: getHorizontalSize(
                                  220,
                                ),
                                child: Text(
                                  widget.productdata.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRobotoRegular14Purple400,
                                ),
                              ),
                              CustomImageView(
                                onTap: () {
                                  removefromwishlist();
                                  getWishlist();
                                  // WhislistScreen(widget.data);
                                },
                                svgPath: ImageConstant.imgFavorite,
                                height: getVerticalSize(
                                  12,
                                ),
                                width: getHorizontalSize(
                                  14,
                                ),
                                margin: getMargin(
                                  left: 66,
                                  top: 1,
                                  bottom: 11,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: getPadding(
                              left: 2,
                              top: 3,
                            ),
                            child: Row(
                              children: [
                                CustomImageView(
                                  svgPath: ImageConstant.imgVectorPurple900,
                                  height: getVerticalSize(
                                    8,
                                  ),
                                  width: getHorizontalSize(
                                    5,
                                  ),
                                  margin: getMargin(
                                    bottom: 3,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    left: 2,
                                  ),
                                  child: Text(
                                    widget.productdata.salePrice!,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtRobotoMedium10,
                                  ),
                                ),
                                CustomImageView(
                                  svgPath: ImageConstant.imgVectorGray400,
                                  height: getVerticalSize(
                                    7,
                                  ),
                                  width: getHorizontalSize(
                                    4,
                                  ),
                                  margin: getMargin(
                                    left: 5,
                                    top: 1,
                                    bottom: 3,
                                  ),
                                ),
                                Container(
                                  height: getVerticalSize(
                                    10,
                                  ),
                                  width: getHorizontalSize(
                                    25,
                                  ),
                                  margin: getMargin(
                                    left: 2,
                                    top: 1,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          widget.productdata.mrpPrice!,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                              AppStyle.txtRobotoMedium8Gray400,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: getPadding(
                                            top: 4,
                                          ),
                                          child: SizedBox(
                                            width: getHorizontalSize(
                                              23,
                                            ),
                                            child: Divider(
                                              height: getVerticalSize(
                                                1,
                                              ),
                                              thickness: getVerticalSize(
                                                1,
                                              ),
                                              color: ColorConstant.gray40001,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              left: 1,
                              top: 2,
                            ),
                            child: Text(
                              widget.productdata.discountPer! + " % Off",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium8Purple900,
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              left: 1,
                              top: 2,
                            ),
                            child: Text(
                              "msg_limited_time_offer".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoRegular8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 15,
                ),
                child: Divider(
                  height: getVerticalSize(
                    1,
                  ),
                  thickness: getVerticalSize(
                    1,
                  ),
                ),
              ),
              Container(
                // color: Colors.black,
                width: 350,
                height: 30,
                child: GestureDetector(
                  onTap: () {
                    addtocart();
                    setState(() {});
                  },
                  child: Container(
                    padding: getPadding(
                      top: 15,
                    ),
                    child: Text(
                      "lbl_add_to_cart".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppStyle.txtRobotoMedium10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
