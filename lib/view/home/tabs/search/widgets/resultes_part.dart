import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';

class ResultesPart extends StatelessWidget {
  const ResultesPart({super.key, required this.testTmage});
  final String testTmage; 

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(25),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: 200,
              childAspectRatio: 0.54,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (_, i) => ProductCard(
              title: 'Just A Test Product Title',
              imagePath: testTmage,
              price: 15,
              colorsNumber: 3,
            ),
          ),
        )
      ],
    );
  }
}
