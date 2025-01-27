import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:keshav_s_application2/core/utils/color_constant.dart';
import 'package:keshav_s_application2/core/utils/image_constant.dart';
import 'package:keshav_s_application2/core/utils/size_utils.dart';
import 'package:keshav_s_application2/screenwithoutlogin/BlogsDetailScreen1.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;
import 'package:sizer/sizer.dart';
import 'package:smartech_base/smartech_base.dart';

import '../../../widgets/app_bar/appbar_subtitle_6.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

import '../presentation/drawermenuitems/blogs/Model/blogsModel.dart';

class BlogsScreen1 extends StatefulWidget {
  // otp.Data data;
  //
  // BlogsScreen1(this.data);

  @override
  State<BlogsScreen1> createState() => _BlogsScreen1State();
}

class _BlogsScreen1State extends State<BlogsScreen1> {
  Future<BlogsModel>? blogs;
  List<BlogsData> blogslist = [];

  Future<BlogsModel> getBlogsList() async {
    Map data = {
      // 'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().get("https://fabfurni.com/api/Webservice/blogList",
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
      if (BlogsModel.fromJson(jsonObject).status == "true") {
        return BlogsModel.fromJson(jsonObject);
        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (BlogsModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(BlogsModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (BlogsModel.fromJson(jsonObject).data == null) {
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
    blogs = getBlogsList();
    blogs!.then((value) {
      setState(() {
        blogslist = value.data!;
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
                text: "Our Blogs",
                margin: getMargin(left: 19, top: 49, bottom: 42)),
            styleType: Style.bgShadowBlack90033),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<BlogsModel>(
                  future: blogs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DateFormat dateFormat = DateFormat('dd-MM-yyyy');
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
                                            text: "No Blogs Found",
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
                          itemCount: blogslist.length,
                          itemBuilder: (context, index) {
                            var data = blogslist[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlogsDetailScreen1(data.id!)));
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: size.width,
                                  height: 220,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        child: Container(
                                          height: 16.h,
                                          width: 90.w,
                                          child: Image.network(data.image!,
                                              fit: BoxFit.cover,
                                              width: 100.w,
                                              // alignment: Alignment(1.2, 1.2),
                                              filterQuality: FilterQuality.high,
                                              loadingBuilder:
                                                  (context, child,
                                                          loadingProgress) =>
                                                      (loadingProgress == null)
                                                          ? child
                                                          : AnimatedShimmer(
                                                              height: 16.h,
                                                              width: 90.w,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                              delayInMilliSeconds:
                                                                  Duration(
                                                                      milliseconds:
                                                                          index *
                                                                              500),
                                                            ),
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                      "assets/images/image_not_found.png")),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              // (Utils.parseHtmlString(
                                              data.name ?? '',
                                              // ))
                                              // .sentenceCase,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 8),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Text(
                                                  (parseHtmlString(
                                                      data.description ?? '')),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.blueGrey),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
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
