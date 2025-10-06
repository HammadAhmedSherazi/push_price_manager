import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';

class AuthState {
  final ApiResponse loginApiResponse ;
  final UserDataModel ? userData;
  AuthState({required this.loginApiResponse, this.userData});
  

  AuthState copyWith({ApiResponse? loginApiResponse, UserDataModel ? userData})=>AuthState(loginApiResponse: loginApiResponse ?? this.loginApiResponse, userData: userData ?? this.userData);
}