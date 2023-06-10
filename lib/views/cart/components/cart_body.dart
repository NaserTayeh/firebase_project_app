import 'package:final_project_firebase/views/cart/components/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../model/cart_m.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/my_provider.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  Widget build(BuildContext context) {
    Provider.of<CartProvider>(context).getCartData();

    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Padding(
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
                      key: Key(provider.cartList[index].productId.toString()),
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
    );
  }
}
