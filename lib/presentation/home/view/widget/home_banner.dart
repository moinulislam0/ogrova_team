import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int activeIndex = 0;

  // Carousel Controller definition
  final cs.CarouselSliderController controller = cs.CarouselSliderController();

  final List<String> bannerImages = [
    ImageManager.slider1,
    ImageManager.slider3,
    ImageManager.slider2,
    ImageManager.slider4,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              cs.CarouselSlider.builder(
                carouselController: controller,
                itemCount: bannerImages.length,
                itemBuilder: (context, index, realIndex) {
                  final imagePath = bannerImages[index]; // Get image from list
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ), // small gap
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(imagePath), // Fixed here
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: cs.CarouselOptions(
                  height: 180,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
              ),

              // Left Arrow - Previous Page
              Positioned(
                left: 10,
                child: GestureDetector(
                  onTap: () => controller.previousPage(),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.3),
                    radius: 18,
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Right Arrow - Next Page
              Positioned(
                right: 10,
                child: GestureDetector(
                  onTap: () => controller.nextPage(),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.3),
                    radius: 18,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Smooth Indicator
              Positioned(
                bottom: 10,
                child: AnimatedSmoothIndicator(
                  onDotClicked: (index) => controller.animateToPage(index),
                  activeIndex: activeIndex,
                  count: bannerImages.length,
                  effect: const ScrollingDotsEffect(
                    activeDotColor: Colors.orange,
                    dotColor: Colors.white70,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
