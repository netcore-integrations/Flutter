import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class CustomPhoneNumber extends StatelessWidget {
  CustomPhoneNumber({this.country, this.onTap, this.controller});

  Country? country;

  Function(Country)? onTap;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _openCountryPicker(context);
          },
          child: Padding(
            padding: getPadding(
              left: 1,
              top: 260,
              bottom: 4,
            ),
            child: Text(
              "+${country!.phoneCode}",
              style: AppStyle.txtRobotoRegular12,
            ),
          ),
        ),
        Container(
          height: getVerticalSize(
            19,
          ),
          width: getHorizontalSize(
            1,
          ),
          margin: getMargin(
            left: 8,
            top: 259,
            bottom: 1,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.gray50001,
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            width: getHorizontalSize(
              367,
            ),
            focusNode: FocusNode(),
            controller: controller!,
            hintText: "99299 99899",
            margin: getMargin(
              left: 6,
              top: 260,
            ),
            variant: TextFormFieldVariant.UnderLineGray50001,
            fontStyle: TextFormFieldFontStyle.RobotoRegular12Black900,
          ),
        ),
      ],
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: EdgeInsets.only(
              left: getHorizontalSize(10),
            ),
            width: getHorizontalSize(60.0),
            child: Text(
              "+${country.phoneCode}",
              style: TextStyle(fontSize: getFontSize(14)),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: TextStyle(fontSize: getFontSize(14)),
            ),
          ),
        ],
      );
  void _openCountryPicker(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchInputDecoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: getFontSize(14)),
          ),
          isSearchable: true,
          title: Text('Select your phone code',
              style: TextStyle(fontSize: getFontSize(14))),
          onValuePicked: (Country country) => onTap!(country),
          itemBuilder: _buildDialogItem,
        ),
      );
}
