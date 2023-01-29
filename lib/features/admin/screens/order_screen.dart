import "package:amazon_clone/common/widgets/loader.dart";
import "package:amazon_clone/features/accounts/widgets/single_product.dart";
import "package:amazon_clone/features/admin/services/admin_services.dart";
import "package:amazon_clone/features/order_details/screens/order_detail_screen.dart";
import "package:flutter/material.dart";

import "../../../models/order.dart";

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final adminServices = AdminServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  void fetchAllOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  OrderDetailScreen.routeName,
                  arguments: orderData,
                ),
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: orderData.products[0].images[0],
                  ),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          );
  }
}
