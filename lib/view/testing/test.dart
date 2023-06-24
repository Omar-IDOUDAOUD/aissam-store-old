import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      body: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 50,
          //     width: 100,
          //     child: ColoredBox(
          //       color: Colors.red,
          //     ),
          //   ),
          // ),
          const SliverAppBar(
            expandedHeight: 100,
            backgroundColor: Colors.purple,
            elevation: 10,
            pinned: false,
            floating: true,
            centerTitle: true,
            title: Text('data'),
            collapsedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: ColoredBox(
                color: Colors.blue,
                child: Text("A Flexible title"),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              width: 100,
              child: ColoredBox(
                color: Colors.black,
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: ph(),
            pinned: true,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                return SizedBox(
                  height: 100,
                  width: Get.size.width,
                  child: ColoredBox(
                    color: Colors.accents.elementAt(i),
                  ),
                );
              },
              childCount: Colors.accents.length,
            ),
          ), 
        ],
      ),
    );
  }
}

class ph extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
        print(shrinkOffset); 
    return SizedBox.expand(
      child: ColoredBox(color: Colors.grey),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 120;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }
}
