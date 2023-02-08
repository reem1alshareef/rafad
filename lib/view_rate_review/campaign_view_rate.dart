import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rafad1/view_rate_review/ratingCard2.dart';
import 'package:rafad1/view_rate_review/rating_model.dart';
import 'package:rate_in_stars/rate_in_stars.dart';


class ratingsList extends StatefulWidget {
  ratingsList({
    Key? key,
    required this.campaignId,
    required this.averageShopRating,
    required this.numberOfRatings,
  }) : super(key: key);

  final String campaignId;
  final double averageShopRating;
  final double numberOfRatings;
  @override
  State<ratingsList> createState() => _ratingsListState();
}
class _ratingsListState extends State<ratingsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Back"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
      ),
      body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                //---------------------------------------------------------------------------
                //مستطيل في أعلى الليست يعرض نسبة تقييم المتجر وعدد تقييمات
                padding: const EdgeInsets.all(0),
                margin: EdgeInsets.only(bottom: 20, left: 19, right: 18),
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF455D83),),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF455D83).withOpacity(.2),
                      blurRadius: 5.0,
                      spreadRadius: .05,
                    ), //BoxShadow
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Star icon
                    Container(
                        //padding: const EdgeInsets.only(bottom: 0, right: 10),
                        height: 50,
                        width: 50,
                        child: Image.asset('assests/images/star-100.png')),
                    // عدد نجوم هذا التقييم رقمًا
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 18.0, left: 10, right: 5),
                      child: Text(
                        "${widget.averageShopRating}",
                        style: const TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w800,
                          //fontFamily: "Tajawal",
                          //color: kPrimaryColor,
                        ),
                      ),
                    ),
                    //عدد التققيمات
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: Text(
                        " From (${widget.numberOfRatings}) ratings",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          //fontFamily: "Tajawal",
                          decoration: TextDecoration.underline,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-------------------------------------------------------------------------------------------
              Expanded(
                child: Stack(
                  children: [
                    //This is to list all of our items fetched from the DB========================
                    StreamBuilder<List<ratingModel>>(
                      stream: readRatings(widget.campaignId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final ratings = snapshot.data!.toList();
                          final data = snapshot.data!;
                          //sort the ratings according to date
                          ratings.sort((a, b) {
                            return DateTime.parse(b.dateTime)
                                .compareTo(DateTime.parse(a.dateTime));
                          });
                          if (data.isEmpty) {
                            return const Center(
                              child: Text(
                                'No ratings',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  //fontFamily: "Tajawal",
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                          //هنا حالة النجاح في استرجاع البيانات...........................................
                          else {
                            // return ListView.builder(
                            //   itemCount: ratings.length,
                            //   itemBuilder: (context, index) => ratingCard(
                            //       itemIndex: index,
                            //       ratingItem: ratings[index],
                            //       averageShopRating: widget.averageShopRating),
                            // );
                            return ListView.separated(
                              separatorBuilder: (_, __) => const Divider(
                                height: 0,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                                //color: kPrimaryColor,
                                color:  Color(0xFF455D83),
                              ),
                              itemCount: ratings.length,
                              itemBuilder: (context, index) => ratingCard2(
                                  itemIndex: index,
                                  ratingItem: ratings[index],
                                  averageShopRating: widget.averageShopRating),
                            );
                          }
                          //..................................................................................
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    //==================================================================================
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    
  }

//========================================================================================
  Stream<List<ratingModel>> readRatings(String thisCampaignId) {
    return FirebaseFirestore.instance
        .collection('Rate')
        .where('campaignID', isEqualTo: thisCampaignId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ratingModel.fromJson(doc.data()))
            .toList());
  }
  }
