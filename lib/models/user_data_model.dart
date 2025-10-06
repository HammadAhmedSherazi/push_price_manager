class UserDataModel {
  final int id;
  final String username;
  final String email;
  final String roleType;
  final int chainId;

  const UserDataModel({
    required this.id,
    required this.username,
    required this.email,
    required this.roleType,
    required this.chainId,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      roleType: json['role_type'] ?? '',
      chainId: json['chain_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role_type': roleType,
      'chain_id': chainId,
    };
  }

  UserDataModel copyWith({
    int? id,
    String? username,
    String? email,
    String? roleType,
    int? chainId,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      roleType: roleType ?? this.roleType,
      chainId: chainId ?? this.chainId,
    );
  }

  @override
  String toString() {
    return 'UserDataModel(id: $id, username: $username, email: $email, roleType: $roleType, chainId: $chainId)';
  }
}
  