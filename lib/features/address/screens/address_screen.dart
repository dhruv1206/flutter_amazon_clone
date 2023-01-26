// ignore_for_file: deprecated_member_use

import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import "package:flutter/material.dart";
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone/providers/user_provider.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = "/address-screen";
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final addressServices = AddressServices();

  final _addressFormKey = GlobalKey<FormState>();
  final _flatBuildingController = TextEditingController();
  final _areaController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _cityController = TextEditingController();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context,
      addressToBeUsed,
      double.parse(widget.totalAmount),
    );
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context,
      addressToBeUsed,
      double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pincodeController.text}";
      } else {
        throw Exception("Please enter all the values!");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context: context, message: "ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context
        .watch<UserProvider>()
        .user
        .address; //Provider.of<UserProvider>(context).user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _flatBuildingController,
                      hintText: "Flat, House no, Building",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _areaController,
                      hintText: "Area, Street",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _pincodeController,
                      hintText: "Pincode",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _cityController,
                      hintText: "Town/City",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              GooglePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                paymentConfigurationAsset: "gpay.json",
                height: 50,
                margin: const EdgeInsets.only(top: 15),
                paymentItems: paymentItems,
                type: GooglePayButtonType.buy,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPaymentResult: onGooglePayResult,
              ),
              const SizedBox(
                height: 10,
              ),
              ApplePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                paymentConfigurationAsset: "applepay.json",
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItems,
                margin: const EdgeInsets.only(top: 15),
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
