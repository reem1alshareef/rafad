class ratingModel {
  double rating = 0.0;
  String UID = "", campaignID = "", review = "", date = "", dateTime = "";

  ratingModel({
    required this.rating,
    required this.campaignID,
    required this.UID,
    required this.review,
    required this.date,
    required this.dateTime,
  });

  ratingModel.fromJson(Map<String, dynamic> json) {
    rating = double.parse(json['rating']);
    campaignID = json['campaignID'];
    UID = json['UID'];
    review = json['review'];
    date = json['date'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['campaignID'] = this.campaignID;
    data['UID'] = this.UID;
    data['review'] = this.review;
    data['date'] = this.date;
    data['dateTime'] = this.dateTime;
    return data;
  }
}