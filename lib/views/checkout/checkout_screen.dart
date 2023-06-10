// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/components/custom_button.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/views/cart/components/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Auth/auth_helper.dart';
import '../../components/cart_widget.dart';
import '../../data_reposotries/fire_store_helper.dart';
import '../../provider/cart_provider.dart';

late num totalPrice;

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Razorpay _razorPay;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorPay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    log('Payment success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    log(response.error.toString());
    log('Payment error');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    log('External wallet');
  }

  void openCheckout() async {
    log((num.parse(totalPrice.toString()) * 100).toString());
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': 500,
      'name': 'user ',
      'description': 'payment for some random product',
      'prefill': {'contact': '8888888888', 'email': 'user@gmail.com'},
      'external': {
        'wallet': ['paytm']
      }
    };
    try {
      _razorPay.open(options);
    } on Exception catch (e) {
      // TODO
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MyProvider>(context).getCurrentUserData();
    String name = Provider.of<MyProvider>(context).loggingUser.fullName;
    String email = Provider.of<MyProvider>(context).loggingUser.emailAddress;

    Provider.of<CartProvider>(context).getCartData();
    num calcToal = Provider.of<CartProvider>(context).calcTotal();
    num discount = 5;
    int shipping = 10;
    num dicountValue = (calcToal * discount) / 100;
    num value = calcToal - dicountValue;
    totalPrice = value + shipping;
    // log('totalprice = ' + totalPrice.toString());
    if (Provider.of<CartProvider>(context).cartList.isEmpty) {
      setState(() {
        totalPrice = 0.0;
      });
    }
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Check out',
            style: TextStyle(
              color: AppColors.kblackColor,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: Consumer<CartProvider>(
                builder: (context, provider, child) {
                  return provider.cartList.isEmpty
                      ? Center(
                          child: Text('No Product Yet'),
                        )
                      : ListView.builder(
                          itemCount: provider.getCartList().length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Dismissible(
                              key: Key(provider.cartList[index].productId
                                  .toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                Provider.of<MyProvider>(context, listen: false)
                                    .deleteItemFromCart(
                                        provider.cartList[index].productId);
                              },
                              background: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFE6E6),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    SvgPicture.asset("assets/icons/Trash.svg"),
                                  ],
                                ),
                              ),
                              child: CartCard(cart: provider.cartList[index]),
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          // Expanded(
          //   child: Consumer<CartProvider>(
          //     builder: (context, provider, w) {
          //       return provider.cartList.isEmpty
          //           ? Center(
          //               child: Text('No Product Yet'),
          //             )
          //           : ListView.builder(
          //               physics: BouncingScrollPhysics(),
          //               itemBuilder: (context, index) {
          //                 var data = provider.cartList[index];
          //                 return CartCard(
          //                   cart: data,
          //                 );
          //               },
          //               itemCount: provider.getCartList().length,
          //             );
          //     },
          //   ),
          // ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: Text(
                    '\$ $calcToal',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Discount',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: Text(
                    '%5',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Shiping',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: Text(
                    '\$10',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: Text(
                    '\$ $totalPrice',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                ),
                Provider.of<CartProvider>(context).cartList.isEmpty
                    ? Text('')
                    : CustomButton(
                        function: () {
                          openCheckout();
                        },
                        text: "Buy")
              ],
            ),
          ))
        ],
      ),
    );
  }
}
