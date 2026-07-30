import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int activeIndex = 0;

  final cs.CarouselSliderController controller = cs.CarouselSliderController();

  final List<String> bannerImages = [
    'assets/images/ogrova_logo.png',
    'assets/images/ogrova_logo.png',
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
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/ogrova_logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: cs.CarouselOptions(
                  height: 180,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
              ),

              // Left Arrow
              Positioned(
                left: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.3),
                  radius: 18,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      color: Colors.white,
                    ),
                    onPressed: () => controller.previousPage(),
                  ),
                ),
              ),

              // Right Arrow
              Positioned(
                right: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.3),
                  radius: 18,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                    onPressed: () => controller.nextPage(),
                  ),
                ),
              ),

              // Indicator
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
