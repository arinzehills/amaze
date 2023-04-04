import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/review_model.dart';
import 'package:flutter/material.dart';

class ReviewsContainer extends StatefulWidget {
  const ReviewsContainer({super.key, required this.reviews});
  final List reviews;

  @override
  State<ReviewsContainer> createState() => _ReviewsContainerState();
}

class _ReviewsContainerState extends State<ReviewsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context).width * 0.9,
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                calcTotalReview(widget.reviews).toStringAsFixed(1),
                style: TextStyle(fontSize: 43, fontWeight: FontWeight.bold),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < calcTotalReview(widget.reviews)
                        ? Icons.star
                        : Icons.star_border,
                    size: 18.0,
                    color: Color(0xffFFC107),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            padding: EdgeInsets.only(left: 30),
            child: Column(
              children: List.generate(5, (index) {
                final rating = (index + 1) % 5 + 1;
                // print(widget.reviews);
                final ratingCounts = [0, 0, 0, 0, 0];
                for (final rating in widget.reviews) {
                  ratingCounts[rating['ratings'] - 1]++;
                }
                print('ratingcou');
                print(ratingCounts);
                return Row(
                  children: [
                    Text('${index + 1}'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: size(context).width * 0.45,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: widget.reviews.length == 0
                              ? 0.0
                              : (ratingCounts[index] / widget.reviews.length),
                          minHeight: 10,
                          // valueColor: myDarkBlue,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

double calcTotalReview(List reviews) {
  double totalReview = 0.0;
  reviews.forEach((review) => {totalReview = totalReview + review['ratings']});
  double reviewPercentage =
      reviews.length != 0 ? totalReview / reviews.length : 0.0;
  return reviewPercentage;
}
