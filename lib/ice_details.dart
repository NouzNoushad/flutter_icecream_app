import 'package:flutter/material.dart';
import 'package:flutter_icecream_ui/model/ice_cream.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'model/db.dart';

class IceCreamDetails extends StatefulWidget {
  final IceCream iceCream;
  const IceCreamDetails({Key? key, required this.iceCream}) : super(key: key);

  @override
  State<IceCreamDetails> createState() => _IceCreamDetailsState();
}

class _IceCreamDetailsState extends State<IceCreamDetails> {
  bool isFavorite = false;
  Db database = Db();
  @override
  void initState() {
    database.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              height: height / 2 + 55,
              color: widget.iceCream.lightColor,
              child: Image.asset("assets/${widget.iceCream.image}"),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.only(left: 6),
                  decoration: BoxDecoration(
                    color: widget.iceCream.darkColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: widget.iceCream.lightColor,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: height / 2 - 30,
                width: width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: iceCreamDetails(),
              ),
            ),
            Positioned(
              top: height / 2 - 20,
              right: 20,
              child: Container(
                height: 108,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.iceCream.count++;
                        });
                      },
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: widget.iceCream.darkColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add,
                          color: widget.iceCream.lightColor,
                        ),
                      ),
                    ),
                    Text(
                      "${widget.iceCream.count}",
                      style: TextStyle(
                        color: widget.iceCream.darkColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.iceCream.count < 1) {
                            widget.iceCream.count = 1;
                          }
                          widget.iceCream.count--;
                        });
                      },
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: widget.iceCream.lightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: widget.iceCream.darkColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iceCreamDetails() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.iceCream.flavor,
                style: TextStyle(
                  color: widget.iceCream.darkColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                "Ice Cream",
                style: TextStyle(
                  color: widget.iceCream.darkColor.withOpacity(0.5),
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Flutter package - flutter_rating_bar
                  RatingBar.builder(
                    itemCount: 5,
                    itemSize: 22,
                    initialRating: widget.iceCream.rating,
                    unratedColor: widget.iceCream.darkColor.withOpacity(0.3),
                    allowHalfRating: true,
                    itemBuilder: (context, _) {
                      return Icon(
                        Icons.star_rounded,
                        color: widget.iceCream.darkColor,
                      );
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        widget.iceCream.rating = rating;
                      });
                    },
                  ),
                  Text(
                    "\$${widget.iceCream.price}",
                    style: TextStyle(
                      color: widget.iceCream.darkColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Cold Creamy Ice Cream, like other flavor of ice cream, was originally created by cooling a mixture made of cream, sugar and color...",
            style: TextStyle(
              color: widget.iceCream.darkColor.withOpacity(0.5),
              fontSize: 15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.iceCream.darkColor,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.amber : Colors.white,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 240,
                child: ElevatedButton(
                  onPressed: () async {
                    // insert icecream data into database
                    await database.db!.rawInsert(
                        "INSERT INTO iceCreams (flavour, image, price, count, lightColor, darkColor) VALUES (?, ?, ?, ?, ?, ?);",
                        [
                          widget.iceCream.flavor,
                          widget.iceCream.image,
                          widget.iceCream.price,
                          widget.iceCream.count,
                          widget.iceCream.lightColor
                              .value, // save color as integer
                          widget.iceCream.darkColor.value, // color as integer
                        ]);

                    // Popup message using snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.white,
                        content: Text(
                          'Ice Cream Added to the Cart',
                          style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: widget.iceCream.darkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Add To Cart",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
