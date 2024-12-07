import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery_app/utils/dialog.dart';
import 'package:flutter/material.dart';

class NetworkCarouselSlider extends StatefulWidget {
  final List<String> imgList;
  final List<Widget> imgWidgets;

  NetworkCarouselSlider({super.key, required this.imgList})
      : imgWidgets = imgList
            .map((item) => GestureDetector(
                  onTap: () => openFullScreenImage(NetworkImage(item)),
                  child: Image.network(item, fit: BoxFit.cover),
                ))
            .toList();

  @override
  State<NetworkCarouselSlider> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<NetworkCarouselSlider> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: widget.imgWidgets,
        carouselController: _controller,
        options: CarouselOptions(
          height: 400,
          enableInfiniteScroll: false,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
