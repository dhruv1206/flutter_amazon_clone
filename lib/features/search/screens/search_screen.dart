// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/services/search_sevices.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:amazon_clone/models/products.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import '../../../constants/global_variables.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search-screen";
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final searchServices = SearchServices();
  @override
  void initState() {
    super.initState();
    searchProducts();
  }

  Future<void> searchProducts() async {
    products = await searchServices.fetchSearchedProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        if (value.trim() == "") {
                          return;
                        }
                        Navigator.of(context).pushNamed(SearchScreen.routeName,
                            arguments: value);
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z_ ]"))
                      ],
                      decoration: InputDecoration(
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 23,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      double totalRating = 0;
                      double avgRating = 0;
                      for (var i in products![index].rating!) {
                        totalRating += i.rating;
                      }
                      if (totalRating != 0) {
                        avgRating =
                            totalRating / products![index].rating!.length;
                      }
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          ProductDetailsScreen.routeName,
                          arguments: products![index],
                        ),
                        child: SearchedProduct(
                          product: products![index],
                          rating: avgRating,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
