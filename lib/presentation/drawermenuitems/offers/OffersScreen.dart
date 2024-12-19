import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;
import 'package:sizer/sizer.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../../core/utils/size_utils.dart';
import '../../../widgets/app_bar/appbar_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import 'Model/OffersModel.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

class OffersScreen extends StatefulWidget {
  otp.Data data;

  OffersScreen(this.data);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  Future<OffersModel>? offers;
  List<OffersData> offerslist = [];

  Future<OffersModel> getOffersList() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().get("https://fabfurni.com/api/Webservice/offerList",
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
      if (OffersModel.fromJson(jsonObject).status == "true") {
        return OffersModel.fromJson(jsonObject);
        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (OffersModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(OffersModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (OffersModel.fromJson(jsonObject).data == null) {
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
    offers = getOffersList();
    offers!.then((value) {
      setState(() {
        offerslist = value.data!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                text: "OFFERS",
                margin: getMargin(left: 19, top: 49, bottom: 42)),
            styleType: Style.bgShadowBlack90033),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<OffersModel>(
                  future: offers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Wrap(
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "No Offers Available",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                            // Utils.noDataTextWidget()
                            );
                      } else {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: offerslist.length,
                          itemBuilder: (context, index) {
                            var data = offerslist[index];
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(data.image!),
                                          fit: BoxFit.cover),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors
                                            .purple, // Set the desired border color here
                                        width:
                                            1.0, // Set the desired border width here
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // ClipRRect(
                                      //   borderRadius: const BorderRadius.all(
                                      //       Radius.circular(16)),
                                      //   child: Container(
                                      //     height: 16.h,
                                      //     width: 90.w,
                                      //     child: Image.network(
                                      //       data.image,
                                      //         fit: BoxFit.cover,
                                      //         width: 100.w,
                                      //         // alignment: Alignment(1.2, 1.2),
                                      //         filterQuality: FilterQuality.high,
                                      //         loadingBuilder:
                                      //             (context, child, loadingProgress) =>
                                      //         (loadingProgress == null)
                                      //             ? child
                                      //             : CircularProgressIndicator(
                                      //           color: Color(0xff9BA6BF),
                                      //           strokeWidth: 2,
                                      //         ),
                                      //         errorBuilder: (context, error, stackTrace) =>
                                      //             Image.asset(
                                      //                 "assets/images/image_not_found.png")
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment:
                                          // MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                data.promoCode!.isNotEmpty
                                                    ? Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          // Set the background color here
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          border: Border.all(
                                                            color: Colors
                                                                .purple, // Set the border color here
                                                            width:
                                                                1.0, // Set the border width here
                                                          ),
                                                        ),
                                                        child: Text(
                                                          // (Utils.parseHtmlString(
                                                          data.promoCode ?? '',
                                                          // ))
                                                          // .sentenceCase,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )
                                                    : Container(),
                                                data.promoCode!.isNotEmpty
                                                    ? SizedBox(
                                                        width: 4.w,
                                                      )
                                                    : SizedBox(
                                                        width: 0,
                                                      ),
                                                Text(
                                                  // (Utils.parseHtmlString(
                                                  data.title ?? '',
                                                  // ))
                                                  // .sentenceCase,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              (parseHtmlString(
                                                  data.description ?? '')),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                            // SizedBox(height: 6),
                                            // Text(
                                            //   // (Utils.parseHtmlString(
                                            //   "Min Cart Value: "+data.minCart ?? '',
                                            //   // ))
                                            //   // .sentenceCase,
                                            //   style: const TextStyle(
                                            //     fontSize: 12,
                                            //     fontWeight: FontWeight.w500,
                                            //   ),
                                            //   maxLines: 1,
                                            //   overflow: TextOverflow.ellipsis,
                                            // ),
                                            // SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   width: 90.w,
                                      //   alignment: Alignment.centerRight,
                                      //   padding: EdgeInsets.only(left: 70.w),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Row(
                                      //         children: [
                                      //           const Icon(
                                      //             Icons.date_range_outlined,
                                      //             size: 12,
                                      //             color: Colors.blueGrey,
                                      //           ),
                                      //           Utils.sizedBoxWidth(4),
                                      //           Text(
                                      //             data.publishDate != null
                                      //                 ? Utils.dateFormatter(
                                      //                 data.publishDate!)
                                      //                 : '',
                                      //             style: const TextStyle(
                                      //                 fontSize: 12,
                                      //                 color: Colors.blueGrey),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  )),
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return const Text("Something Went Wrong");
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      );
                    }
                  })),
        ),
      ),
    );
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
