import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HistoryCard extends StatelessWidget {
  String name;
  String date;
  String state;
  String quantity;
  String totalPrice;
  HistoryCard(
      {required this.date,
      required this.name,
      required this.quantity,
      required this.state,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              "Name : $name",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Date : $date",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "State : $state",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Quantity : $quantity",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Total Price : $totalPrice",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
