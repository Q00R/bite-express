import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/product.dart';
import '../widgets/productInfo.dart';
import '../widgets/productComments.dart';
import '../classes/Cart.dart';
import '../providers/authenticationProvider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read the cart and initialize the quantity
    _quantity = Provider.of<Cart>(context).getQuantity(widget.product);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();
    final authProvider = context.watch<AuthenticationProvider>();

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
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProductComments(product: widget.product),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: authProvider.isAuthenticated
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: const Color.fromARGB(
                      255, 255, 102, 0), // Orange background
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (_quantity > 0)
                        IconButton(
                          onPressed: () {
                            cart.removeFromCart(widget.product);
                            setState(() {
                              _quantity = cart.getQuantity(widget.product);
                            });
                            _showSnackBar('Product removed from cart');
                          },
                          icon: const Icon(Icons.remove, color: Colors.white),
                        ),
                      Text(
                        '$_quantity',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          cart.addToCart(widget.product);
                          setState(() {
                            _quantity = cart.getQuantity(widget.product);
                          });
                          _showSnackBar('Product added to cart');
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            : null, // Set FloatingActionButton to null if not authenticated
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

const _tabs = [
  Tab(icon: Icon(Icons.info), text: "Product Info"),
  Tab(icon: Icon(Icons.comment), text: "Reviews"),
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
