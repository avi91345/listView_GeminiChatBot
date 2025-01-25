import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          child: ListTile(
            title: Container(
              height: 16.0,
              width: double.infinity,
              color: Colors.grey,
            ),
            subtitle: Container(
              height: 12.0,
              width: double.infinity,
              color: Colors.grey,
              margin: const EdgeInsets.only(top: 8.0),
            ),
          ),
        ),
      ),
    );
  }
}
