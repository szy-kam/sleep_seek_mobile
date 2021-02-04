class Review {
  final int reviewId;
  final int stayId;
  final String username;
  final String message;
  final double rating;
  final String createdAt;

  Review(this.reviewId, this.stayId, this.username, this.message, this.rating,
      this.createdAt);

  Review.fromJson(Map<String, dynamic> map)
      : reviewId = map['reviewId'],
        stayId = map['stayId'],
        username = map['username'],
        message = map['message'],
        rating = map['rating'],
        createdAt = map['createdAt'];

  Map<String, dynamic> toJson() => {
        'reviewId': reviewId,
        'stayId': stayId,
        'username': username,
        'message': message,
        'rating': rating,
        'createdAt': createdAt
      };

  Map<String, String> toJson2() => {
        'reviewId': reviewId.toString(),
        'stayId': stayId.toString(),
        'username': username,
        'message': message,
        'rating': rating.toString(),
        'createdAt': createdAt
      };
}
