import 'package:flutter/material.dart';
import './categoryCard.dart';

class CategoryList extends StatelessWidget {
  final List<String> categories = [
    'Bakeries & Pastries',
    'Fruits & Vegetables',
    'Cold Cuts & Deli',
    'Dairy & Eggs',
    'Ready to Eat',
    'Milk',
    'Ice Cream',
    'Meat, Poultry & Seafood',
    'Frozen',
    'Snacks',
    'Beverages',
    'Canned & Jarred',
    'Cooking & Baking',
    'Condiments',
    'Breakfast Food',
  ];
  final List<String> imagePaths = [
    'assets/images/bakeriesAndPastries.png',
    'assets/images/fruitsAndVegetables.png',
    'assets/images/coldCutsAndDeli.png',
    'assets/images/dairyAndEggs.png',
    'assets/images/readyToEat.png',
    'assets/images/milk.png',
    'assets/images/icecream.png',
    'assets/images/meatPoultryAndSeafood.png',
    'assets/images/frozen.png',
    'assets/images/snacks.png',
    'assets/images/beverages.png',
    'assets/images/cannedAndJarred.png',
    'assets/images/cookingAndBaking.png',
    'assets/images/condiments.png',
    'assets/images/breakfastFood.png',
  ];

  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(22, 20, 10, 10),
            child: Text(
              'Explore Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 7 / 11,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                categoryName: categories[index],
                imagePath: imagePaths[index],
              );
            },
          ),
        )
      ],
    );
  }
}
