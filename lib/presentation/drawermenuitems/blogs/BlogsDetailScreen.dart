import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:flutter_html/flutter_html.dart';
import 'package:keshav_s_application2/core/utils/color_constant.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/image_constant.dart';
import '../../../core/utils/size_utils.dart';
import '../../../widgets/app_bar/appbar_image.dart';
import '../../../widgets/app_bar/appbar_subtitle_5.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart' as customappbar;
import 'Model/blogsdetailsModel.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

class BlogsDetailScreen extends StatefulWidget {
  otp.Data data;
  String blog_id;

  BlogsDetailScreen(this.data, this.blog_id);

  @override
  State<BlogsDetailScreen> createState() => _BlogsDetailScreenState();
}

class _BlogsDetailScreenState extends State<BlogsDetailScreen> {
  Future<BlogsDetailModel>? blogs;
  List<BlogsDetailData> blogslist = [];

  Future<BlogsDetailModel> getBlogsList() async {
    Map data = {'user_id': widget.data.id, "blog_id": widget.blog_id};
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/blogDetails",
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
      if (BlogsDetailModel.fromJson(jsonObject).status == "true") {
        return BlogsDetailModel.fromJson(jsonObject);
        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (BlogsDetailModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(BlogsDetailModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (BlogsDetailModel.fromJson(jsonObject).data == null) {
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
    return Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      appBar: customappbar.CustomAppBar(
          height: getVerticalSize(91),
          leadingWidth: 34,
          leading: AppbarImage(
              height: getVerticalSize(15),
              width: getHorizontalSize(9),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 25, top: 53, bottom: 23),
              onTap: () {
                Navigator.pop(context);
              }),
          title: AppbarTitle(
              text: "Blog Detail",
              margin: getMargin(left: 19, top: 50, bottom: 18)),
          // actions: [
          //   AppbarImage(
          //       height: getSize(21),
          //       width: getSize(21),
          //       svgPath: ImageConstant.imgSearch,
          //       margin: getMargin(left: 12, top: 51, right: 19)),
          //   Container(
          //       height: getVerticalSize(23),
          //       width: getHorizontalSize(27),
          //       margin:
          //           getMargin(left: 20, top: 48, right: 19, bottom: 1),
          //       child: Stack(alignment: Alignment.topRight, children: [
          //         AppbarImage(
          //             height: getVerticalSize(18),
          //             width: getHorizontalSize(21),
          //             svgPath: ImageConstant.imgLocation,
          //             margin: getMargin(top: 5, right: 6)),
          //         AppbarSubtitle6(
          //             text: "lbl_2".tr,
          //             margin: getMargin(left: 17, bottom: 13))
          //       ])),
          //   Container(
          //       height: getVerticalSize(24),
          //       width: getHorizontalSize(29),
          //       margin: getMargin(left: 14, top: 48, right: 31),
          //       child: Stack(alignment: Alignment.topRight, children: [
          //         AppbarImage(
          //             height: getVerticalSize(20),
          //             width: getHorizontalSize(23),
          //             svgPath: ImageConstant.imgCart,
          //             margin: getMargin(top: 4, right: 6)),
          //         AppbarSubtitle6(
          //             text: "lbl_3".tr,
          //             margin: getMargin(left: 19, bottom: 14))
          //       ]))
          // ],
          styleType: customappbar.Style.bgStyle_2),
      body: FutureBuilder(
        future: blogs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData) {
              return Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Expanded(
                        child: Wrap(
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Data Not Found",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                  // Utils.noDataTextWidget()
                  );
            } else {
              return ListView.builder(
                  itemCount: blogslist.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              height: 28.h,
                              width: 100.w,
                              child: CachedNetworkImage(
                                imageUrl: blogslist[index].image!,
                                imageBuilder: (context, imageProvider) =>
                                    GestureDetector(
                                  onTap: (() {
                                    // print(newsList.image!);
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //       return Utils.documentViewer(
                                    //           '${AppConfig.domainName}${newsList.image!}',
                                    //           context);
                                    //     }));
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                  ),
                                ),
                                fit: BoxFit.contain,
                                placeholder: (context, url) =>
                                    const CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        "assets/images/image_not_found.png"),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 19.0),
                                  child: Text(
                                    blogslist[index].name ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: html.Html(
                                    data: blogslist[index].description ?? '',
                                    style: {
                                      '*': html.Style(
                                        fontSize: FontSize(14.sp),
                                        fontFamily: 'Roboto',
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400,
                                        lineHeight: LineHeight(1.sp),
                                      ),
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
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
        },
      ),
    );
  }
}
