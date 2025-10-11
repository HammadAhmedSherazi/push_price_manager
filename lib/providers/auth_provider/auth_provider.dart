import 'dart:async';
import 'dart:convert';

import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/providers/auth_provider/auth_state.dart';

class AuthProvider  extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(
      loginApiResponse: ApiResponse.undertermined()
    );
  }

  FutureOr<void> login({required String email, required String password})async{
    try {
      state = state.copyWith(loginApiResponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.post(ApiEndpoints.login, {
  "email": email,
  "password": password
}, isToken: false);
      if(response != null){
        Helper.showMessage( AppRouter.navKey.currentContext!,message: "Successfully Login!");
        
        state = state.copyWith(loginApiResponse: ApiResponse.completed(response['data']));
        final Map<String, dynamic>? user = response["user"];
        if(user != null){
          savedUserData(user);
          AppConstant.userType = state.userData!.roleType == "EMPLOYEE" ? UserType.employee : UserType.manager;

        }
        SharedPreferenceManager.sharedInstance.storeToken(response['access_token'] ?? "");
        SharedPreferenceManager.sharedInstance.storeRefreshToken(response['refresh_access_token'] ?? "");
        AppRouter.pushAndRemoveUntil(NavigationView());
        
      }
      else{
        state = state.copyWith(loginApiResponse: ApiResponse.error());
      }
    } catch (e) {
      
      state = state.copyWith(loginApiResponse: ApiResponse.error());
      throw Exception(e);
    }
  }

  FutureOr<void> logout()async{
    
    try {
      SharedPreferenceManager.sharedInstance.clearAll();
    
      AppRouter.pushAndRemoveUntil(LoginView());
    } catch (e) {
      throw Exception(e);
    }
  }

  void savedUserData(Map<String, dynamic> userMap) {
    String user = jsonEncode(userMap);
    SharedPreferenceManager.sharedInstance.storeUser(user);
    userSet();
  }

  void userSet() {
    
    Map<String, dynamic> userJson =
        jsonDecode(SharedPreferenceManager.sharedInstance.getUserData()!);

   state = state.copyWith(userData: UserDataModel.fromJson(userJson));
    
   
  }




  
}
final authProvider = NotifierProvider<AuthProvider, AuthState>(
  AuthProvider.new,
);