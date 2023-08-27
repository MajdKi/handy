import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testtest/core/class/models/product.dart';
import '../../../controller/select_cat_controller.dart';
import '../../../data/remote/get_products_by_category.dart';
import '../../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final selectCatController = Get.put(SelectCatController());

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${selectCatController.cat.toString()[0].toUpperCase()}${selectCatController.cat.toString().substring(1)} Products'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
          future: getProductsByCat(selectCatController.cat.value),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ProductCard(
                        desc: snapshot.data[index].description,
                        title: snapshot.data[index].title,
                        price: snapshot.data[index].price.toString(),
                        stock: snapshot.data[index].stock.toString(),
                        rate: snapshot.data[index].rating.toString(),
                        urlimage: snapshot.data[index].images,
                        id: snapshot.data[index].id,
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
