import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/productListKeyword.dart';
import '../providers/productsProvider.dart';
import '../classes/product.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:side_sheet/side_sheet.dart';
import '../widgets/searchPageSideSheet.dart';

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
        title: LayoutBuilder(
          builder: (context, constraints) {
            return AnimationSearchBar(
              onChanged: (text) => debugPrint(text),
              searchTextEditingController: _searchController,
              searchBarWidth: constraints.maxWidth - 20,
              cursorColor: const Color.fromARGB(255, 255, 94, 0),
              searchFieldDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 234, 222),
                border: Border.all(
                  color:
                      const Color.fromARGB(255, 255, 197, 160).withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              isBackButtonVisible: false,
              centerTitle: const Text(
                'Browse Bite Express',
                style: TextStyle(color: Colors.orange),
                textAlign: TextAlign.center,
              ).data,
              centerTitleStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.orange,
                fontSize: 20,
              ),
              hintText: 'Search here...',
              hintStyle: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w300,
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _performSearch(context),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 40),
                    backgroundColor: const Color.fromARGB(255, 255, 140, 0)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.filter_list, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'See Results',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  SideSheet.right(
                    body: FilterSheetContent(
                      currentRangeValues: _currentRangeValues,
                      currentRatingValues: _currentRatingValues,
                      onPriceRangeChanged: (values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                      onRatingRangeChanged: (values) {
                        setState(() {
                          _currentRatingValues = values;
                        });
                      },
                    ),
                    context: context,
                  );
                },
                icon: const Icon(
                  Icons.filter_alt,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          Expanded(
            child: ProductListKeyword(filteredProducts: _filteredProducts),
          ),
        ],
      ),
    );
  }
}
