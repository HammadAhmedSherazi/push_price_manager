import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';

class AuthState {
  final ApiResponse loginApiResponse;
  final ApiResponse getStoresApiRes;
  final UserDataModel? userData;
  final List<StoreSelectDataModel>? myStores;
  final List<StoreSelectDataModel>? selectedStores;
  final StaffModel? staffInfo;
  AuthState({
    required this.loginApiResponse,
    required this.getStoresApiRes,
    this.userData,
    this.myStores,
    this.selectedStores,
    this.staffInfo,
  });

  AuthState copyWith({
    ApiResponse? loginApiResponse,
    ApiResponse? getStoresApiRes,
    UserDataModel? userData,
    List<StoreSelectDataModel>? myStores,
    List<StoreSelectDataModel>? selectedStores,
    StaffModel? staffInfo,
  }) => AuthState(
    loginApiResponse: loginApiResponse ?? this.loginApiResponse,
    getStoresApiRes:  getStoresApiRes ?? this.getStoresApiRes,
    userData: userData ?? this.userData,
    staffInfo: staffInfo ?? this.staffInfo,
    myStores: myStores ?? this.myStores,
    selectedStores: selectedStores ?? this.selectedStores
  );
}
