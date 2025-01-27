import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keshav_s_application2/core/utils/size_utils.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';

class QuantityBottomSheet extends StatefulWidget {
  @override
  _QuantityBottomSheetState createState() => _QuantityBottomSheetState();
}

class _QuantityBottomSheetState extends State<QuantityBottomSheet> {
  int _selectedQuantity = 1;

  void _incrementQuantity() {
    setState(() {
      _selectedQuantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_selectedQuantity > 1) {
        _selectedQuantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Select Quantity',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _decrementQuantity,
              ),
              SizedBox(width: 16.0),
              Text(
                '$_selectedQuantity',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16.0),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _incrementQuantity,
              ),
            ],
          ),
          SizedBox(height: 0.0),
          CustomButton(
              onTap: () {
                if (_selectedQuantity == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 5.0),
                      dismissDirection: DismissDirection.none,
                      content: Text("Please select quantity"),
                      backgroundColor: Colors.redAccent));
                } else {
                  Navigator.pop(context, _selectedQuantity);
                }
              },
              height: getVerticalSize(35),
              text: "lbl_add_to_cart".tr,
              margin: getMargin(left: 10, top: 14, right: 10),
              variant: ButtonVariant.FillPurple900,
              shape: ButtonShape.Square,
              fontStyle: ButtonFontStyle.RobotoMedium16),
          // SizedBox(height: 10.0),
          // ElevatedButton(
          //   onPressed: () {
          //     // You can handle the selected quantity here
          //     Navigator.pop(context, _selectedQuantity);
          //   },
          //   child: Text('Add to Cart'),
          // ),
        ],
      ),
    );
  }
}
