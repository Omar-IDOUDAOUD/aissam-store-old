// import 'package:aissam_store/controller/product.dart';
// import 'package:aissam_store/core/constants/colors.dart';
// import 'package:aissam_store/core/shared/products_collections.dart';

// import 'package:aissam_store/models/product.dart';
// import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
// import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   final ProductsController _productsController = ProductsController.instance;

//   late final ScrollController _newestProductsController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _newestProductsController = ScrollController()
//       ..addListener(() {
//         if (_productsController.canLoadMoreData &&
//             _canRequestData &&
//             _newestProductsController.offset >=
//                 _newestProductsController.position.maxScrollExtent - 150) {
//           print('hhhhhhhhhh');
//           _canRequestData = false;
//           setState(() {});
//         }
//       });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _newestProductsController.dispose();
//     super.dispose();
//   }

//   bool _canRequestData = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder<List<Product>>(
//               initialData: _productsController.loadedData,
//               future: _productsController.paginatedProducts(ProductsCollections.BestSelling)..then((value) {
//                 _canRequestData = true;
//               }),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) return Text('An error occurred!');
//                 return ListView.separated(
//                   controller: _newestProductsController,
//                   itemCount: snapshot.data!.length +
//                       (_productsController.canLoadMoreData &&
//                               snapshot.connectionState ==
//                                   ConnectionState.waiting
//                           ? 3
//                           : 0),
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (_, i) {
//                     if (i >= snapshot.data!.length) return LoadingProductCard();
//                     return ProductCard(
//                       data: snapshot.data!.elementAt(i),
//                     );
//                   },
//                   separatorBuilder: (_, i) => SizedBox(
//                     width: 10,
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: IconButton(
//                 icon: Icon(Icons.add_circle_outlined),
//                 onPressed: () async {
//                   await _productsController.addTestProduct();
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class ColoRHEXTEXT extends StatelessWidget {
// //   const ColoRHEXTEXT({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     Color color = CstColors.a;

// //     String hexColor = color.value.toRadixString(16).toUpperCase().substring(2);

// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: <Widget>[
// //         Container(
// //           width: 100,
// //           height: 100,
// //           color: color,
// //         ),
// //         SizedBox(height: 20),
// //         Text(
// //           'Hexadecimal: #$hexColor',
// //           style: TextStyle(fontSize: 18),
// //         ),
// //       ],
// //     );
// //   }
// // }
