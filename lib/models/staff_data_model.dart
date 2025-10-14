class StaffModel {
  final int staffId;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String profileImage;
  final String roleType;
  final int chainId;

  StaffModel({
    required this.staffId,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.profileImage,
    required this.roleType,
    required this.chainId,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      staffId: json['staff_id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      profileImage: json['profile_image'] ?? '',
      roleType: json['role_type'] ?? '',
      chainId: json['chain_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'staff_id': staffId,
      'username': username,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'profile_image': profileImage,
      'role_type': roleType,
      'chain_id': chainId,
    };
  }
}
