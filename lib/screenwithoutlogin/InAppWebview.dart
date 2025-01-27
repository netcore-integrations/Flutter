import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:keshav_s_application2/core/utils/color_constant.dart';
import 'package:keshav_s_application2/core/utils/image_constant.dart';
import 'package:keshav_s_application2/core/utils/size_utils.dart';
import 'package:keshav_s_application2/screenwithoutlogin/landingpageafterlogin.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/no_internet.dart';
import 'package:keshav_s_application2/widgets/no_internet_widget.dart';
import 'package:keshav_s_application2/widgets/not_found.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartech_base/smartech_base.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/Constant.dart';
import '../widgets/Strings.dart';
import '../widgets/navigationbarprovider.dart';
import 'package:provider/src/provider.dart';

class Inappwebview extends StatefulWidget {
  const Inappwebview();

  @override
  State<Inappwebview> createState() => _InappwebviewState();
}

class _InappwebviewState extends State<Inappwebview>
    with SingleTickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  final Completer<InAppWebViewController> _completer =
      Completer<InAppWebViewController>();
  late PullToRefreshController _pullToRefreshController;
  CookieManager cookieManager = CookieManager.instance();
  bool flag = false;

  double progress = 0;
  String url = 'https://cedocs.netcorecloud.com/';
  int _previousScrollY = 0;
  var received;
  bool isLoading = false;
  bool showErrorPage = false;
  bool slowInternetPage = false;
  bool noInternet = false;
  late AnimationController animationController;
  late Animation<double> animation;
  final expiresDate =
      DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch;
  String _connectionStatus = 'ConnectivityResult.none';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  var browserOptions;
  @override
  void initState() {
    super.initState();

    NoInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      NoInternet.updateConnectionStatus(result as ConnectivityResult)
          .then((value) => setState(() {
                _connectionStatus = value;
                if (_connectionStatus != 'ConnectivityResult.none') {
                  // if (_webViewController != null) {
                  //   Future.delayed(Duration.zero).then((value) =>
                  //       _webViewController!
                  //           .loadUrl(urlRequest: URLRequest(url: Uri.parse(url))));
                  // }
                  noInternet = false;
                } else {
                  noInternet = true;
                }
              }));
    });
    try {
      _pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.red,
        ),
        onRefresh: () async {
          if (Platform.isAndroid) {
            _webViewController!.reload();
          } else if (Platform.isIOS) {
            _webViewController!.loadUrl(
                urlRequest:
                    URLRequest(url: await _webViewController!.getUrl()));
          }
        },
      );
    } on Exception catch (e) {
      print(e);
    }

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat();
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    animationController.dispose();
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
          useOnDownloadStart: true,
          javaScriptEnabled: true,
          cacheEnabled: true,
          userAgent:
              "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
          verticalScrollBarEnabled: false,
          horizontalScrollBarEnabled: false,
          transparentBackground: true),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        thirdPartyCookiesEnabled: true,
        allowFileAccess: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    bool _validURL = Uri.parse(url).host == '' ? false : true;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).cardColor,
      statusBarBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.dark
          : Brightness.light,
    ));
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        appBar: CustomAppBar(
            height: getVerticalSize(70),
            leadingWidth: 41,
            leading: AppbarImage(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  bool? isLoggedIn = prefs.getBool("isLoggedIn");
                  var mobileNumber = prefs.getString("mobileNumber");
                  print(mobileNumber);
                  if (mobileNumber != null &&
                      isLoggedIn != null &&
                      isLoggedIn) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                height: getVerticalSize(15),
                width: getHorizontalSize(9),
                svgPath: ImageConstant.imgArrowleft,
                margin: getMargin(left: 20, top: 30, bottom: 25)),
            title: AppbarTitle(
                text: "Webview",
                margin: getMargin(left: 19, top: 49, bottom: 42)),
            styleType: Style.bgShadowBlack90033),
        body: !flag
            ? Container(
                color: Colors.transparent,
                child: InAppWebView(
                  key: webViewKey,
                  initialData: InAppWebViewInitialData(data: """
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <script src='//cdnt.netcoresmartech.com/smartechclient.js'></script>
        <script> 
            smartech('create', 'ADGMOT35CHFLVDHBJNIG50K96BRO5PMRKBGKVF1G91LVOR7E40R0' );
            smartech('register', '9a408c4705e48967ef0727700ee1490e');
        </script>

    </head>
    <body>
        <h1>JavaScript Handlers (Channels) TEST</h1>
        <button id='test' onclick="window.flutter_inappwebview.callHandler('testFunc');">Test</button>
        <button id='login' onclick="window.flutter_inappwebview.callHandler('login', 34567);">Login</button>
        <button id='add_to_cart' onclick="window.flutter_inappwebview.callHandler('add_to_cart', 1);">Add to Cart</button>
        <button id='testreturn' onclick="window.flutter_inappwebview.callHandler('testFuncReturn').then(function(result) { alert(result);});">Test Return</button>
    </body>
</html>
                  """),
                  // InAppWebViewInitialData(
                  //     data: url, mimeType: 'text/html', encoding: "utf8"),
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          useShouldOverrideUrlLoading: true,
                          mediaPlaybackRequiresUserGesture: true,
                          useOnDownloadStart: true,
                          cacheEnabled: true,
                          userAgent:
                              "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
                          javaScriptEnabled: true,
                          transparentBackground: true),
                      android: AndroidInAppWebViewOptions(
                          useHybridComposition: true, defaultFontSize: 32),
                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                      )),
                  pullToRefreshController: _pullToRefreshController,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                    _webViewController!.addJavaScriptHandler(
                        handlerName: 'testFunc',
                        callback: (args) {
                          print(args);
                        });

                    _webViewController!.addJavaScriptHandler(
                        handlerName: 'login',
                        callback: (args) async {
                          Smartech().login(args[0].toString());
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString("mobileNumber", args[0].toString());
                          pref.setBool("isLoggedIn", true);
                          print(args);
                        });

                        _webViewController!.addJavaScriptHandler(
                        handlerName: 'add_to_cart',
                        callback: (args) async {
                          // Smartech().trackEvent("Add to cart",{});
                          print(args);
                        });

                    _webViewController!.addJavaScriptHandler(
                        handlerName: 'testFuncReturn',
                        callback: (args) {
                          print(args);
                          return '2';
                        });
                  },
                  onScrollChanged: (controller, x, y) async {
                    int currentScrollY = y;

                    if (currentScrollY > _previousScrollY) {
                      _previousScrollY = currentScrollY;
                      if (!context
                          .read<NavigationBarProvider>()
                          .animationController
                          .isAnimating) {
                        context
                            .read<NavigationBarProvider>()
                            .animationController
                            .forward();
                      }
                    } else {
                      _previousScrollY = currentScrollY;

                      if (!context
                          .read<NavigationBarProvider>()
                          .animationController
                          .isAnimating) {
                        context
                            .read<NavigationBarProvider>()
                            .animationController
                            .reverse();
                      }
                    }
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      this.url = url.toString();
                      // isInitialLoaded = false;
                    });
                  },
                  onLoadStop: (controller, url) async {
                    _pullToRefreshController.endRefreshing();
                    //  _webViewController!
                    //      _webViewController!.injectCSSFileFromUrl(urlFile: urlFile)
                  },
                  onLoadError: (controller, url, code, message) {
                    _pullToRefreshController.endRefreshing();

                    setState(() {
                      slowInternetPage = true;
                    });
                  },
                  onLoadHttpError: (controller, url, statusCode, description) {
                    setState(() {
                      showErrorPage = true;
                    });
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      _pullToRefreshController.endRefreshing();
                    }
                    setState(() {
                      this.progress = progress / 100;
                      // urlController.text = this.url;
                    });
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              )
            : Stack(
                children: [
                  _validURL
                      ? InAppWebView(
                          key: webViewKey,

                          // initialFile: 'assets/icons/test.html',

                          initialUrlRequest: URLRequest(url: WebUri(url)),
                          initialOptions: options,
                          pullToRefreshController: _pullToRefreshController,
                          gestureRecognizers: <Factory<
                              OneSequenceGestureRecognizer>>{
                            Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                          },
                          onWebViewCreated: (controller) async {
                            _webViewController = controller;
                            //below code for custom tab
                            // browser.open(
                            //     url: Uri.parse(widget.url),
                            //     options: ChromeSafariBrowserClassOptions(
                            //         android: AndroidChromeCustomTabsOptions(
                            //             enableUrlBarHiding: true,
                            //             instantAppsEnabled: false,
                            //             keepAliveEnabled: true,
                            //             addDefaultShareMenuItem: false),
                            //         ios: IOSSafariOptions(
                            //             barCollapsingEnabled: true)));

                            await cookieManager.setCookie(
                              url: WebUri(url),
                              name: "myCookie",
                              value: "myValue",
                              // domain: ".flutter.dev",
                              expiresDate: expiresDate,
                              isHttpOnly: false,
                              isSecure: true,
                            );
                          },
                          onScrollChanged: (controller, x, y) async {
                            int currentScrollY = y;
                            if (currentScrollY > _previousScrollY) {
                              _previousScrollY = currentScrollY;
                              if (!context
                                  .read<NavigationBarProvider>()
                                  .animationController
                                  .isAnimating) {
                                context
                                    .read<NavigationBarProvider>()
                                    .animationController
                                    .forward();
                              }
                            } else {
                              _previousScrollY = currentScrollY;

                              if (!context
                                  .read<NavigationBarProvider>()
                                  .animationController
                                  .isAnimating) {
                                context
                                    .read<NavigationBarProvider>()
                                    .animationController
                                    .reverse();
                              }
                            }
                          },

                          onLoadStart: (controller, url) async {
                            print('----loadstart---- $url');

                            // controller.loadUrl(
                            //     urlRequest: URLRequest(
                            //         url: Uri.parse(
                            //             'file://storage/emulated/0/Download/myArchive.mht')));
                            setState(() {
                              isLoading = true;
                            });
                            if (Platform.isAndroid) {
                              List<Cookie> cookies =
                                  await cookieManager.getCookies(url: url!);
                              // print('---android cookies---$cookies');
                            }
                            if (Platform.isIOS) {
                              List<Cookie> iosCookies =
                                  await cookieManager.ios.getAllCookies();
                              // print('---ios cookies---$iosCookies');
                            }
                            setState(() {
                              this.url = url.toString();
                            });
                          },
                          onLoadStop: (controller, url) async {
                            _pullToRefreshController.endRefreshing();

                            setState(() {
                              this.url = url.toString();
                              isLoading = false;
                            });

                            // Removes header and footer from page
                            if (hideHeader == true) {
                              _webViewController!
                                  .evaluateJavascript(
                                      source: "javascript:(function() { " +
                                          "var head = document.getElementsByTagName('header')[0];" +
                                          "head.parentNode.removeChild(head);" +
                                          "})()")
                                  .then((value) => debugPrint(
                                      'Page finished loading Javascript'))
                                  .catchError(
                                      (onError) => debugPrint('$onError'));
                            }
                            if (hideFooter == true) {
                              _webViewController!
                                  .evaluateJavascript(
                                      source: "javascript:(function() { " +
                                          "var footer = document.getElementsByTagName('footer')[0];" +
                                          "footer.parentNode.removeChild(footer);" +
                                          "})()")
                                  .then((value) => debugPrint(
                                      'Page finished loading Javascript'))
                                  .catchError(
                                      (onError) => debugPrint('$onError'));
                            }
                          },
                          onLoadError: (controller, url, code, message) async {
                            _pullToRefreshController.endRefreshing();
                            print('---load error----$url');
                            print('---load error----$code');
                            setState(() {
                              if (code == 2) {
                                noInternet = true;
                              }
                              if (code != 102) {
                                slowInternetPage = true;
                              }
                              isLoading = false;
                            });
                          },

                          onLoadHttpError:
                              (controller, url, statusCode, description) {
                            _pullToRefreshController.endRefreshing();
                            print('---load http error----$description');
                            setState(() {
                              showErrorPage = true;
                              isLoading = false;
                            });
                          },
                          androidOnGeolocationPermissionsShowPrompt:
                              (controller, origin) async {
                            await Permission.location.request();
                          },
                          androidOnPermissionRequest:
                              (controller, origin, resources) async {
                            if (resources.contains(
                                'android.webkit.resource.AUDIO_CAPTURE')) {
                              await Permission.microphone.request();
                            }
                            if (resources.contains(
                                'android.webkit.resource.VIDEO_CAPTURE')) {
                              await Permission.camera.request();
                            }

                            return PermissionRequestResponse(
                                resources: resources,
                                action: PermissionRequestResponseAction.GRANT);
                          },

                          onProgressChanged: (controller, progress) {
                            if (progress == 100) {
                              _pullToRefreshController.endRefreshing();
                            }
                            setState(() {
                              this.progress = progress / 100;
                            });
                          },
                          shouldOverrideUrlLoading:
                              (controller, navigationAction) async {
                            var url = navigationAction.request.url.toString();
                            var uri = Uri.parse(url);

                            if (Platform.isIOS && url.contains("geo")) {
                              var newUrl = url.replaceFirst(
                                  'geo://', 'http://maps.apple.com/');

                              if (await canLaunchUrl(Uri.parse(newUrl))) {
                                await launch(newUrl);
                                return NavigationActionPolicy.CANCEL;
                              } else {
                                throw 'Could not launch $newUrl';
                              }
                            } else if (url.contains("tel:") ||
                                url.contains("mailto:") ||
                                url.contains("play.google.com") ||
                                url.contains("maps") ||
                                url.contains("messenger.com")) {
                              url = Uri.encodeFull(url);
                              try {
                                if (await canLaunchUrl(uri)) {
                                  launchUrl(uri);
                                } else {
                                  launchUrl(uri);
                                }
                                return NavigationActionPolicy.CANCEL;
                              } catch (e) {
                                launchUrl(uri);
                                return NavigationActionPolicy.CANCEL;
                              }
                            } else if (![
                              "http",
                              "https",
                              "file",
                              "chrome",
                              "data",
                              "javascript",
                              "about"
                            ].contains(uri.scheme)) {
                              if (await canLaunchUrl(uri)) {
                                // Launch the App
                                await launchUrl(
                                  uri,
                                );
                                // and cancel the request
                                return NavigationActionPolicy.CANCEL;
                              }
                            }

                            return NavigationActionPolicy.ALLOW;
                          },

                          onDownloadStartRequest:
                              (controller, downloadStartRrquest) async {
                            requestPermission().then((status) async {
                              String url = downloadStartRrquest.url.toString();
                              print(url.toString());
                              if (status == true) {
                                try {
                                  Dio dio = Dio();
                                  String dirloc = '';
                                  if (Platform.isAndroid) {
                                    dirloc =
                                        (await getExternalStorageDirectory())!
                                            .path;
                                  } else if (Platform.isIOS) {
                                    dirloc =
                                        (await getApplicationDocumentsDirectory())
                                            .path;
                                  }
                                  print(dirloc);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text('Downloading file..'),
                                  ));
                                  try {
                                    String downloadName = "sample";
                                    String fullPath =
                                        '$dirloc/$downloadName.pdf';
                                    String fileSaved =
                                        '$dirloc/$downloadName.pdf/';
                                    FileUtils.mkdir([fullPath]);
                                    print(fullPath);
                                    await dio.download(url, fileSaved,
                                        onReceiveProgress:
                                            (receivedBytes, totalBytes) async {
                                      received =
                                          ((receivedBytes / totalBytes) * 100);
                                      setState(() {
                                        progress =
                                            (((receivedBytes / totalBytes) *
                                                        100)
                                                    .toStringAsFixed(0) +
                                                '%') as double;
                                      });

                                      if (received == 100.0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Files has been downloaded to $fileSaved'),
                                        ));

                                        // if (url.contains('.pdf')) {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => DownloadViewer(
                                        //         title: title!,
                                        //         filePath: InfixApi().root + url,
                                        //       ),
                                        //     ),
                                        //   );
                                        // } else if (url.contains('.jpg') ||
                                        //     url.contains('.png') ||
                                        //     url.contains('.jpeg')) {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => Utils.documentViewer(InfixApi().root + url, context),
                                        //     ),
                                        //   );
                                        // }
                                        // else {
                                        //   Utils.showToast('No file exists');
                                        //   // var file = await DefaultCacheManager()
                                        //   //     .getSingleFile(InfixApi().root + url);
                                        //   // // OpenFile.open(file.path);
                                        //   // Navigator.push(
                                        //   //   context,
                                        //   //   MaterialPageRoute(
                                        //   //     builder: (context) => Utils.fullScreenImageView(file.path),
                                        //   //   ),
                                        //   // );
                                        // }
                                      }
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                  //     File file = File(url.toString());
                                  //     String fileName = url.toString().substring(
                                  //         url.toString().lastIndexOf('/') + 1,
                                  //         url.toString().lastIndexOf('?'));
                                  //
                                  //     String savePath = await getFilePath(fileName);
                                  //     print(savePath);
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(SnackBar(
                                  //       content: const Text('Downloading file..'),
                                  //     ));
                                  //     await dio.download(url.toString(), savePath,
                                  //         onReceiveProgress: (rec, total) {
                                  //       // _bottomSheetController.setState!(() {
                                  //       //   downloading = true;
                                  //       //   progress = (rec / total);
                                  //       //   downloadingStr = downloadingStartString;
                                  //       // });
                                  //     });
                                  //
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(SnackBar(
                                  //       content: const Text('Download Complete'),
                                  //     ));
                                } on Exception catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text('Downloading failed'),
                                  ));
                                }
                                //   // if (await canLaunchUrl(url)) {
                                //   //   // Launch the App
                                //   //   await launchUrl(url,
                                //   //       mode: LaunchMode.platformDefault);
                                //
                                //   //   // and cancel the request
                                //   // }
                                // } else {
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(SnackBar(
                                //     content: const Text('Permision denied'),
                                //   ));
                                // }
                              }
                            });
                          },
                          onUpdateVisitedHistory:
                              (controller, url, androidIsReload) {
                            print('--from onUpdateVisitedHistory--$url');

                            // setState(() {
                            //   this.url = url.toString();
                            // });
                          },
                          onCloseWindow: (controller) async {
                            //   _webViewController!.evaluateJavascript(source:'document.cookie = "token=$token"');
                          },
                          onConsoleMessage: (controller, message) {
                            print('---console---$message');
                          },
                        )
                      : Center(
                          child: Text(
                          'Url is not valid',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(height: 0, width: 0),
                  noInternet
                      ? Center(
                          child: NoInternetWidget(),
                        )
                      : SizedBox(height: 0, width: 0),
                  showErrorPage
                      ? Center(
                          child: NotFound(
                              _webViewController!,
                              url,
                              CustomStrings.pageNotFound1,
                              CustomStrings.pageNotFound2))
                      : SizedBox(height: 0, width: 0),
                  slowInternetPage
                      ? Center(
                          child: NotFound(
                              _webViewController!,
                              url,
                              CustomStrings.incorrectURL1,
                              CustomStrings.incorrectURL2))
                      : SizedBox(height: 0, width: 0),
                  progress < 1.0
                      ? SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 5.0,
                            decoration: BoxDecoration(color: Colors.blueAccent
                                // gradient: LinearGradient(
                                //   colors: [
                                //     Theme.of(context).progressIndicatorTheme.color!,
                                //     Theme.of(context)
                                //         .progressIndicatorTheme
                                //         .refreshBackgroundColor!,
                                //     Theme.of(context)
                                //         .progressIndicatorTheme
                                //         .linearTrackColor!,
                                //   ],
                                //   stops: const [0.1, 1.0, 0.1],
                                // ),
                                ),
                          ),
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (mounted) {
      if (!context
          .read<NavigationBarProvider>()
          .animationController
          .isAnimating) {
        context.read<NavigationBarProvider>().animationController.reverse();
      }
    }
    if (await _webViewController!.canGoBack()) {
      _webViewController!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<bool> requestPermission() async {
    final status = await Permission.storage.status;

    if (status == PermissionStatus.granted) {
      return true;
    } else if (status != PermissionStatus.granted) {
      //
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        // await openAppSettings();
        return false;
      }
    }
    return true;
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = '/storage/emulated/0/Download';
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    print(path);
    path = '$externalStorageDirPath/$uniqueFileName';
    return path;
  }
}
