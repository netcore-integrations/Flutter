import 'dart:async';
import 'dart:developer';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/presentation/app_inbox/utils/utils.dart';
import 'package:keshav_s_application2/presentation/app_inbox/widgets/smt_audio_notification_view.dart';
import 'package:keshav_s_application2/presentation/app_inbox/widgets/smt_carousel_notification_view.dart';
import 'package:keshav_s_application2/presentation/app_inbox/widgets/smt_gif_notification_view.dart';
import 'package:keshav_s_application2/presentation/app_inbox/widgets/smt_image_notification_view.dart';
import 'package:keshav_s_application2/presentation/app_inbox/widgets/smt_simple_notification_view.dart';
import 'package:keshav_s_application2/presentation/app_inbox/widgets/smt_video_notification_view.dart';
import 'package:smartech_appinbox/model/smt_appinbox_model.dart';
import 'package:smartech_appinbox/smartech_appinbox.dart';
import 'package:smartech_base/smartech_base.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SMTAppInboxScreen extends StatefulWidget {
  const SMTAppInboxScreen({Key? key}) : super(key: key);

  @override
  State<SMTAppInboxScreen> createState() => _SMTAppInboxScreenState();
}

class _SMTAppInboxScreenState extends State<SMTAppInboxScreen> {
  List<MessageCategory> categoryList = [];
  List<SMTAppInboxMessages> inboxList = [];
  List<SMTAppInboxMessages> newinboxList = [];
  bool isDataLoading = true;
  var inbox_count;

  var appBarHeight = AppBar().preferredSize.height;
  CustomPopupMenuController _controller = CustomPopupMenuController();
  int messageLimit = 30;
  String smtInboxDataType = "all";
  String smtAppInboxMessageType = "inbox";

  final ScrollController _scrollController = ScrollController();
  // Int64? latestMessageTimeStamp;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreItems);
    initialApiCall();
    getMessagesList();
    Timer(Duration(seconds: 2), () {
      Smartech().trackEvent("app_inbox_screen", {"login": "no"});
    });
  }

  @override
  void dispose() {
    _controller.hideMenu();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreItems() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        // _items.addAll(List.generate(20, (index) => 'Item ${_items.length}'));
      });
    }
  }

  Future initialApiCall() async {
    await getMessageListByApiCall();
    //await getMessagesList();
    await Future.wait([
      getAppInboxCategoryWiseMessageList(),
      getCategoryList(),
      getAppInboxMessageCount(), // This method use to get appinbox messages count based on message type
      //getMessagesList(),// This method use to get all types of notifications
    ]);
    isDataLoading = false;
    setState(() {});
  }

  pullToRefreshApiCall() async {
    smtInboxDataType = "latest";
    categoryList = [];
    await getMessageListByApiCall(smtInboxDataType: smtInboxDataType);
    await Future.wait([
      getAppInboxCategoryWiseMessageList(),
      getCategoryList(),
      getAppInboxMessageCount(), // This method use to get appinbox messages count based on message type
    ]);
  }

  Future getCategoryList() async {
    categoryList = [];
    await SmartechAppinbox().getAppInboxCategoryList().then((value) {
      if (value != null) {
        categoryList.addAll(value);
      }
      log("getCategoryList: " + categoryList.toString());
    });
  }

  Future getAppInboxCategoryWiseMessageList(
      {List<MessageCategory>? categoryList}) async {
    inboxList = [];
    // var url =
    //     'https://appinbox.netcoresmartech.com/v1/appinbox?appId=83f135604f51c4e1eb268c1d8ff0f1fa&identity=8920616622&limit=10&direction=all&timestamp=-1&guid=D274A9CA-1837-47C4-A290-9496BEDB876B';
    // var response = await Dio().get(
    //   url,
    //   // options: Options(
    //   //   headers: {
    //   //     "Content-Type": "application/json",
    //   //     "Accept": "*/*",
    //   //   },
    //   // ),
    //   // data: formData
    // );
    // if (response.statusCode == 200) {
    //   //print(response.data);
    //   // var model = jsonEncode(response.data);
    //   // Map<String, dynamic> data = jsonDecode(model);
    //   // print(data['inbox'][4]['aps']['payload']);
    // }
    await SmartechAppinbox()
        .getAppInboxCategoryWiseMessageList(
            categoryList: categoryList
                    ?.where((element) => element.selected)
                    .map((e) => e.name)
                    .toList() ??
                [])
        .then((value) {
      if (value != null) {
        inboxList.addAll(value);
        for (int i = 0; i < inboxList.length; i++) {
          String status = inboxList[i].smtPayload!.status.toLowerCase();
          print("************status:" + status);
          //this one for unread messages
          // if (status == 'delivered' || status == 'viewed') {
          //   newinboxList.add(inboxList[i]);
          // }
          //this one for read messages
          if (status == 'clicked') {
            newinboxList.add(inboxList[i]);
            print("new message: " + newinboxList[i].smtPayload!.status);
            // print("new message: " + inboxList[i].smtPayload!.status);
          }
        }
      }
      // log(inboxList.toString());
      setState(() {});
    });
  }

  markMessageAsDismissed(String trid) async {
    await SmartechAppinbox().markMessageAsDismissed(trid);
  }

  markMessageAsClicked(String deeplink, String trid) async {
    await SmartechAppinbox().markMessageAsClicked(deeplink, trid);
  }

  markMessageAsViewed(String trid) async {
    await SmartechAppinbox().markMessageAsViewed(trid);
  }

  /// ======>  This is method to get all notifications <======= ///
  getMessagesList() async {
    // inboxList = [];
    await SmartechAppinbox().getAppInboxMessages().then((value) {
      // log("*****************");
      // log(value!.first.smtPayload!.status.toString());
      // log("*****************");
      // if (value != null) {
      //   inboxList.addAll(value);
      // }
      // setState(() {});
      // log(inboxList.toString());
      // print(value);
    });
  }

  Future getMessageListByApiCall(
      {int? messageLimit,
      String? smtInboxDataType,
      List<MessageCategory>? filterCategoryList}) async {
    await SmartechAppinbox()
        .getAppInboxMessagesByApiCall(
            messageLimit: messageLimit ?? 30,
            smtInboxDataType: smtInboxDataType ?? "",
            categoryList: categoryList
                .where((element) => element.selected)
                .map((e) => e.name)
                .toList())
        .then((value) {
      print("getMessageListByApiCall: " + value.toString());

      setState(() {});
    });
  }

  Future getAppInboxMessageCount({String? smtAppInboxMessageType}) async {
    await SmartechAppinbox()
        .getAppInboxMessageCount(
            smtAppInboxMessageType: smtAppInboxMessageType ?? "unread")
        .then(
      (value) {
        // inbox_count=int.tryParse(value.toString() ?? "");
        // print("inbox_count: "+inbox_count);
        // print("************" + value.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> statuses = ['delivered', 'sent', 'viewed', 'clicked'];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: newinboxList.length > 0
            ? [
                CustomPopupMenu(
                  child: Container(
                    child: Icon(Icons.menu, color: Colors.black),
                    padding: EdgeInsets.all(20),
                  ),
                  menuBuilder: () => CategoryListWidget(
                    categoryList,
                    (selectedList) {
                      categoryList = selectedList;
                      print(categoryList);
                      getAppInboxCategoryWiseMessageList(
                          categoryList: categoryList);
                      setState(() {});
                    },
                  ),
                  pressType: PressType.singleClick,
                  verticalMargin: -10,
                  controller: _controller,
                ),
              ]
            : [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: MultiSelectChip(
                categoryList
                    .where((element) => (element.selected == true))
                    .toList(), onSelectionChanged: (selectedList) {
              getAppInboxCategoryWiseMessageList(categoryList: categoryList);
              setState(() {});
            }),
          ),
          Expanded(
              child: Stack(
            children: [
              if (!isDataLoading && newinboxList.isEmpty)
                Center(
                    child: Text(
                  "There are no notifications for you.",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )),
              if (isDataLoading) Center(child: CupertinoActivityIndicator()),
              if (!isDataLoading)
                RefreshIndicator(
                    onRefresh: () async {
                      await pullToRefreshApiCall();
                    },
                    child: ListView.builder(
                      itemCount: newinboxList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("New Length: " + newinboxList.length.toString());
                        switch (newinboxList[index].smtPayload!.type) {
                          // ******* Image type Notifications ******* \\
                          case SMTNotificationType.image:
                            return VisibilityDetector(
                              key: Key(index.toString()),
                              onVisibilityChanged: (VisibilityInfo info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                // log('Widget ${inboxList[index].trid} is ${visiblePercentage}% visible');
                                if (visiblePercentage == 100 &&
                                    newinboxList[index]
                                            .smtPayload!
                                            .status
                                            .toLowerCase() !=
                                        "viewed") {
                                  markMessageAsViewed(
                                      newinboxList[index].smtPayload!.trid);
                                  return;
                                }
                              },
                              child: Dismissible(
                                key: Key(newinboxList[index].smtPayload!.trid),
                                onDismissed: (direction) async {
                                  await markMessageAsDismissed(
                                      newinboxList[index].smtPayload!.trid);
                                  await newinboxList.removeAt(index);
                                  await getCategoryList();
                                  setState(() {});
                                },
                                background: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 26),
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: AppColor.greyColorText,
                                      ),
                                    )),
                                child: InkWell(
                                  onTap: () {
                                    markMessageAsClicked(
                                        newinboxList[index]
                                            .smtPayload!
                                            .deeplink,
                                        newinboxList[index].smtPayload!.trid);
                                  },
                                  child: SMTImageNotificationView(
                                    inbox: newinboxList[index].smtPayload!,
                                  ),
                                ),
                              ),
                            );

                          // ******* GIF type Notifications ******* \\
                          case SMTNotificationType.gif:
                            return VisibilityDetector(
                              key: Key(index.toString()),
                              onVisibilityChanged: (VisibilityInfo info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                // log('Widget ${inboxList[index].trid} is ${visiblePercentage}% visible');
                                if (visiblePercentage == 100 &&
                                    inboxList[index]
                                            .smtPayload!
                                            .status
                                            .toLowerCase() !=
                                        "viewed") {
                                  markMessageAsViewed(
                                      inboxList[index].smtPayload!.trid);
                                  return;
                                }
                              },
                              child: Dismissible(
                                key: Key(inboxList[index].smtPayload!.trid),
                                onDismissed: (direction) async {
                                  await markMessageAsDismissed(
                                      inboxList[index].smtPayload!.trid);
                                  await inboxList.removeAt(index);
                                  await getCategoryList();
                                  setState(() {});
                                },
                                background: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 26),
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColor.greyColorText,
                                      ),
                                    )),
                                child: InkWell(
                                  onTap: () {
                                    markMessageAsClicked(
                                        inboxList[index].smtPayload!.deeplink,
                                        inboxList[index].smtPayload!.trid);
                                  },
                                  child: GIFNotificationView(
                                    inbox: inboxList[index].smtPayload!,
                                  ),
                                ),
                              ),
                            );

                          // ******* Audio type Notifications ******* \\
                          case SMTNotificationType.audio:
                            return VisibilityDetector(
                              key: Key(index.toString()),
                              onVisibilityChanged: (VisibilityInfo info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                // log('Widget ${inboxList[index].trid} is ${visiblePercentage}% visible');
                                if (visiblePercentage == 100 &&
                                    inboxList[index]
                                            .smtPayload!
                                            .status
                                            .toLowerCase() !=
                                        "viewed") {
                                  markMessageAsViewed(
                                      inboxList[index].smtPayload!.trid);
                                  return;
                                }
                              },
                              child: Dismissible(
                                key: Key(inboxList[index].smtPayload!.trid),
                                onDismissed: (direction) async {
                                  await markMessageAsDismissed(
                                      inboxList[index].smtPayload!.trid);
                                  await inboxList.removeAt(index);
                                  await getCategoryList();
                                  setState(() {});
                                },
                                background: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 26),
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColor.greyColorText,
                                      ),
                                    )),
                                child: InkWell(
                                  onTap: () {
                                    markMessageAsClicked(
                                        inboxList[index].smtPayload!.deeplink,
                                        inboxList[index].smtPayload!.trid);
                                  },
                                  child: SMTAudioNotificationView(
                                    inbox: inboxList[index].smtPayload!,
                                  ),
                                ),
                              ),
                            );

                          // ******* Carousel type Notifications ******* \\
                          case SMTNotificationType.carouselLandscape:
                          case SMTNotificationType.carouselPortrait:
                            return VisibilityDetector(
                              key: Key(index.toString()),
                              onVisibilityChanged: (VisibilityInfo info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                // log('Widget ${inboxList[index].trid} is ${visiblePercentage}% visible');
                                if (visiblePercentage == 100 &&
                                    inboxList[index]
                                            .smtPayload!
                                            .status
                                            .toLowerCase() !=
                                        "viewed") {
                                  markMessageAsViewed(
                                      inboxList[index].smtPayload!.trid);
                                  return;
                                }
                              },
                              child: Dismissible(
                                key: Key(inboxList[index].smtPayload!.trid),
                                onDismissed: (direction) async {
                                  await markMessageAsDismissed(
                                      inboxList[index].smtPayload!.trid);
                                  await inboxList.removeAt(index);
                                  await getCategoryList();
                                  setState(() {});
                                },
                                background: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 26),
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColor.greyColorText,
                                      ),
                                    )),
                                child: InkWell(
                                  onTap: () async {
                                    markMessageAsClicked(
                                        inboxList[index].smtPayload!.deeplink,
                                        inboxList[index].smtPayload!.trid);
                                  },
                                  child: SMTCarouselNotificationView(
                                    inbox: inboxList[index].smtPayload!,
                                  ),
                                ),
                              ),
                            );

                          // ******* Video type Notifications ******* \\
                          case SMTNotificationType.video:
                            return VisibilityDetector(
                              key: Key(index.toString()),
                              onVisibilityChanged: (VisibilityInfo info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                // log('Widget ${inboxList[index].trid} is ${visiblePercentage}% visible');
                                if (visiblePercentage == 100 &&
                                    inboxList[index]
                                            .smtPayload!
                                            .status
                                            .toLowerCase() !=
                                        "viewed") {
                                  markMessageAsViewed(
                                      inboxList[index].smtPayload!.trid);
                                  return;
                                }
                              },
                              child: Dismissible(
                                key: Key(inboxList[index].smtPayload!.trid),
                                onDismissed: (direction) async {
                                  await markMessageAsDismissed(
                                      inboxList[index].smtPayload!.trid);
                                  await inboxList.removeAt(index);
                                  await getCategoryList();
                                  setState(() {});
                                },
                                background: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 26),
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColor.greyColorText,
                                      ),
                                    )),
                                child: InkWell(
                                  onTap: () {
                                    markMessageAsClicked(
                                        inboxList[index].smtPayload!.deeplink,
                                        inboxList[index].smtPayload!.trid);
                                  },
                                  child: SMTVideoNotificationView(
                                    inbox: inboxList[index].smtPayload!,
                                  ),
                                ),
                              ),
                            );

                          // ******* Simple type Notifications ******* \\
                          case SMTNotificationType.simple:
                          default:
                            return VisibilityDetector(
                              key: Key(index.toString()),
                              onVisibilityChanged: (VisibilityInfo info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                // log('Widget ${inboxList[index].trid} is ${visiblePercentage}% visible');
                                if (visiblePercentage == 100 &&
                                    newinboxList[index]
                                            .smtPayload!
                                            .status
                                            .toLowerCase() !=
                                        "viewed") {
                                  markMessageAsViewed(
                                      newinboxList[index].smtPayload!.trid);
                                  return;
                                }
                              },
                              child: Dismissible(
                                key: Key(newinboxList[index].smtPayload!.trid),
                                onDismissed: (direction) async {
                                  await markMessageAsDismissed(
                                      newinboxList[index].smtPayload!.trid);
                                  await newinboxList.removeAt(index);
                                  await getCategoryList();
                                  setState(() {});
                                },
                                background: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 26),
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColor.greyColorText,
                                      ),
                                    )),
                                child: InkWell(
                                  onTap: () {
                                    markMessageAsClicked(
                                        newinboxList[index]
                                            .smtPayload!
                                            .deeplink,
                                        newinboxList[index].smtPayload!.trid);
                                  },
                                  child: SMTSimpleNotificationView(
                                    inbox: newinboxList[index].smtPayload!,
                                  ),
                                ),
                              ),
                            );
                        }
                      },
                    ))
            ],
          ))
        ],
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<MessageCategory> categoryList;
  final Function(List<MessageCategory>) onSelectionChanged;
  MultiSelectChip(this.categoryList, {required this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  @override
  void initState() {
    super.initState();
    print("selected chip count: " + widget.categoryList.length.toString());
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.categoryList.forEach((item) {
      choices.add(Container(
        padding: EdgeInsets.only(right: 12),
        child: ChoiceChip(
          selectedColor: Colors.white,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 4,
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.cancel_outlined,
                  size: 22,
                ),
              )
            ],
          ),
          selected: item.selected,
          onSelected: (selected) {
            setState(() {
              item.selected = selected;
              widget.onSelectionChanged(widget.categoryList);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class CategoryListWidget extends StatefulWidget {
  final List<MessageCategory> categoryList;
  final Function(List<MessageCategory>) onSelected;

  CategoryListWidget(this.categoryList, this.onSelected);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  List<MessageCategory> categoryList = [];
  @override
  void initState() {
    super.initState();
    categoryList = [...widget.categoryList];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      color: Colors.white,
      child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  categoryList[index].selected = !categoryList[index].selected;
                });
                widget.onSelected(categoryList);
              },
              child: CheckboxListTile(
                title: Text(
                  categoryList[index].name,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                autofocus: false,
                // dense: true,
                activeColor: Colors.green,
                checkColor: Colors.white,
                selected: categoryList[index].selected,
                value: categoryList[index].selected,
                onChanged: (bool? value) {
                  setState(() {
                    categoryList[index].selected =
                        !categoryList[index].selected;
                  });
                  widget.onSelected(categoryList);
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
            );
          },
          itemCount: categoryList.length),
    );
  }
}
