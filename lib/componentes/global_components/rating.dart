

import 'package:flutter/material.dart';
import 'package:flutter_rating_null_safe/flutter_rating_null_safe.dart';
            
class Rating extends StatelessWidget {

  double rating = 0;

  Rating({
    super.key,
    required this.rating
  });

  @override
  Widget build(BuildContext context) {
    return FlutterRating(
          rating: rating,
          starCount: 5,
          borderColor: Colors.grey,
          color: Colors.amber,
          allowHalfRating: true,
          size: 20,
          mainAxisAlignment: MainAxisAlignment.start 
      );
  }
}
