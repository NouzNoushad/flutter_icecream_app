import 'package:flutter/material.dart';
import 'package:flutter_icecream_ui/home_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'model/db.dart';

class IceCreamCart extends StatefulWidget {
  const IceCreamCart({Key? key}) : super(key: key);

  @override
  State<IceCreamCart> createState() => _IceCreamCartState();
}

class _IceCreamCartState extends State<IceCreamCart> {
  Color lightColor = const Color.fromARGB(255, 253, 222, 231);
  Color darkColor = const Color.fromARGB(255, 219, 120, 148);

  Db database = Db();
  List<Map> iceCreamList = [];

  @override
  void initState() {
    database.open();
    getIceCreamData();
    super.initState();
  }

  void getIceCreamData() {
    Future.delayed(const Duration(seconds: 1), () async {
      iceCreamList = await database.db!.rawQuery("SELECT * FROM iceCreams");
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num total = iceCreamList.fold(0.0, (prev, value) => prev + value["price"]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                cartAppBar(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 440,
                  // color: Colors.yellow,
                  child: ListView(
                    children: iceCreamList.map((iceCream) {
                      // Flutter package slidable used to delete data
                      return Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            extentRatio: 0.3,
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  await database.db!.rawDelete(
                                      "DELETE FROM iceCreams WHERE id = ?",
                                      [iceCream["id"]]);
                                  // pop up message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        "Tasty ice cream removed from the Cart",
                                        style: TextStyle(
                                          color: Colors.pink,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                  );
                                  getIceCreamData();
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                foregroundColor: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ],
                          ),
                          child: iceCreamCartDetails(iceCream));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "\$$total",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iceCreamCartDetails(Map<dynamic, dynamic> iceCream) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(iceCream[
                        "lightColor"]), // => Read Color which we saved as integer
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage('assets/${iceCream["image"]}'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          iceCream["flavour"],
                          style: TextStyle(
                            color: Color(iceCream['darkColor']),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Ice Cream",
                          style: TextStyle(
                            color: Color(iceCream['darkColor']),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${iceCream["price"]}",
                      style: TextStyle(
                        color: Color(iceCream['darkColor']),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 28,
                  width: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(iceCream["darkColor"]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Color(iceCream["lightColor"]),
                  ),
                ),
                Text(
                  "${iceCream["count"]}",
                  style: TextStyle(
                    color: Color(iceCream["darkColor"]),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 28,
                  width: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(iceCream["lightColor"]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Color(iceCream["darkColor"]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cartAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: darkColor,
                ),
              ),
            ),
          ),
          const Text(
            "Your Cart",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.pink,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
        ],
      );
}
