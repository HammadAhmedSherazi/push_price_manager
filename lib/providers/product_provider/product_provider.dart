import 'dart:async';

import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/providers/product_provider/product_state.dart';

class ProductProvider extends Notifier<ProductState> {
  @override
  ProductState build() {
    return ProductState(
      productApiResponse: ApiResponse.undertermined(),
      products: [],
      getProductReponse: ApiResponse.loading(),
      listNowApiResponse: ApiResponse.undertermined(),
      listRequestApiResponse: ApiResponse.undertermined(),
      productListingApiResponse: ApiResponse.undertermined(),
      pendingReviewApiRes: ApiResponse.undertermined(),
      getSuggestionApiRes: ApiResponse.undertermined(),
      setReviewApiRes: ApiResponse.undertermined(),
      getStoresApiRes: ApiResponse.undertermined(),
      deleteApiRes: ApiResponse.undertermined(),
      updateApiRes: ApiResponse.undertermined(),
      listLiveApiResponse: ApiResponse.undertermined(),
      listLiveProducts: [],
      listApprovedproducts: [],
      listRequestproducts: [],
      pendingReviewList: [],
      myStores: [],
    );
  }

  void setGoLiveDate(DateTime? date) {
    if (date == null) return;
    state = state.copyWith(
      listItem: state.listItem!.copyWith(goLiveDate: date),
    );
  }

  void setListItem(ListingModel item) {
    state = state.copyWith(listItem: item);
  }

  void setCheckBox(bool chk, int index) {
    if (index == 0) {
      state = state.copyWith(
        listItem: state.listItem!.copyWith(saveDiscountForFuture: chk),
      );
    } else if (index == 1) {
      state = state.copyWith(
        listItem: state.listItem!.copyWith(saveDiscountForListing: chk),
      );
    } else {
      state = state.copyWith(
        listItem: state.listItem!.copyWith(autoApplyForNextBatch: chk),
      );
    }
  }

  void addSelectProduct(int index) {
    final stores = List<StoreSelectDataModel>.from(state.myStores ?? []);
    final selectedStores = List<StoreSelectDataModel>.from(
      state.mySelectedStores ?? [],
    );

    final store = stores[index];
    selectedStores.add(store.copyWith(isSelected: true));
    stores.removeAt(index);

    state = state.copyWith(myStores: stores, mySelectedStores: selectedStores);
  }

  void removeProduct(int index) {
    final stores = List<StoreSelectDataModel>.from(state.myStores ?? []);
    final selectedStores = List<StoreSelectDataModel>.from(
      state.mySelectedStores ?? [],
    );

    final store = selectedStores[index];
    stores.add(store.copyWith(isSelected: false));
    selectedStores.removeAt(index);

    state = state.copyWith(myStores: stores, mySelectedStores: selectedStores);
  }

  FutureOr<void> getProductfromDatabase({
    required int limit,
    required int skip ,
    String? searchText,
  }) async {
    if (skip == 0 && state.products!.isNotEmpty) {
      state = state.copyWith(products: [], skip: 0);
    }
    Map<String, dynamic> params = {'limit': limit, 'skip': skip};
    if (searchText != null) {
      params['search'] = searchText;
    }
    // if(minPrice != null){
    //   params['min_price'] = minPrice;
    // }
    // if(maxPrice != null){
    //   params['max_price'] = maxPrice;
    // }
    // if(categoryId != null){
    //   params['category_id'] = categoryId;
    // }

    try {
      state = state.copyWith(
        productApiResponse: skip == 0
            ? ApiResponse.loading()
            : ApiResponse.loadingMore(),
      );
      final response = await MyHttpClient.instance.get(
        AppConstant.userType == UserType.employee
            ? ApiEndpoints.getEmployeeDataBaseProducts
            : ApiEndpoints.getManagerDataBaseProducts,
        params: params,
      );

      if (response != null) {
        List temp = response ?? [];
        final List<ProductDataModel> list = List.from(
          temp.map((e) => ProductDataModel.fromJson(e)),
        );
        state = state.copyWith(
          productApiResponse: ApiResponse.completed(response),
          products: skip == 0 && state.products!.isEmpty
              ? list
              : [...state.products!, ...list],
          skip: list.length >= limit ? 1 + limit : 0,
        );
      } else {
        state = state.copyWith(
          productApiResponse: skip == 0
              ? ApiResponse.error()
              : ApiResponse.undertermined(),
        );
      }
    } catch (e) {
      state = state.copyWith(
        productApiResponse: skip == 0
            ? ApiResponse.error()
            : ApiResponse.undertermined(),
      );
    }
  }

  FutureOr<void> getProductData(String code) async {
    try {
      state = state.copyWith(getProductReponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.get(
        "${ApiEndpoints.getProductDetailByBarCode}$code",
      );
      AppRouter.back();
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          getProductReponse: ApiResponse.completed(
            ProductDataModel.fromJson(response),
          ),
        );
        AppRouter.push(ScanProductView(data: state.getProductReponse.data!));
      } else {
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to get product data. Please try again.",
        );
        state = state.copyWith(getProductReponse: ApiResponse.error());
      }
    } catch (e) {
      AppRouter.back();
      // Show error message for exceptions
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: "An error occurred while getting product data. Please try again.",
      );
      state = state.copyWith(getProductReponse: ApiResponse.error());
    }
  }

  FutureOr<void> listNow({
    required Map<String, dynamic> input,
    required int popTime,
  }) async {
    try {
      state = state.copyWith(listNowApiResponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.post(
        AppConstant.userType == UserType.employee
            ? ApiEndpoints.listings
            : ApiEndpoints.managerCreate,
        input,
      );
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          listNowApiResponse: ApiResponse.completed(response),
        );
        AppRouter.customback(times: popTime);
        AppRouter.push(
          SuccessListingRequestView(
            message: AppConstant.userType == UserType.employee
                ? "Product Listing Successful!"
                : "Listing Request Sent Successfully!",
          ),
        );
      } else {
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to create listing. Please try again.",
        );
        state = state.copyWith(listNowApiResponse: ApiResponse.error());
      }
    } catch (e) {
      // Show error message for exceptions
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: "An error occurred while creating listing. Please try again.",
      );
      state = state.copyWith(listNowApiResponse: ApiResponse.error());
    }
  }

  FutureOr<void> getListRequestProducts({
    required int limit,
    required int skip ,
    String? type,
    String? searchText,
  }) async {
    try {
      if (skip == 0 && state.listRequestproducts!.isNotEmpty) {
        state = state.copyWith(listRequestproducts: []);
      }
      state = state.copyWith(
        listRequestApiResponse: skip == 0
            ? ApiResponse.loading()
            : ApiResponse.loadingMore(),
      );
      Map<String, dynamic> params = {
        "status_filter": "PENDING_EMPLOYEE_DETAILS",
        "skip": skip,
        "limit": limit,
      };
      if (type != null) {
        params["listing_type_filter"] = type;
      }
      if (searchText != null) {
        params["search"] = searchText;
      }

      final response = await MyHttpClient.instance.get(
        ApiEndpoints.myListings,
        params: params,
      );
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          listRequestApiResponse: ApiResponse.completed("done"),
        );

        List temp = response ?? [];
        if (temp.isNotEmpty) {
          final List<ListingModel> list = List.from(
            temp.map((e) => ListingModel.fromJson(e)),
          );
          state = state.copyWith(
            listRequestproducts: skip == 0
                ? list
                : [...state.listRequestproducts!, ...list],
            skip: list.length >= limit ? 1 + limit : 0,
          );
        }
      } else {
        // Show error message if condition is false
        if (skip == 0) {
          Helper.showMessage(
            AppRouter.navKey.currentContext!,
            message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to load list request products. Please try again.",
          );
        }
        state = state.copyWith(
          listRequestApiResponse: skip == 0
              ? ApiResponse.error()
              : ApiResponse.undertermined(),
        );
      }
    } catch (e) {
      // Show error message for exceptions
      if (skip == 0) {
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: "An error occurred while loading list request products. Please try again.",
        );
      }
      state = state.copyWith(
        listRequestApiResponse: skip == 0
            ? ApiResponse.error()
            : ApiResponse.undertermined(),
      );
    }
  }

  FutureOr<void> getListApprovedProducts({
    required int limit,
    required int skip ,
    String? type,
    String? searchText,
  }) async {
    try {
      if (skip == 0 && state.listApprovedproducts!.isNotEmpty) {
        state = state.copyWith(listApprovedproducts: []);
      }
      state = state.copyWith(
        productListingApiResponse: skip == 0
            ? ApiResponse.loading()
            : ApiResponse.loadingMore(),
      );
      Map<String, dynamic> params = {
        "status_filter": "PENDING_MANAGER_REVIEW",
        "skip": skip,
        "limit": limit,
      };
      if (type != null) {
        params["listing_type_filter"] = type;
      }
      if (searchText != null) {
        params["search"] = searchText;
      }
      final response = await MyHttpClient.instance.get(
        ApiEndpoints.myListings,
        params: params,
      );
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          productListingApiResponse: ApiResponse.completed("done"),
        );
        List temp = response ?? [];
        // if (temp.isNotEmpty) {
        final List<ListingModel> list = List.from(
          temp.map((e) => ListingModel.fromJson(e)),
        );
        state = state.copyWith(
          listApprovedproducts: skip == 0
              ? list
              : [...state.listApprovedproducts!, ...list],
          skip: list.length >= limit ? 1 + limit : 0,
        );
        // }
      } else {
        // Show error message if condition is false
        if (skip == 0) {
          Helper.showMessage(
            AppRouter.navKey.currentContext!,
            message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to load approved products. Please try again.",
          );
        }
        state = state.copyWith(
          productListingApiResponse: skip == 0
              ? ApiResponse.error()
              : ApiResponse.undertermined(),
        );
      }
    } catch (e) {
      // Show error message for exceptions
      if (skip == 0) {
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: "An error occurred while loading approved products. Please try again.",
        );
      }
      state = state.copyWith(
        productListingApiResponse: skip == 0
            ? ApiResponse.error()
            : ApiResponse.undertermined(),
      );
    }
  }

  FutureOr<void> getPendingReviewList({
    required int limit,
    required int skip ,
    String? searchText,
    String? type,
  }) async {
    try {
      if (skip == 0 &&
          state.pendingReviewList != null &&
          state.pendingReviewList!.isNotEmpty) {
        state = state.copyWith(pendingReviewList: []);
      }
      state = state.copyWith(
        pendingReviewApiRes: skip == 0
            ? ApiResponse.loading()
            : ApiResponse.loadingMore(),
        listItem: null,
      );
      Map<String, dynamic> params = {"skip": skip, "limit": limit};
      if (type != null) {
        params["listing_type_filter"] = type;
      }
      if (searchText != null) {
        params["search"] = searchText;
      }
      final response = await MyHttpClient.instance.get(
        ApiEndpoints.pendingReview,
        params: params,
      );
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          pendingReviewApiRes: ApiResponse.completed(response),
        );
        List temp = response ?? [];
        // if (temp.isNotEmpty) {
        final List<ListingModel> list = List.from(
          temp.map((e) => ListingModel.fromJson(e)),
        );
        state = state.copyWith(
          pendingReviewList: skip == 0
              ? list
              : [...state.pendingReviewList!, ...list],
          skip: list.length >= limit ? 1 + limit : 0,
        );
        // }
      } else {
        // Show error message if condition is false
        if (skip == 0) {
          Helper.showMessage(
            AppRouter.navKey.currentContext!,
            message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to load pending review list. Please try again.",
          );
        }
        state = state.copyWith(
          pendingReviewApiRes: skip == 0
              ? ApiResponse.error()
              : ApiResponse.undertermined(),
        );
      }
    } catch (e) {
      // Show error message for exceptions
      if (skip == 0) {
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: "An error occurred while loading pending review list. Please try again.",
        );
      }
      state = state.copyWith(
        pendingReviewApiRes: skip == 0
            ? ApiResponse.error()
            : ApiResponse.undertermined(),
      );
    }
  }

  FutureOr<void> getLiveListProducts({
    required int limit,
    required int skip ,
    String? searchText,
    String? type,
  }) async {
    try {
      if (skip == 0 && state.listLiveProducts!.isNotEmpty) {
        state = state.copyWith(listLiveProducts: []);
      }
      state = state.copyWith(
        listLiveApiResponse: skip == 0
            ? ApiResponse.loading()
            : ApiResponse.loadingMore(),
        listItem: null,
      );
      Map<String, dynamic> params = {"skip": skip, "limit": limit};
      if (type != null) {
        params["listing_type_filter"] = type;
      }
      if (searchText != null) {
        params["search"] = searchText;
      }
      final response = await MyHttpClient.instance.get(
        ApiEndpoints.liveList,
        params: params,
      );
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          listLiveApiResponse: ApiResponse.completed(response),
        );
        List temp = response ?? [];
        // if (temp.isNotEmpty) {
        final List<ListingModel> list = List.from(
          temp.map((e) => ListingModel.fromJson(e)),
        );
        state = state.copyWith(
          listLiveProducts: skip == 0
              ? list
              : [...state.listLiveProducts!, ...list],
          skip: list.length >= limit ? 1 + limit : 0,
        );
        // }
      } else {
        // Show error message if condition is false
        if (skip == 0) {
          Helper.showMessage(
            AppRouter.navKey.currentContext!,
            message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to load live products. Please try again.",
          );
        }
        state = state.copyWith(
          listLiveApiResponse: skip == 0
              ? ApiResponse.error()
              : ApiResponse.undertermined(),
        );
      }
    } catch (e) {
      // Show error message for exceptions
      if (skip == 0) {
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: "An error occurred while loading live products. Please try again.",
        );
      }
      state = state.copyWith(
        listLiveApiResponse: skip == 0
            ? ApiResponse.error()
            : ApiResponse.undertermined(),
      );
    }
  }

  FutureOr<void> getSuggestion({
    required int productId,
    required int storeId,
    required ListingModel item,
  }) async {
    try {
      state = state.copyWith(
        getSuggestionApiRes: ApiResponse.loading(),
        listItem: item,
      );
      final response = await MyHttpClient.instance.get(
        ApiEndpoints.suggestionsDiscount,
        params: {"product_id": productId, "store_id": storeId},
      );
      
      // Add condition check
      if (response != null ) {
        final ListingModel item = state.listItem!.copyWith(
          dailyIncreasingDiscountPercent:
              response['daily_increasing_discount_percent'],
          currentDiscount: response['current_discount'],
          saveDiscountForFuture: response['save_discount_for_future'],
          autoApplyForNextBatch: response['auto_apply_for_next_batch'],
        );

        state = state.copyWith(
          getSuggestionApiRes: ApiResponse.completed(response),
          listItem: item,
        );
      } else {
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to get suggestions. Please try again.",
        );
        state = state.copyWith(getSuggestionApiRes: ApiResponse.error());
      }
    } catch (e) {
      // Show error message for exceptions
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: "An error occurred while getting suggestions. Please try again.",
      );
      state = state.copyWith(getSuggestionApiRes: ApiResponse.error());
    }
  }

  FutureOr<void> setReview({
    required Map<String, dynamic> input,
    required int times,
  }) async {
    try {
      state = state.copyWith(setReviewApiRes: ApiResponse.loading());
      final response = await MyHttpClient.instance.post(
        ApiEndpoints.review,
        input,
      );
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        AppRouter.customback(times: times);
        AppRouter.push(SuccessListingRequestView(message: "Listing is Live!"));
      } else {
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to set review. Please try again.",
        );
        state = state.copyWith(setReviewApiRes: ApiResponse.error());
      }
    } catch (e) {
      // Show error message for exceptions
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: "An error occurred while setting review. Please try again.",
      );
      state = state.copyWith(setReviewApiRes: ApiResponse.error());
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
          mySelectedStores: [],
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
        message: "An error occurred while loading stores. Please try again.",
      );
      state = state.copyWith(getStoresApiRes: ApiResponse.error());
    }
  }

  FutureOr<void> updateListRequest({
    required Map<String, dynamic> input,
    required int id,
    required int popTime,
  }) async {
    try {
      state = state.copyWith(listNowApiResponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.put(
        ApiEndpoints.updateEmployeeListRequest(id),
        input,
      );
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        state = state.copyWith(
          listNowApiResponse: ApiResponse.completed(response),
        );
        AppRouter.customback(times: popTime);
        AppRouter.push(
          SuccessListingRequestView(
            message: AppConstant.userType == UserType.employee
                ? "Product Listing Successful!"
                : "Listing Request Sent Successfully!",
          ),
        );
      } else {
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to update list request. Please try again.",
        );
        state = state.copyWith(listNowApiResponse: ApiResponse.error());
      }
    } catch (e) {
      // Show error message for exceptions
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: "An error occurred while updating list request. Please try again.",
      );
      state = state.copyWith(listNowApiResponse: ApiResponse.error());
    }
  }

  FutureOr<void> deleteList({required int listingId}) async {
    try {
      state = state.copyWith(deleteApiRes: ApiResponse.loading());
      final response = await MyHttpClient.instance.delete(
        AppConstant.userType == UserType.employee
            ? "${ApiEndpoints.listings}$listingId"
            : "${ApiEndpoints.listings}manager/$listingId",
        null,
        isJsonEncode: false,
      );
      
      // Add condition check
      if (response != null && !(response is Map && response.containsKey('detail'))) {
        AppRouter.customback(times:2);
        state = state.copyWith(deleteApiRes: ApiResponse.completed(response));
      } else {
        AppRouter.back();
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: (response is Map && response.containsKey('detail')) ? response['detail'] as String : "Failed to delete listing. Please try again.",
        );
        state = state.copyWith(deleteApiRes: ApiResponse.error());
      }
    } catch (e) {
      // Show error message for exceptions
      AppRouter.back();
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: "An error occurred while deleting listing. Please try again.",
      );
      state = state.copyWith(deleteApiRes: ApiResponse.error());
    }
  }

  FutureOr<void> updateList({
    required int listingId,
    required Map<String, dynamic> input,
  }) async {
    try {
      state = state.copyWith(updateApiRes: ApiResponse.loading());
      final Map<String, dynamic>? response = await MyHttpClient.instance.put(
        AppConstant.userType == UserType.employee
            ? "${ApiEndpoints.listings}$listingId"
            : "${ApiEndpoints.listings}manager/$listingId",
        input,
      );
      
      // Add condition check
      if (response != null && !response.containsKey('detail')) {
        ListingModel data = ListingModel.fromJson(response);
        state = state.copyWith(updateApiRes: ApiResponse.completed(response), listItem: data);
        
        if (AppConstant.userType == UserType.manager) {
          AppRouter.customback(times: 2); 
        } else {
          AppRouter.customback(times: 2);
          AppRouter.push(
            SuccessListingRequestView(
              message: "Product Listing Edit Successful!",
            ),
          );
        }
      } else {
        // Show error message if condition is false
        Helper.showMessage(
          AppRouter.navKey.currentContext!,
          message: response?.containsKey('detail') == true ? response!['detail'] as String : "Failed to update listing. Please try again.",
        );
        state = state.copyWith(updateApiRes: ApiResponse.error());
      }
    } catch (e) {
      // Show error message for exceptions
      Helper.showMessage(
        AppRouter.navKey.currentContext!,
        message: "An error occurred while updating the listing. Please try again.",
      );
      state = state.copyWith(updateApiRes: ApiResponse.error());
    }
  }
}

final productProvider =
    NotifierProvider.autoDispose<ProductProvider, ProductState>(
      ProductProvider.new,
    );
