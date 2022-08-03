import 'package:flutter/material.dart';
import 'package:flutter_icecream_ui/model/ice_cream.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'ice_cart.dart';
import 'ice_details.dart';

class IceCreamHomePage extends StatefulWidget {
  const IceCreamHomePage({Key? key}) : super(key: key);

  @override
  State<IceCreamHomePage> createState() => _IceCreamHomePageState();
}

class _IceCreamHomePageState extends State<IceCreamHomePage> {
  Color lightColor = const Color.fromARGB(255, 253, 222, 231);
  Color darkColor = const Color.fromARGB(255, 219, 120, 148);

  List<Map<String, dynamic>> types = [
    {
      "icon": Icons.icecream,
      "label": "Cones",
    },
    {
      "icon": Icons.cake,
      "label": "Cake",
    },
    {
      "icon": Icons.coffee,
      "label": "Cup",
    },
    {
      "icon": Icons.fastfood,
      "label": "Food",
    },
  ];

  List<IceCream> iceCreams = IceCreamList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2 - 70,
              // color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iceCreamAppBar(),
                  searchContainer(),
                  icyListView(),
                  const Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
          ),
          popularIceCreams(),
        ],
      ),
    );
  }

  Widget popularIceCreams() => Container(
        height: 280,
        // color: Colors.yellow,
        margin: const EdgeInsets.only(left: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: iceCreams.length,
          itemBuilder: (context, index) {
            final iceCream = iceCreams[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          IceCreamDetails(iceCream: iceCream)),
                );
              },
              child: Container(
                height: 280,
                width: 230,
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: iceCream.lightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        // color: Colors.yellow,
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/${iceCream.image}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      iceCream.flavor,
                      style: TextStyle(
                        color: iceCream.darkColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Flutter package - flutter_rating_bar
                        RatingBar.builder(
                          itemCount: 5,
                          itemSize: 18,
                          initialRating: iceCream.rating,
                          allowHalfRating: true,
                          itemBuilder: (context, _) {
                            return Icon(
                              Icons.star_rounded,
                              color: iceCream.darkColor,
                            );
                          },
                          onRatingUpdate: (rating) {
                            setState(() {
                              iceCream.rating = rating;
                            });
                          },
                        ),
                        Text(
                          "\$${iceCream.price}",
                          style: TextStyle(
                            color: iceCream.darkColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget icyListView() => Container(
        height: 90,
        // color: Colors.yellow,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: types.length,
          itemBuilder: (context, index) {
            final type = types[index];
            return Container(
              width: 60,
              // color: Colors.yellow,
              margin: const EdgeInsets.only(right: 23),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      type["icon"],
                      size: 28,
                      color: darkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    type["label"],
                    style: TextStyle(
                      color: darkColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

  Widget searchContainer() => Container(
        height: 44,
        decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          cursorColor: darkColor,
          style: TextStyle(
            color: darkColor,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: darkColor),
              hintText: "Search Your Ice Cream",
              hintStyle: TextStyle(
                color: darkColor,
                fontSize: 13,
              ),
              suffixIcon: Container(
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.icecream,
                  color: Colors.white,
                ),
              )),
        ),
      );

  Widget iceCreamAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.menu,
              color: darkColor,
            ),
          ),
          const Text(
            "Explore Our \nFlavours",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.pink,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const IceCreamCart()),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: darkColor,
              ),
            ),
          ),
        ],
      );
}
