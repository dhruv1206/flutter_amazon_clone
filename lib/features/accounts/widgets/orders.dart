import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextButton(
                child: Text(
                  "See all",
                  style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        //display orders
        Container(
          height: 150,
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const SingleProduct(
                  image:
                      "https://images.unsplash.com/photo-1661961112951-f2bfd1f253ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60");
            },
          ),
        ),
      ],
    );
  }
}
