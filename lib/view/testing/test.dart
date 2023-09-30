import 'package:aissam_store/models/category.dart';
import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/widgets/categorie_item.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:aissam_store/view/public/button/button.dart';
import 'package:aissam_store/view/public/button/button_color_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     body: Wrap(
      //   children: List.generate(
      //     50,
      //     (index) => index.isEven
      //         ? ButtonColorBuilder(
      //             color: Colors.green,
      //             builder: (c) => SizedBox.square(
      //               dimension: 100,
      //               child: ColoredBox(
      //                 color: c,
      //                 child: Center(
      //                   child: Text(index.toString()),
      //                 ),
      //               ),
      //             ),
      //           )
      //         : ButtonScaleBuilder(
      //             builder: () => SizedBox.square(
      //               dimension: 100,
      //               child: ColoredBox(
      //                 color: Colors.blue,
      //                 child: Center(
      //                   child: Text(index.toString()),
      //                 ),
      //               ),
      //             ),
      //           ),
      //   ),
      // ));
      body: ListView(
        padding: const EdgeInsets.all(35.0),
        children: [
          Button(
            isHeightMinimize: true,
            // isOutline: true,
            // onPressed: Get.back,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Save",
                  style: Get.textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/ic_fluent_checkmark_24_filled.svg',
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CategorieItem(
            onCheck: (e) {
              print('clickeeed: $e');
            },
            data: Category(
                name: 'No Name', color: Colors.red, imageUrl: 'No ImGE'),
          ),
          SizedBox(
            height: 15,
          ),
          ProductCard(data: Product.testModel()),
          SizedBox(
            height: 15,
          ),
          ButtonColorBuilder(
            color: Colors.green,
            onTap: () {
              print('Butt1');
            },
            builder: (c, f) {
              return SizedBox.square(
                dimension: 100,
                child: ColoredBox(
                  color: c,
                  child: Center(
                    child: ButtonColorBuilder(
                        onTap: () {
                          print('Butt2');
                        },
                        color: Colors.blue,
                        builder: (c2, f2) {
                          return SizedBox.square(
                            dimension: 50,
                            child: ColoredBox(color: c2),
                          );
                        }),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
