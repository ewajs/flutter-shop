// Framework & Standard Libraries
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/orders.dart' show Orders;

// Widgets
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Provider.of<Orders>(context, listen: false)
        .fetchAndSetOrders()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.orders.length,
              itemBuilder: (ctx, i) => OrderItem(orders.orders[i]),
            ),
      drawer: AppDrawer(),
    );
  }
}
