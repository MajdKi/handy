import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testtest/core/constant/app_colors.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/remote/pay_for_products.dart';

// ignore: must_be_immutable

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard(
      {Key? key,
      required this.desc,
      required this.price,
      required this.rate,
      required this.stock,
      required this.title,
      required this.urlimage,
      required this.id})
      : super(key: key);
  String title, desc, rate, stock, price, urlimage;
  int id;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int itemcount = 1;

  bool isloading = false;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int finalprice = itemcount * int.parse(widget.price);

        showDialog(
          context: context,
          builder: (context) {
            controller.text = itemcount.toString();
            return Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 220),
              alignment: Alignment.center,
              child: StatefulBuilder(builder: (context, setState) {
                return isloading == false
                    ? Center(
                        child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Select quantity for ${widget.title}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(90),
                                        color: AppColors.mainColor),
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          if (itemcount == 1) {
                                          } else {
                                            itemcount--;
                                            controller.text =
                                                itemcount.toString();
                                            finalprice = itemcount *
                                                int.parse(widget.price);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      enabled: false,
                                      controller: controller,
                                      style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 24),
                                      decoration: InputDecoration(
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                color: AppColors.mainColor,
                                                width: 4)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(90),
                                        color: AppColors.mainColor),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        itemcount++;

                                        setState(() {
                                          controller.text =
                                              itemcount.toString();
                                          finalprice = itemcount *
                                              int.parse(widget.price);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          GestureDetector(
                            onTap: () async {
                              final storage = new FlutterSecureStorage();

                              String? stringValue =
                                  await storage.read(key: 'token');
                              isloading = true;
                              setState(() {});
                              dynamic payurl = await payforproducts(
                                  amount: int.parse(widget.price),
                                  id: widget.id,
                                  name: widget.title,
                                  quantity: itemcount,
                                  type: 'product',
                                  url: 'https://handyclose.com/api/Payment',
                                  token: stringValue!);
                              await launchUrl(Uri.parse(payurl as String));
                              isloading = false;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.all(30),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.mainColor),
                              child: const Text(
                                "Buy",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Price: " + finalprice.toString() + "\$",
                              style: const TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }),
            );
          },
        );
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        margin: const EdgeInsets.all(12),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: FadeInImage(
                        image: NetworkImage(widget.urlimage),
                        placeholder:
                            const AssetImage("assets/images/Placeholder.png"),
                      )),
                  Positioned(
                      top: 10,
                      right: 0,
                      child: Container(
                        width: 70,
                        height: 35,
                        decoration: const BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.rate,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ))
                ]),
                const SizedBox(
                  height: 35,
                ),
                Text(' ${widget.title}', style: const TextStyle(fontSize: 20)),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 30,
                  child: Marquee(
                    text: widget.desc + " ",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Text("Price: ${widget.price}\$",
                    style: const TextStyle(fontSize: 20)),
                Text("In stock: ${widget.stock}",
                    style: const TextStyle(fontSize: 20))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
Text(
                desc,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20),
                maxLines: 2,
              ),
*/