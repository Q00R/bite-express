import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/productListKeyword.dart';
import '../providers/productsProvider.dart';
import '../classes/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(0, 1000);
  RangeValues _currentRatingValues = const RangeValues(1, 5);

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.fetchProducts();
  }

  void _performSearch(BuildContext context) {
    setState(() {
      _filteredProducts = Provider.of<ProductProvider>(context, listen: false)
          .getProductsByKeyword(
        _searchController.text,
        priceFrom: _currentRangeValues.start,
        priceTo: _currentRangeValues.end,
        minRating: _currentRatingValues.start.toInt(),
        maxRating: _currentRatingValues.end.toInt(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Search Page"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _performSearch(context),
                ),
              ),
            ),
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 1000,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            divisions: 500,
          ),
          RangeSlider(
            values: _currentRatingValues,
            min: 1,
            max: 5,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRatingValues = values;
              });
            },
            labels: RangeLabels(
              _currentRatingValues.start.round().toString(),
              _currentRatingValues.end.round().toString(),
            ),
            divisions: 4,
          ),
          Expanded(
            child: ProductListKeyword(filteredProducts: _filteredProducts),
          ),
        ],
      ),
    );
  }
}
