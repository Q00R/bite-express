import 'package:flutter/material.dart';
import '../pages/category.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;

  const CategoryCard({
    Key? key,
    required this.categoryName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryPage(categoryName: categoryName)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 1,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color.fromARGB(255, 255, 234, 203)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  // child: Image.asset(
                  //   imagePath,
                  //   fit: BoxFit.fill,
                  //   width: double.infinity,
                  // ),
                  child: SizedBox(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.scaleDown,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
