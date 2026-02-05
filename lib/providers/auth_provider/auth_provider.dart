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
      getCategoriesApiResponse: ApiResponse.undertermined(),
      myStores: [],
      selectedStores: [],
      categories: [],
      categoriesSkip: 0,
    );
  }

  FutureOr<void> login({required String email, required String password})async{
    if (!ref.mounted) return;
    try {
      state = state.copyWith(loginApiResponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.post(ApiEndpoints.login, {
  "username": email,
  "password": password
}, isToken: false);
      if (!ref.mounted) return;

      // Add condition check
      if(response != null && !(response is Map && response.containsKey('detail'))){
        Helper.showMessage( AppRouter.navKey.currentContext!,message: AppRouter.navKey.currentContext!.tr("successfully_login"));

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
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
        );
        state = state.copyWith(loginApiResponse: ApiResponse.error());
      }
    } catch (e) {
      if (!ref.mounted) return;
      // Show error message for exceptions
    
      state = state.copyWith(loginApiResponse: ApiResponse.error());
    }
  }

  FutureOr<void> logout()async{
    if (!ref.mounted) return;

    try {
      SharedPreferenceManager.sharedInstance.clearAll();

      AppRouter.pushAndRemoveUntil(LoginView());
    } catch (e) {
      if (!ref.mounted) return;
      throw Exception(e);
    }
  }
  FutureOr<void> getMyStores({String? searchText}) async {
    if (!ref.mounted) return;
    try {
      state = state.copyWith(getStoresApiRes: ApiResponse.loading());
      final response = await MyHttpClient.instance.get(ApiEndpoints.getMyStore);
      if (!ref.mounted) return;

      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          getStoresApiRes: ApiResponse.completed(response),
        );
        List temp = response['assigned_stores'] ?? [];
        final List<StoreSelectDataModel> tempStoreList = List.from(
            temp.map((e) => StoreSelectDataModel.fromJson(e)),
          );
        // if (temp.isNotEmpty) {
        state = state.copyWith(
          selectedStores: [],
          staffInfo: StaffModel.fromJson(response['staff_info'] ?? { "staff_id": 2, "username": "abcmanager", "email": "naheedmanager@example.com", "full_name": "Jerry Mick", "phone_number": "+15123123", "profile_image": "https://www.svgrepo.com/show/384670/account-avatar-profile-user.svg", "role_type": "MANAGER", "chain_id": 1 } ),
          myStores: tempStoreList,
          stores: tempStoreList
        );
        // }
      } else {
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
        );
        state = state.copyWith(getStoresApiRes: ApiResponse.error());
      }
    } catch (e) {
      if (!ref.mounted) return;
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

  /// Restore user from cache (e.g. on app reopen when token exists).
  void restoreUserFromCache() {
    final userData = SharedPreferenceManager.sharedInstance.getUserData();
    if (userData == null || userData.isEmpty) return;
    userSet();
    if (state.userData != null) {
      AppConstant.userType =
          state.userData!.roleType == "EMPLOYEE" ? UserType.employee : UserType.manager;
    }
  }

  FutureOr<void> getCategories({
    required int limit,
    required int skip,
    String? searchText,
  }) async {
    if (!ref.mounted) return;
    if (skip == 0 && state.categories!.isNotEmpty) {
      state = state.copyWith(categories: [], categoriesSkip: 0);
    }
    Map<String, dynamic> params = {'limit': limit, 'skip': skip};
    if (searchText != null) {
      params['search'] = searchText;
    }

    try {
      state = state.copyWith(
        getCategoriesApiResponse: skip == 0
            ? ApiResponse.loading()
            : ApiResponse.loadingMore(),
      );
      final response = await MyHttpClient.instance.get(
        ApiEndpoints.getCatrgories,
        params: params,
      );

      if (!ref.mounted) return;

      if (response != null) {
        List temp = response ?? [];
        final List<CategoryDataModel> list = List.from(
          temp.map((e) => CategoryDataModel.fromJson(e)),
        );
        state = state.copyWith(
          getCategoriesApiResponse: ApiResponse.completed(response),
          categories: skip == 0 && state.categories!.isEmpty
              ? list
              : [...state.categories!, ...list],
          categoriesSkip: list.length >= limit ? skip + limit : 0,
        );
      } else {
        state = state.copyWith(
          getCategoriesApiResponse: skip == 0
              ? ApiResponse.error()
              : ApiResponse.undertermined(),
        );
      }
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        getCategoriesApiResponse: skip == 0
            ? ApiResponse.error()
            : ApiResponse.undertermined(),
      );
    }
  }
}
final authProvider = NotifierProvider<AuthProvider, AuthState>(
  AuthProvider.new,
);