import 'package:flutter/material.dart';
import 'package:testtest/data/remote/get_history.dart';
import 'package:testtest/views/widgets/history_card.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  TextStyle textStyle = const TextStyle(fontSize: 24, color: Colors.white);

  GlobalKey<FormState> formkey = GlobalKey();

  int? accountnum;

  double? amount;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getHistory(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: HistoryCard(
                            date: DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(
                                    snapshot.data[index]['date']))
                                .toString(),
                            name: snapshot.data[index]['name'],
                            quantity:
                                snapshot.data[index]['quantity'].toString(),
                            state: snapshot.data[index]['state'],
                            totalPrice:
                                snapshot.data[index]['totalPrice'].toString()),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }
}


// return ModalProgressHUD(
//       inAsyncCall: isloading,
//       child: Scaffold(
//         backgroundColor: AppColors.mainColor,
//         body: Form(
//           key: formkey,
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Transfer Money",
//               style: textStyle,
//             ),
//             const Spacer(
//               flex: 1,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Enter the account number",
//               style: textStyle,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 40),
//               child: TextFormField(
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   accountnum = int.parse(value);
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'This field is requierd';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                     fillColor: Colors.white, filled: true),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Text(
//               "Enter the amount you want to pay",
//               style: textStyle,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 40),
//               child: TextFormField(
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   amount = double.parse(value);
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'This field is requierd';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     prefixIcon: Column(
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         FaIcon(FontAwesomeIcons.dollarSign),
//                       ],
//                     )),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               onTap: () async {
//                 if (formkey.currentState!.validate()) {
//                   isloading = true;
//                   setState(() {});
//                   SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   String? stringValue = prefs.getString('token');
//                   dynamic payurl = await payfortransfer(
//                       accountid: accountnum!,
//                       type: "transfer",
//                       amount: amount!,
//                       token: stringValue!,
//                       url: "https://handyclose.com/api/Payment");
//                   await launchUrl(Uri.parse(payurl as String));
//                   isloading = false;
//                   setState(() {});
//                 }
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(40)),
//                 child: const Text(
//                   "Submit",
//                   style: TextStyle(
//                       fontSize: 35,
//                       color: AppColors.mainColor,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             const Spacer(
//               flex: 3,
//             ),
//           ]),
//         ),
//       ),
//     );