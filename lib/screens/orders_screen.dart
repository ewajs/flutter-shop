// 3rd Party Package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/orders.dart' show Orders;

// Widgets
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orders.orders[i]),
      ),
      drawer: AppDrawer(),
    );
  }
}
