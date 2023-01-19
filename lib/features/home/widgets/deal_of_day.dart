import 'package:amazon_clone/constants/global_variables.dart';
import "package:flutter/material.dart";

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              left: 10,
              top: 15,
            ),
            child: const Text(
              "Deal of the day",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Image.network(
            "https://images.unsplash.com/photo-1468436139062-f60a71c5c892?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NXwyMzA1MTF8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: const Text(
              "\$999",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              left: 15,
              top: 5,
              right: 40,
            ),
            child: Text(
              "Dhruv",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1468436139062-f60a71c5c892?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NXwyMzA1MTF8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1468436139062-f60a71c5c892?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NXwyMzA1MTF8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1468436139062-f60a71c5c892?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NXwyMzA1MTF8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1468436139062-f60a71c5c892?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NXwyMzA1MTF8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 15,
              top: 15,
              bottom: 15,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              "See all deals",
              style: TextStyle(color: Colors.cyan.shade800),
            ),
          )
        ],
      ),
    );
  }
}
