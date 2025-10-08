import 'package:push_price_manager/data/network/api_response.dart';
import '../../export_all.dart';

class ProductState {
  final ApiResponse productApiResponse;
  final ApiResponse listNowApiResponse;
  final ApiResponse listRequestApiResponse;
  final ApiResponse productListingApiResponse;
  final ApiResponse pendingReviewApiRes;

  final ApiResponse<ProductDataModel> getProductReponse;
  final List<ProductDataModel>? products;
  final List<ProductDataModel>? listRequestproducts;
  final List<ProductDataModel>? listApprovedproducts;
  final List<ListingModel>? pendingReviewList;
  final String? searchText;
  final int? offset;
  ProductState({
    required this.productApiResponse,
    this.products,
    this.searchText,
    this.offset,
    required this.getProductReponse,
    required this.listNowApiResponse,
    required this.listRequestApiResponse,
    required this.productListingApiResponse,
    required this.pendingReviewApiRes,
    this.listApprovedproducts,
    this.listRequestproducts,
    this.pendingReviewList,
  });

  ProductState copyWith({
    ApiResponse? listRequestApiResponse,
    ApiResponse? productListingApiResponse,
    ApiResponse? productApiResponse,
    ApiResponse? pendingReviewApiRes,
    List<ProductDataModel>? products,
    String? searchText,
    int? offset,
    ApiResponse<ProductDataModel>? getProductReponse,
    ApiResponse? listNowApiResponse,
    List<ProductDataModel>? listRequestproducts,
    List<ProductDataModel>? listApprovedproducts,
    List<ListingModel>? pendingReviewList
  }) => ProductState(
    productApiResponse: productApiResponse ?? this.productApiResponse,
    products: products ?? this.products,
    offset: offset ?? this.offset,
    searchText: searchText ?? this.searchText,
    getProductReponse: getProductReponse ?? this.getProductReponse,
    listNowApiResponse: listNowApiResponse ?? this.listNowApiResponse,
    listRequestApiResponse: listRequestApiResponse ?? this.listRequestApiResponse,
    productListingApiResponse: productListingApiResponse ?? this.productListingApiResponse,
    listApprovedproducts: listApprovedproducts ?? this.listApprovedproducts,
    listRequestproducts: listRequestproducts ?? this.listRequestproducts,
    pendingReviewApiRes: pendingReviewApiRes ?? this.pendingReviewApiRes,
    pendingReviewList: pendingReviewList ?? this.pendingReviewList
  );
}
