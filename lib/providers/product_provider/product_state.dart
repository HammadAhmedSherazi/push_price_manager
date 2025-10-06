import 'package:push_price_manager/data/network/api_response.dart';
import '../../export_all.dart';

class ProductState {
  final ApiResponse productApiResponse;
  final List<ProductDataModel>? products;
  final String? searchText;
  final int? offset;
  ProductState({required this.productApiResponse, this.products , this.searchText, this.offset });

  ProductState copyWith({ApiResponse? productApiResponse,List<ProductDataModel>? products,String? searchText, int? offset})=> ProductState(productApiResponse:productApiResponse ?? this.productApiResponse, products: products ?? this.products, offset: offset ?? this.offset,searchText:  searchText ?? this.searchText );

}