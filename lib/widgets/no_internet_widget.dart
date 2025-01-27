

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keshav_s_application2/widgets/Strings.dart';
import 'package:keshav_s_application2/widgets/icons.dart';
import 'package:keshav_s_application2/widgets/no_internet.dart';
import 'package:provider/src/provider.dart';

import 'navigationbarprovider.dart';



class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  _NoInternetWidgetState createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (mounted) {
        if (!context
            .read<NavigationBarProvider>()
            .animationController
            .isAnimating) {
          context.read<NavigationBarProvider>().animationController.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            Theme.of(context).colorScheme.noInternetIcon,
            height: 100,
            width: 100,
          ),
          Text(
            CustomStrings.noInternet1,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          Text(
            CustomStrings.noInternet2,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          _isLoading
              ? CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )
              : TextButton(
            child: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).cardColor, backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });

              Future.delayed(const Duration(seconds: 3), () {
                NoInternet.initConnectivity();
                setState(() {
                  _isLoading = false;
                });
              });
            },
          )
        ],
      ),
    );
  }
}