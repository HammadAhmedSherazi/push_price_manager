import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';

class AuthState {
  final ApiResponse loginApiResponse;
  final ApiResponse getStoresApiRes;
  final ApiResponse getCategoriesApiResponse;
  final UserDataModel? userData;
  final List<StoreSelectDataModel>? myStores;
  final List<StoreSelectDataModel>? selectedStores;
  final List<StoreSelectDataModel>? stores;
  final StaffModel? staffInfo;
  final List<CategoryDataModel>? categories;
  final int? categoriesSkip;
  AuthState({
    required this.loginApiResponse,
    required this.getStoresApiRes,
    required this.getCategoriesApiResponse,
    this.userData,
    this.myStores,
    this.stores,
    this.selectedStores,
    this.staffInfo,
    this.categories,
    this.categoriesSkip,
  });

  AuthState copyWith({
    ApiResponse? loginApiResponse,
    ApiResponse? getStoresApiRes,
    ApiResponse? getCategoriesApiResponse,
    UserDataModel? userData,
    List<StoreSelectDataModel>? myStores,
    List<StoreSelectDataModel>? stores,
    List<StoreSelectDataModel>? selectedStores,
    StaffModel? staffInfo,
    List<CategoryDataModel>? categories,
    int? categoriesSkip,
  }) => AuthState(
    loginApiResponse: loginApiResponse ?? this.loginApiResponse,
    getStoresApiRes:  getStoresApiRes ?? this.getStoresApiRes,
    getCategoriesApiResponse: getCategoriesApiResponse ?? this.getCategoriesApiResponse,
    userData: userData ?? this.userData,
    staffInfo: staffInfo ?? this.staffInfo,
    myStores: myStores ?? this.myStores,
    stores: stores ?? this.stores,
    selectedStores: selectedStores ?? this.selectedStores,
    categories: categories ?? this.categories,
    categoriesSkip: categoriesSkip ?? this.categoriesSkip,
  );
}
