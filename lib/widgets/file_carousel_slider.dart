import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery_app/utils/dialog.dart';
import 'package:flutter/material.dart';

// Local file-based image carousel slider
class FileCarouselSlider extends StatefulWidget {
  final List<File> imgList;
  final List<Widget> imgWidgets;
  final Function? onImageRemove;

  FileCarouselSlider({super.key, required this.imgList, this.onImageRemove})
      : imgWidgets = imgList
            .map((item) => GestureDetector(
                onTap: () => {openFullScreenImage(FileImage(item))},
                child: Image.file(item, fit: BoxFit.cover)))
            .toList();

  @override
  State<FileCarouselSlider> createState() => _FileCarouselSliderState();
}

class _FileCarouselSliderState extends State<FileCarouselSlider> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: widget.imgList.asMap().entries.map((entry) {
          final index = entry.key;
          final image = entry.value;

          return Stack(
            children: [
              GestureDetector(
                onTap: () => openFullScreenImage(FileImage(image)),
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              widget.onImageRemove == null
                  ? Container()
                  : Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                              color: Colors.white,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                ),
                              )),
                        ),
                        onPressed: () => widget.onImageRemove!(index),
                      ),
                    ),
            ],
          );
        }).toList(),
        carouselController: _controller,
        options: CarouselOptions(
          height: 400,
          autoPlay: true,
          enableInfiniteScroll: false,
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
