import "package:amazon_clone/features/admin/models/sales.dart";
import "package:amazon_clone/features/admin/services/admin_services.dart";
import "package:amazon_clone/features/admin/widgets/category_product_chart.dart";
import "package:charts_flutter_new/flutter.dart" as Charts;
import "package:flutter/material.dart";

import "../../../common/widgets/loader.dart";

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData["totalEarnings"];
    earnings = earningData["sales"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(
                  seriesList: [
                    Charts.Series(
                      id: "Sales",
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
