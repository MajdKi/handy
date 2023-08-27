import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:testtest/core/constant/app_colors.dart';
import 'package:testtest/data/remote/pay_for_bills.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controller/select_cat_controller.dart';

// ignore: must_be_immutable
class BillPayment extends StatefulWidget {
  const BillPayment({Key? key}) : super(key: key);

  @override
  State<BillPayment> createState() => _BillPaymentState();
}

class _BillPaymentState extends State<BillPayment> {
  TextStyle textStyle = const TextStyle(fontSize: 24, color: Colors.white);

  final selectCatController1 = Get.put(SelectCatController2());

  int? lastid;

  double? amount;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Form(
          key: formkey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Spacer(
              flex: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${selectCatController1.cat2} Bill Payment",
              style: textStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Please enter your last bill id",
              style: textStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is requierd';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  lastid = int.parse(value);
                },
                decoration: const InputDecoration(
                    fillColor: Colors.white, filled: true),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Please enter the amount you want to pay",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is requierd';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  amount = double.parse(value);
                },
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        FaIcon(FontAwesomeIcons.dollarSign),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                if (formkey.currentState!.validate()) {
                  isloading = true;
                  setState(() {});
                  final storage = new FlutterSecureStorage();

                  String? stringValue = await storage.read(key: 'token');
                  dynamic payurl = await payforbills(
                      lastid: lastid!,
                      type: 'bills',
                      amount: amount,
                      name: selectCatController1.cat2.toString(),
                      token: stringValue!,
                      url: 'https://handyclose.com/api/Payment');
                  await launchUrl(Uri.parse(payurl as String));
                  isloading = false;
                  setState(() {});
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 35,
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Spacer(
              flex: 3,
            ),
          ]),
        ),
      ),
    );
  }
}
