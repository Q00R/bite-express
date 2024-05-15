import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './productCard.dart';
import '../classes/product.dart';
import '../providers/productsProvider.dart';

class ProductListCategory extends StatefulWidget {
  final String categoryName;

  ProductListCategory({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<ProductListCategory> createState() => _ProductListCategoryState();
}

class _ProductListCategoryState extends State<ProductListCategory> {
  String selectedSubcategory = 'All';

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final List<Product> allProducts =
        productProvider.getProductsByCategory(widget.categoryName);

    // Get unique subcategories
    final Set<String> subcategories = {'All'};
    allProducts.forEach((product) {
      subcategories.add(product.subcategory);
    });

    List<Product> filteredProducts = allProducts;
    if (selectedSubcategory != 'All') {
      filteredProducts = allProducts
          .where((product) => product.subcategory == selectedSubcategory)
          .toList();
    }

    // return a widget in the center that says No products found if filteredProducts is empty
    if (filteredProducts.isEmpty) {
      return const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('No products found '),
            Icon(
              Icons.sentiment_dissatisfied,
              color: Color.fromARGB(255, 255, 122, 70),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategories.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSubcategory = subcategory;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: subcategory == selectedSubcategory
                          ? const Color(0xFFFFE0B2)
                          : null,
                      border: subcategory == selectedSubcategory
                          ? null
                          : Border.all(
                              color: const Color.fromARGB(255, 232, 232, 232)),
                    ),
                    child: Center(
                      child: Text(
                        subcategory,
                        style: TextStyle(
                          color: subcategory == selectedSubcategory
                              ? Colors.deepOrange
                              : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170,
                childAspectRatio: 6 / 11,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: filteredProducts[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
