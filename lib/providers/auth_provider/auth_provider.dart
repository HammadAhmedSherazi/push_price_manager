import 'dart:async';
import 'dart:convert';

import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/providers/auth_provider/auth_state.dart';

class AuthProvider  extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(
      loginApiResponse: ApiResponse.undertermined(),
      getStoresApiRes: ApiResponse.undertermined(),
      myStores: [],
      selectedStores: []
    );
  }

  FutureOr<void> login({required String email, required String password})async{
    try {
      state = state.copyWith(loginApiResponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.post(ApiEndpoints.login, {
  "email": email,
  "password": password
}, isToken: false);
      
      // Add condition check
      if(response != null && !(response is Map && response.containsKey('detail'))){
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
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Login failed. Please check your credentials and try again.",
        );
        state = state.copyWith(loginApiResponse: ApiResponse.error());
      }
    } catch (e) {
      // Show error message for exceptions
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
      );
      state = state.copyWith(loginApiResponse: ApiResponse.error());
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
  FutureOr<void> getMyStores({String? searchText}) async {
    try {
      state = state.copyWith(getStoresApiRes: ApiResponse.loading());
      final response = await MyHttpClient.instance.get(ApiEndpoints.getMyStore);
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          getStoresApiRes: ApiResponse.completed(response),
        );
        List temp = response['assigned_stores'] ?? [];
        // if (temp.isNotEmpty) {
        state = state.copyWith(
          selectedStores: [],
          staffInfo: StaffModel.fromJson(response['staff_info'] ?? { "staff_id": 2, "username": "abcmanager", "email": "naheedmanager@example.com", "full_name": "Jerry Mick", "phone_number": "+15123123", "profile_image": "https://www.svgrepo.com/show/384670/account-avatar-profile-user.svg", "role_type": "MANAGER", "chain_id": 1 } ),
          myStores: List.from(
            temp.map((e) => StoreSelectDataModel.fromJson(e)),
          ),
        );
        // }
      } else {
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to load stores. Please try again.",
        );
        state = state.copyWith(getStoresApiRes: ApiResponse.error());
      }
    } catch (e) {
      // Show error message for exceptions
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
      );
      state = state.copyWith(getStoresApiRes: ApiResponse.error());
    }
  }
    void addSelectStore(int index) {
    final stores = List<StoreSelectDataModel>.from(state.myStores ?? []);
    final selectedStores = List<StoreSelectDataModel>.from(
      state.selectedStores ?? [],
    );

    final store = stores[index];
    selectedStores.add(store.copyWith(isSelected: true));
    stores.removeAt(index);

    state = state.copyWith(myStores: stores, selectedStores: selectedStores);
  }

  void removeStore(int index) {
    final stores = List<StoreSelectDataModel>.from(state.myStores ?? []);
    final selectedStores = List<StoreSelectDataModel>.from(
      state.selectedStores ?? [],
    );

    final store = selectedStores[index];
    stores.add(store.copyWith(isSelected: false));
    selectedStores.removeAt(index);

    state = state.copyWith(myStores: stores, selectedStores: selectedStores);
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