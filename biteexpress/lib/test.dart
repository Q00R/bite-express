// My Code that simply lists ALL products./
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import './productCard.dart';
// import '../classes/product.dart';
// import '../providers/productsProvider.dart';

// class ProductList extends StatefulWidget {
//   final String categoryName;

//   ProductList({Key? key, required this.categoryName}) : super(key: key);

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<ProductProvider>(context, listen: false);
//     provider.fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);

//     final List<Product> products =
//         productProvider.getProductsByCategory(widget.categoryName);

//     return Column(
//       children: [
//         Container(
//           alignment: Alignment.centerLeft,
//           child: const Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Text(
//               'subcategory',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 200,
//                 childAspectRatio: 4 / 6,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 5,
//               ),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return ProductCard(
//                   product: products[index],
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// WORKING CODE WITHH SUB LISTS FROM CHATGBT:
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import './productCard.dart';
// import '../classes/product.dart';
// import '../providers/productsProvider.dart';
// import 'package:collection/collection.dart';

// class ProductList extends StatefulWidget {
//   final String categoryName;

//   ProductList({Key? key, required this.categoryName}) : super(key: key);

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   late List<Product> products;

//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<ProductProvider>(context, listen: false);
//     provider.fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);

//     products = productProvider.getProductsByCategory(widget.categoryName);

//     // Group products by subcategory
//     final groupedProducts = groupBy<Product, String>(
//       products,
//       (product) => product.subcategory,
//     );

//     return ListView(
//       children: groupedProducts.entries.map((entry) {
//         final subcategory = entry.key;
//         final subcategoryProducts = entry.value;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 subcategory,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 200,
//                 childAspectRatio: 4 / 6,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 5,
//               ),
//               itemCount: subcategoryProducts.length,
//               itemBuilder: (context, index) {
//                 return ProductCard(
//                   product: subcategoryProducts[index],
//                 );
//               },
//             ),
//           ],
//         );
//       }).toList(),
//     );
//   }
// }

// Working code with extra List widget::::::/
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import './productCard.dart';
// import '../classes/product.dart';
// import '../providers/productsProvider.dart';
// import 'package:collection/collection.dart';

// class ProductList extends StatefulWidget {
//   final String categoryName;

//   ProductList({Key? key, required this.categoryName}) : super(key: key);

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   late List<Product> products;
//   int activeSubcategoryIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<ProductProvider>(context, listen: false);
//     provider.fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);

//     products = productProvider.getProductsByCategory(widget.categoryName);

//     // Group products by subcategory
//     final groupedProducts = groupBy<Product, String>(
//       products,
//       (product) => product.subcategory,
//     );

//     final subcategories = groupedProducts.keys.toList();

//     return Column(
//       children: [
//         SizedBox(
//           height: 40, // Adjust height as needed
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: subcategories.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     activeSubcategoryIndex = index;
//                   });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 8),
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: activeSubcategoryIndex == index
//                           ? Colors.blue // Active subcategory color
//                           : Colors.grey, // Inactive subcategory color
//                       width: 1,
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       subcategories[index],
//                       style: TextStyle(
//                         color: activeSubcategoryIndex == index
//                             ? Colors.blue // Active subcategory text color
//                             : Colors.black, // Inactive subcategory text color
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(
//             height: 10), // Add spacing between horizontal and vertical lists
//         Expanded(
//           child: ListView.builder(
//             itemCount: subcategories.length,
//             itemBuilder: (context, index) {
//               final subcategory = subcategories[index];
//               final subcategoryProducts = groupedProducts[subcategory] ?? [];

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       subcategory,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate:
//                         const SliverGridDelegateWithMaxCrossAxisExtent(
//                       maxCrossAxisExtent: 200,
//                       childAspectRatio: 4 / 6,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 5,
//                     ),
//                     itemCount: subcategoryProducts.length,
//                     itemBuilder: (context, index) {
//                       return ProductCard(
//                         product: subcategoryProducts[index],
//                       );
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// OLD HOME PAGE/
// import 'package:flutter/material.dart';
// import '../widgets/categoryList.dart';
// import '../widgets/bottomNavigator.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Home Page'),
//       ),
//       body: Center(child: CategoryList()),
//       bottomNavigationBar: BottomNavigation(
//         selectedIndex: 0,
//       ),
//     );
//   }
// }












































// PRODUCTDETAILS PAGE OLD CODE:

// import 'package:flutter/material.dart';
// import '../classes/product.dart';
// import '../widgets/productInfo.dart';
// import '../widgets/productComments.dart';

// class ProductDetailsPage extends StatefulWidget {
//   final Product product;
//   const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

//   @override
//   _ProductDetailsPageState createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   final ScrollController _scrollController = ScrollController();
//   late double _maxScrollExtent;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollListener() {
//     if (_scrollController.offset > _maxScrollExtent) {
//       _scrollController.jumpTo(_maxScrollExtent);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: CustomScrollView(
//           controller: _scrollController,
//           slivers: <Widget>[
//             SliverAppBar(
//               expandedHeight: 300.0,
//               floating: false,
//               pinned: true,
//               stretch: true,
//               flexibleSpace: LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                   _maxScrollExtent =
//                       constraints.biggest.height - kToolbarHeight + 250;
//                   return FlexibleSpaceBar(
//                     centerTitle: true,
//                     collapseMode: CollapseMode.parallax,
//                     background: Image.asset(
//                       "assets/images/${widget.product.image}",
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SliverPersistentHeader(
//               delegate: _SliverAppBarDelegate(
//                 const TabBar(
//                   indicatorSize: TabBarIndicatorSize.label,
//                   labelColor: Color.fromARGB(255, 255, 102, 0),
//                   unselectedLabelColor: Colors.grey,
//                   tabs: _tabs,
//                 ),
//               ),
//               pinned: true,
//             ),
//             SliverFillRemaining(
//               child: TabBarView(
//                 children: [
//                   SingleChildScrollView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const SizedBox(height: 20.0),
//                         ProductInfo(product: widget.product),
//                       ],
//                     ),
//                   ),
//                   const SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ProductComments(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             width: double.infinity,
//             child: FloatingActionButton.extended(
//               backgroundColor: const Color.fromARGB(255, 255, 102, 0),
//               onPressed: () {
//                 // Add your onPressed code here
//               },
//               icon: const Icon(Icons.add, color: Colors.white),
//               label: const Text(
//                 'Add to cart',
//                 style: TextStyle(
//                   color: Colors.white, // Set your desired color here
//                 ),
//               ),
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       ),
//     );
//   }
// }

// const _tabs = [
//   Tab(icon: Icon(Icons.info), text: "Product Info"),
//   Tab(icon: Icon(Icons.comment), text: "Comments"),
// ];

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);

//   final TabBar _tabBar;

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return _tabBar;
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }
