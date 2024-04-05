// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:provider/provider.dart';
// import 'package:sdk_09_2021_e_commerce/Utils/router/route_constant.dart';
// import 'package:sdk_09_2021_e_commerce/Utils/theme_manager.dart';
// import 'package:sdk_09_2021_e_commerce/core/Model/product_model.dart';
// import 'package:sdk_09_2021_e_commerce/core/Provider/prodect_provider.dart';
//
// import 'product_item_view.dart';
//
// class ProductMainScreen extends StatefulWidget {
//   const ProductMainScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProductMainScreen> createState() => _ProductMainScreenState();
// }
//
// class _ProductMainScreenState extends State<ProductMainScreen> {
//   ProductList? productsList;
//   @override
//   Widget build(BuildContext context) {
//     var productProvider = Provider.of<ProductProvider>(context);
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           child: Icon(
//             Icons.add,
//             color: Colors.black,
//           ),
//           foregroundColor: ThemeManager.lightAccent,
//           onPressed: () {
//             Navigator.of(context).pushNamed(adminProductAddRoute);
//           },
//         ),
//         body: FutureBuilder(
//           future: productProvider.products,
//           builder: (context, snapshot) {
//             var data = snapshot.data;
//             if (data == null) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             productsList = data as ProductList;
//             return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: ListView.builder(
//                 itemCount: productsList!.products.length,
//                 itemBuilder: (context, index) => Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: Slidable(
//                     key: ValueKey(index),
//                     /*endActionPane: ActionPane(
//                 motion: ScrollMotion(),
//                 extentRatio: 0.22,
//                 children: [
//                   SlidableAction(
//                       icon: Icons.restore_from_trash_outlined,
//                       backgroundColor: ThemeManager.badgeColor,
//                       onPressed: (context) {
//                         //Deleting User Account
//                       }),
//                 ],
//               ),*/
//                     startActionPane: ActionPane(
//                       motion: ScrollMotion(),
//                       extentRatio: 0.22,
//                       children: [
//                         SlidableAction(
//                             icon: Icons.restore_from_trash_outlined,
//                             backgroundColor: ThemeManager.badgeColor,
//                             onPressed: (context) {
//                               productProvider.deleteProduct(productsList!.products[index].id!);
//                             }),
//                       ],
//                     ),
//                     child: ProductItemView(productModel: productsList!.products[index]),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:turathi/core/services/test_service.dart';

import 'core/models/testModel.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  TestList? testList;

  @override
  Widget build(BuildContext context) {
    TestService service = TestService();
    return Scaffold(
      appBar: AppBar(
      ),
        body: FutureBuilder(
      future: service.getTests(),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        testList = data as TestList;
        if (testList!.tests.isEmpty) {
          return Align(
            alignment: Alignment.center,
            child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: 'OOPS\n',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: 'No Items in current time\n',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Add Item',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            )
                          ])
                    ])),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: testList!.tests.length,
            itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                    "${testList!.tests[index].title} and ${testList!.tests[index].num}")),
          ),
        );
      },
    ));
  }
}
