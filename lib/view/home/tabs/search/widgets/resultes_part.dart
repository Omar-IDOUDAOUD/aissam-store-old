import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:aissam_store/controller/search.dart' as ctrls;

class ResultesPart extends StatefulWidget {
  ResultesPart(
      {super.key,
      required this.scrollController,
      this.type = ResultsTypes.all});

  final ResultsTypes type;
  final ScrollController scrollController;

  @override
  State<ResultesPart> createState() => _ResultesPartState();
}

class _ResultesPartState extends State<ResultesPart> {
  // late final ScrollController _scrollController;
  final ctrls.SearchController _controller = ctrls.SearchController.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.scrollController.addListener(_paginationLoader);
    // _controller.paginationDataResult.reset();
    _controller.loadSearchResults(widget.type);
  }

  void _paginationLoader() {
    if (widget.scrollController.offset >=
        widget.scrollController.position.maxScrollExtent) {
      _controller.loadSearchResults(widget.type);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.scrollController.removeListener(_paginationLoader);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ctrls.SearchController>(
      init: _controller,
      id: _controller.paginationDataResultBy(widget.type).widgetToUpdateTag,
      builder: (c) {
        final pd = c.paginationDataResultBy(widget.type);
        if (pd.hasError) return Text('an error occurred');
        if (pd.loadedData.isEmpty && !pd.isLoading)
          return Text('No element found');
        return CustomScrollView(
          // controller: _scrollController,
          physics: BouncingScrollPhysics(),
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
                itemCount: pd.loadedData.length + (pd.isLoading ? 3 : 0),
                itemBuilder: (_, i) {
                  if (i >= pd.loadedData.length)
                    return const LoadingProductCard();
                  return ProductCard(
                    data: pd.loadedData.elementAt(i),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
