class UserRatingDataModel {
  final String userName;
  final String userImage;
  final double rating;
  final String description;
  final DateTime date;

  UserRatingDataModel({
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.description,
    required this.date,
  });
}