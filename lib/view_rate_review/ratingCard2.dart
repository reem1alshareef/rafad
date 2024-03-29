import 'package:flutter/material.dart';
import 'package:rafad1/view_rate_review/rating_model.dart';
//import 'package:herfaty/constants/color.dart';
//import 'package:herfaty/models/ratingModel.dart';
import 'package:rate_in_stars/rate_in_stars.dart';


class ratingCard2 extends StatefulWidget {
  const ratingCard2({
    Key? key,
    required this.itemIndex,
    required this.ratingItem,
    required this.averageShopRating,
  }) : super(key: key);

  final int itemIndex;
  final ratingModel ratingItem;
  final num averageShopRating;

  @override
  State<ratingCard2> createState() => _ratingCard2State();
}

class _ratingCard2State extends State<ratingCard2> {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //to get the width and height of the app
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListTile(
        tileColor: Colors.white,
        minVerticalPadding: 10,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        title: Row(
          children: [
        Text(
            widget.ratingItem.pilgrimName,
            style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 5,),
        Text(
          ' : "${widget.ratingItem.review}" ',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            //fontFamily: "Tajawal",
            color: Colors.black,
          ),
        ),
         
        ]),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // عدد نجوم هذا التقييم رقمًا
                Padding(
                  padding: const EdgeInsets.only(top: 9.0, left: 5.0),
                  child: Text(
                    "${widget.ratingItem.rating}",
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600,
                      //fontFamily: "Tajawal",
                      //color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                //  عدد نجوم هذا التقييم على شكل نجوم ممتلئة نسبيًا
                RatingStars(
                  editable: false,
                  rating: widget.ratingItem.rating,
                  color: Colors.amber,
                  iconSize: 28,
                ),
              ],
            ),
            //-----------------------------------------------------
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Date Icon
                Icon(
                  Icons.access_time_outlined,
                  //color: kPrimaryLight,
                  size: 16.0,
                ),

                //*************************This part contains rating date التاريخ
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 5.0),
                  child: Text(
                    widget.ratingItem.date,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      //fontFamily: NoteSerif,
                      color: Color.fromARGB(255, 93, 91, 91),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}