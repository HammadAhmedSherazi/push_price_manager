import 'dart:async';

import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/providers/product_provider/product_state.dart';

class ProductProvider extends Notifier<ProductState> {
  @override
  ProductState build() {
    return ProductState(productApiResponse: ApiResponse.undertermined(),products: [], getProductReponse: ApiResponse.loading(), listNowApiResponse: ApiResponse.undertermined(),listRequestApiResponse: ApiResponse.undertermined(),productListingApiResponse: ApiResponse.undertermined(), pendingReviewApiRes: ApiResponse.undertermined());
  }

  FutureOr<void> getProductfromDatabase({required int limit, required int offset ,  String? searchText })async{
    if(offset == 0 && state.products!.isNotEmpty){
      state = state.copyWith(products: []);
    }
    Map<String, dynamic> params ={
        'limit' : limit,
        'skip' : offset
    };
    if(searchText != null){
      params['search_term'] = searchText;
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
      state = state.copyWith(productApiResponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.get(ApiEndpoints.getDataBaseProducts,params: params);
     if (!ref.mounted) return;
     if(response != null){
        List temp = response ?? [];
     
        state = state.copyWith(productApiResponse: ApiResponse.completed(response),
        products:  offset == 0 && state.products!.isEmpty ? List.from(temp.map((e)=>ProductDataModel.fromJson(e))):[...state.products!, ...List.from(temp.map((e)=>ProductDataModel.fromJson(e)))]  
        );

      }
      else{
        // state = state.copyWith(productApiResponse: ApiResponse.error());
      }
    } catch (e) {
      state = state.copyWith(productApiResponse: ApiResponse.error());
    }
  }

  FutureOr<void> getProductData(String code)async{
    try {
      state = state.copyWith(getProductReponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.get("${ApiEndpoints.getProductDetailByBarCode}$code");
      AppRouter.back();
      if(response != null){
        state = state.copyWith(getProductReponse: ApiResponse.completed(ProductDataModel.fromJson(response)));
        AppRouter.push(ScanProductView(data: state.getProductReponse.data!,));
      }
      else{
        state = state.copyWith(getProductReponse: ApiResponse.error());
      }
    } catch (e) {
      AppRouter.back();
      state = state.copyWith(getProductReponse: ApiResponse.error());
    }
  }

  FutureOr<void> listNow({required Map<String, dynamic> input, required int popTime})async{
    try {
      state = state.copyWith(listNowApiResponse:ApiResponse.loading());
      final response = await MyHttpClient.instance.post(ApiEndpoints.listings, input);
      if(response != null){
        state = state.copyWith(listNowApiResponse:ApiResponse.completed(response));
         AppRouter.customback(times: popTime);
              AppRouter.push(
                SuccessListingRequestView(message: "Product Listing Successful!"),
              );
      }
      else{
        state = state.copyWith(listNowApiResponse:ApiResponse.error());
      }
    } catch (e) {
      state = state.copyWith(listNowApiResponse:ApiResponse.error());
    }
  }

  FutureOr<void> getListRequestProducts({required int limit,  int skip = 0, String? type})async{
    try {
      if(skip == 0 && state.listRequestproducts!.isNotEmpty){
        state = state.copyWith(listRequestproducts: []);
      }
      state = state.copyWith(listRequestApiResponse:  ApiResponse.loading());
      final response = await MyHttpClient.instance.get(ApiEndpoints.myListings,params: {
        "status_filter" : "PENDING_MANAGER_REVIEW",
        "skip" : skip,
        "limit" : limit
      });
      if(response != null){
        state = state.copyWith(listRequestApiResponse:  ApiResponse.completed("done"));
        List temp = response ?? [];
        if(temp.isNotEmpty)
        {
          state = state.copyWith(listRequestproducts:skip == 0? List.from(temp.map((e)=>ProductDataModel.fromJson(e['product']))): [...state.listRequestproducts!, ... List.from(temp.map((e)=>ProductDataModel.fromJson(e['product'])))]);
        }

      }
      else{
        state = state.copyWith(listRequestApiResponse:  ApiResponse.error());
      }
    } catch (e) {
        state = state.copyWith(listRequestApiResponse:  ApiResponse.error());
      
    }
  }

  FutureOr<void> getListApprovedProducts({required int limit, int skip=0, String? type})async{
    try {
      if(skip == 0 && state.listApprovedproducts!.isNotEmpty){
        state = state.copyWith(listRequestproducts: []);
      }
      state = state.copyWith(productListingApiResponse:  ApiResponse.loading());
      final response = await MyHttpClient.instance.get(ApiEndpoints.myListings,params: {
        "status_filter" : "APPROVED",
        "skip" : skip,
        "limit" : limit
      });
      if(response != null){
        state = state.copyWith( productListingApiResponse:  ApiResponse.completed("done"));
        List temp = response ?? [];
        if(temp.isNotEmpty)
        {
          state = state.copyWith(listApprovedproducts:skip == 0? List.from(temp.map((e)=>ProductDataModel.fromJson(e['product']))): [...state.listApprovedproducts!, ... List.from(temp.map((e)=>ProductDataModel.fromJson(e['product'])))]);
        }

      }
      else{
        state = state.copyWith(productListingApiResponse:  ApiResponse.error());
      }
    } catch (e) {
        state = state.copyWith(productListingApiResponse:  ApiResponse.error());
      
    }
  }
  
  FutureOr<void> getPendingReviewList({required int limit, int skip=0})async{
    try {
      if(skip == 0 && state.pendingReviewList != null && state.pendingReviewList!.isNotEmpty){
        state = state.copyWith(pendingReviewList: []);
      }
      state = state.copyWith(pendingReviewApiRes: ApiResponse.loading(), );
      final response = await MyHttpClient.instance.get(ApiEndpoints.pendingReview);
      if(response != null){
      state = state.copyWith(pendingReviewApiRes: ApiResponse.completed(response));
      List temp = response ?? [];
      if(temp.isNotEmpty){
        final List<ListingModel> list = List.from(temp.map((e)=>ListingModel.fromJson(e)));
        state = state.copyWith(pendingReviewList: skip == 0? list: [...state.pendingReviewList!, ...list]);
      }

      }
      else{
      state = state.copyWith(pendingReviewApiRes: ApiResponse.error());

      }
    } catch (e) {
      state = state.copyWith(pendingReviewApiRes: ApiResponse.error());
    } 

  }
}

final productProvider = NotifierProvider.autoDispose<ProductProvider, ProductState>(
  ProductProvider.new,
);