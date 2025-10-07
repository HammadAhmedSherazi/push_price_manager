import 'dart:async';

import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/providers/product_provider/product_state.dart';

class ProductProvider extends Notifier<ProductState> {
  @override
  ProductState build() {
    return ProductState(productApiResponse: ApiResponse.undertermined(),products: [], getProductReponse: ApiResponse.loading());
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

  
}

final productProvider = NotifierProvider.autoDispose<ProductProvider, ProductState>(
  ProductProvider.new,
);