import 'package:flutter/material.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 50, 
      child: ListView.builder(
        scrollDirection:
            Axis.horizontal, 
        shrinkWrap: true, 
        physics:
            const NeverScrollableScrollPhysics(), 
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          width: 80, 
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
