import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:keshav_s_application2/core/utils/initial_bindings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../widgets/app_bar/appbar_image.dart';
import '../widgets/app_bar/appbar_title.dart';
import '../widgets/app_bar/custom_app_bar.dart';

class HtmlPAGE extends StatefulWidget {
   const HtmlPAGE();

  @override
  State<HtmlPAGE> createState() => _HtmlPAGEState();
}

class _HtmlPAGEState extends State<HtmlPAGE> {

  var data = Get.arguments;
  print(data) {
    // TODO: implement print
    throw UnimplementedError();
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
              text: "Html Page",
              margin: getMargin(left: 19, top: 49, bottom: 42)),
          styleType: Style.bgShadowBlack90033height85),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 50),
        child: HtmlWidget(
          // the first parameter (`html`) is required
//           '''
// <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
// <html>
// <head>
//   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
//   <meta http-equiv="Content-Style-Type" content="text/css">
//   <title></title>
//   <meta name="Generator" content="Cocoa HTML Writer">
//   <meta name="CocoaVersion" content="2299.5">
//   <style type="text/css">
//     p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 15.0px Times; -webkit-text-stroke: #000000; min-height: 18.0px}
//     p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 15.0px Times; -webkit-text-stroke: #000000}
//     p.p3 {margin: 0.0px 0.0px 12.0px 0.0px; font: 15.0px Times; -webkit-text-stroke: #000000; min-height: 18.0px}
//     p.p4 {margin: 0.0px 0.0px 12.0px 0.0px; font: 15.0px Times; -webkit-text-stroke: #000000}
//     p.p5 {margin: 0.0px 0.0px 12.0px 0.0px; font: 15.3px Times; color: #000000; -webkit-text-stroke: #000000}
//     span.s1 {font-kerning: none}
//     span.s2 {font: 15.3px Times; text-decoration: underline ; font-kerning: none; color: #0000e3; -webkit-text-stroke: 0px #0000e3}
//     span.s3 {text-decoration: underline ; font-kerning: none}
//     span.s4 {font: 14.7px Times; text-decoration: underline ; font-kerning: none; color: #0000e3; background-color: #ffffff; -webkit-text-stroke: 0px #0000e3}
//     span.s5 {font: 16.0px Times; font-kerning: none}
//   </style>
// </head>
// <body>
// <p class="p1"><span class="s1"></span><br></p>
// <p class="p2"><span class="s1">I/We, am/are aware of the following :<span class="Apple-converted-space"> </span></span></p>
// <p class="p3"><span class="s1"></span><br></p>
// <p class="p4"><span class="s1">I/ we agree and hereby authorise Equitas Small Finance Bank to fetch my/ our personal details using OTP. Aadhaar E-KYC which will be used for KYC purposes. My/ our personal details are being drawn from the database maintained by UIDAI based on the Aadhaar number provided by me/ us. Bank is not responsible for any incorrect information that may appear in the data provided by me/ us.The opening of the account will be confirmed only after I/ we enter the OTP number received to my/ our mobile number linked to and available in Aadhaar database.As the details are drawn from UIDAI data base, they cannot be modified or altered by me/us.</span></p>
// <p class="p3"><span class="s1"></span><br></p>
// <p class="p4"><span class="s1">I/ we are solely responsible for the data made available for opening the account.The data may be lost or get distorted during transmission and I/ we shall not make the Bank liable or responsible for the same.</span></p>
// <p class="p3"><span class="s1"></span><br></p>
// <p class="p4"><span class="s1">I/ we agree that this and such account will be subject to regular scrutiny and monitoring from the bank and bank shall have the right to place the account under total freeze/ debit freeze/ close the account at its sole discretion, in case of suspicious transactions or transactions not inconsistent with RBI guidelines relating to the account.</span></p>
// <p class="p3"><span class="s1"></span><br></p>
// <p class="p5"><span class="s1">I/ we do agree to all the general Terms &amp; Conditions which can be accessed at:TERMS AND CONDITIONS WHICH SHALL BE APPLICABLE TO ALL THE ACCOUNTS WHICH ARE EXISTING OR MAY BE OPENED ANYTIME IN FUTURE WITH EQUITAS SMALL FINANCE BANK (THE BANK/ESFB): <a href="https://www.equitasbank.com/pdf/Terms-conditions.pdf"><span class="s2">https://www.equitasbank.com/pdf/Terms-conditions.pdf</span></a></span><span class="s3"> </span><span class="s1">WEBSITE USAGE TERMS &amp; CONDITIONS:<a href="https://www.equitasbank.com/website-terms-and-conditions.php"><span class="s2">https://www.equitasbank.com/website-terms-and-conditions.php</span></a> INTERNET BANKING TERMS &amp; CONDITIONS:<a href="https://www.equitasbank.com/sites/default/files/inline-files/Digital-Internet-Banking-Terms-Conditions.pdf"><span class="s2">https://www.equitasbank.com/sites/default/files/inline-files/Digital-Internet-Banking-Terms-Conditions.pdf</span></a> MOBILE BANKING SERVICES TERMS &amp; CONDITIONS:<a href="https://www.equitasbank.com/sites/default/files/inline-files/Mobile-Banking-Terms-Conditions.pdf"><span class="s2">https://www.equitasbank.com/sites/default/files/inline-files/Mobile-Banking-Terms-Conditions.pdf </span></a>TERMS AND CONDITIONS GOVERNING UNIFIED PAYMENTS INTERFACE (UPI) SERVICES OF THE NATIONAL PAYMENT CORPORATION OF INDIA (NPCI):<a href="https://www.equitasbank.com/sites/default/files/inline-files/upi-terms-and-condition.pdf"><span class="s2">https://www.equitasbank.com/sites/default/files/inline-files/upi-terms-and-condition.pdf</span></a></span><span class="s4"> </span><span class="s1">ONLINE BILL PAYMENT TERMS AND CONDITIONS:<a href="https://www.equitasbank.com/sites/default/files/2020-11/Bill-Payment-Terms-Conditions.pdf"><span class="s2">https://www.equitasbank.com/sites/default/files/2020-11/Bill-Payment-Terms-Conditions.pdf </span></a></span><span class="s5">To </span><span class="s1">avail Direct Benefit Transfer" please convert your account to Fully KYC by visiting nearest branch.</span></p>
// <p class="p3"><span class="s1"></span><br></p>
// <p class="p4"><span class="s1">Aadhaar OTP will be triggered and customer will need to enter the same. The registered Mobile number with bank can be different from the Aadhaar.</span></p>
// </body>
// </html>
// ''',
       data.toString(),
          customStylesBuilder: (element) {
            if (element.classes.contains('foo')) {
              return {'color': 'red'};
            }

            return null;
          },
          customWidgetBuilder: (element) {
            // if (element.attributes['foo'] == 'bar') {
            //   // render a custom widget that takes the full width
            //   return FooBarWidget();
            // }

            // if (element.attributes['fizz'] == 'buzz') {
            //   // render a custom widget that inlines with surrounding text
            //   return InlineCustomWidget(
            //     child: FizzBuzzWidget(),
            //   )
            // }

            return null;
          },
          onTapUrl: (url) async {
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(
                Uri.parse(url),
              );
            }
            throw 'Could not launch $url';
          },
          renderMode: RenderMode.listView,
          textStyle: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
