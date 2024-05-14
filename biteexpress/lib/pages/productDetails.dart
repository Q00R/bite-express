import 'package:flutter/material.dart';
import '../classes/product.dart';
import '../widgets/productInfo.dart';
import '../widgets/productComments.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    // background: Image.asset(
                    //   "assets/images/${widget.product.image}",
                    //   fit: BoxFit.cover,
                    // ),
                    background: Image.network(
                      widget.product.image,
                      fit: BoxFit.scaleDown,
                    ),
                  );
                },
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Color.fromARGB(255, 255, 102, 0),
                  unselectedLabelColor: Colors.grey,
                  tabs: _tabs,
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProductInfo(product: widget.product),
                      ],
                    ),
                  ),
                  const SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProductComments(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: FloatingActionButton.extended(
              backgroundColor: const Color.fromARGB(255, 255, 102, 0),
              onPressed: () {
                // Add your onPressed code here
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add to cart',
                style: TextStyle(
                  color: Colors.white, // Set your desired color here
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

const _tabs = [
  Tab(icon: Icon(Icons.info), text: "Product Info"),
  Tab(icon: Icon(Icons.comment), text: "Comments"),
];

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
