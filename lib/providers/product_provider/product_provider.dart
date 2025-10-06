import 'dart:async';

import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/providers/product_provider/product_state.dart';

class ProductProvider extends Notifier<ProductState> {
  @override
  ProductState build() {
    return ProductState(productApiResponse: ApiResponse.undertermined(),products: []);
  }

  FutureOr<void> getProductfromDatabase({required int limit, required int offset ,  String? searchText, num? minPrice, num ? maxPrice, int? categoryId })async{
    if(offset == 0 && state.products!.isNotEmpty){
      state = state.copyWith(products: []);
    }
    Map<String, dynamic> params ={
        'limit' : limit,
        'offset' : offset
    };
    if(searchText != null){
      params['search_term'] = searchText;
    } 
    if(minPrice != null){
      params['min_price'] = minPrice;
    }
    if(maxPrice != null){
      params['max_price'] = maxPrice;
    }
    if(categoryId != null){
      params['category_id'] = categoryId;
    }
    

    
    try {
      state = state.copyWith(productApiResponse: ApiResponse.loading());
      final response = await MyHttpClient.instance.get(ApiEndpoints.getProducts,params: params);
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

  
}

final productProvider = NotifierProvider.autoDispose<ProductProvider, ProductState>(
  ProductProvider.new,
);