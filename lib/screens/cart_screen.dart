// Framework & Standard Libraries
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
// Avoid importing CartItem class from provider as it collides with widget class
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';

// Widgets
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color)),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      'Order Now!',
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, idx) => CartItem(
                  id: cart.items.values.toList()[idx].id,
                  price: cart.items.values.toList()[idx].price,
                  quantity: cart.items.values.toList()[idx].quantity,
                  title: cart.items.values.toList()[idx].title,
                  remove: () {
                    cart.removeItem(cart.items.keys.toList()[idx]);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
