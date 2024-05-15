import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  // 'https://scontent.faly2-1.fna.fbcdn.net/v/t39.30808-6/420113805_876905470890210_730188240199369851_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=5f2048&_nc_ohc=5DSpYF-EFAgQ7kNvgGrCdP4&_nc_ht=scontent.faly2-1.fna&oh=00_AYDhGumkhbce1avQSIw0iVJAltA7OHp17WuE3TUAjs1nag&oe=664A6D2B',
  // 'https://mir-s3-cdn-cf.behance.net/project_modules/fs/2a4cbd112512307.6015d51b16b4e.png',
  // 'https://img.freepik.com/premium-vector/flash-sale-background-with-discount_666566-14.jpg',
  // 'https://i.ytimg.com/vi/ET-hdv2rF-I/maxresdefault.jpg',
  // 'https://d2td6mzj4f4e1e.cloudfront.net/wp-content/uploads/sites/9/2015/01/Cadbury.jpg'
  'https://i.ibb.co/Sf058w0/dairymilk.jpg',
  'https://i.ibb.co/RCwvDJn/doritos.jpg',
  'https://i.ibb.co/dmn0F8q/flashsale.jpg',
  'https://i.ibb.co/G3Z9pKm/todo.jpg',
  'https://i.ibb.co/F76F7Xh/cadburry.png'
];

class CarouselWithAutoplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: imgList.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
