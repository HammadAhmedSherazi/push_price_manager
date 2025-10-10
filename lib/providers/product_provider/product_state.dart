import 'package:push_price_manager/data/network/api_response.dart';
import '../../export_all.dart';

class ProductState {
  final ApiResponse productApiResponse;
  final ApiResponse listNowApiResponse;
  final ApiResponse listRequestApiResponse;
  final ApiResponse productListingApiResponse;
  final ApiResponse getSuggestionApiRes;
  final ApiResponse pendingReviewApiRes;
  final ApiResponse setReviewApiRes;
  final ApiResponse getStoresApiRes;

  final ApiResponse<ProductDataModel> getProductReponse;
  final List<ProductDataModel>? products;
  final List<ListingModel>? listRequestproducts;
  final List<ListingModel>? listApprovedproducts;
  final List<ListingModel>? pendingReviewList;
  final List<StoreSelectDataModel>? myStores;
  final String? searchText;
  // final int? offset;
  final List<StoreSelectDataModel>? mySelectedStores;
  final ListingModel? listItem;
  final int? skip;
  ProductState({
    required this.productApiResponse,
    this.products,
    this.searchText,
    // this.offset,
    required this.getProductReponse,
    required this.listNowApiResponse,
    required this.listRequestApiResponse,
    required this.productListingApiResponse,
    required this.pendingReviewApiRes,
    required this.getSuggestionApiRes,
    required this.setReviewApiRes,
    required this.getStoresApiRes,

    this.listApprovedproducts,
    this.listRequestproducts,
    this.pendingReviewList,
    this.listItem,
    this.skip,
    this.myStores,
    this.mySelectedStores
  });

  ProductState copyWith({
    ApiResponse? listRequestApiResponse,
    ApiResponse? productListingApiResponse,
    ApiResponse? productApiResponse,
    ApiResponse? pendingReviewApiRes,
    ApiResponse? getSuggestionApiRes,
    ApiResponse? setReviewApiRes,
    ApiResponse? getStoresApiRes,
    List<ProductDataModel>? products,
    String? searchText,
    int? skip,
    ApiResponse<ProductDataModel>? getProductReponse,
    ApiResponse? listNowApiResponse,
    List<ListingModel>? listRequestproducts,
    List<ListingModel>? listApprovedproducts,
    List<ListingModel>? pendingReviewList,
    List<StoreSelectDataModel>? myStores,
    List<StoreSelectDataModel>? mySelectedStores,
    ListingModel? listItem,
    
  }) => ProductState(
    getSuggestionApiRes: getSuggestionApiRes ?? this.getSuggestionApiRes,
    productApiResponse: productApiResponse ?? this.productApiResponse,
    products: products ?? this.products,
    skip: skip ?? this.skip,
    // offset: offset ?? this.offset,
    searchText: searchText ?? this.searchText,
    getProductReponse: getProductReponse ?? this.getProductReponse,
    listNowApiResponse: listNowApiResponse ?? this.listNowApiResponse,
    listRequestApiResponse: listRequestApiResponse ?? this.listRequestApiResponse,
    productListingApiResponse: productListingApiResponse ?? this.productListingApiResponse,
    listApprovedproducts: listApprovedproducts ?? this.listApprovedproducts,
    listRequestproducts: listRequestproducts ?? this.listRequestproducts,
    pendingReviewApiRes: pendingReviewApiRes ?? this.pendingReviewApiRes,
    pendingReviewList: pendingReviewList ?? this.pendingReviewList,
    listItem: listItem ?? this.listItem,
    setReviewApiRes: setReviewApiRes ?? this.setReviewApiRes,
    getStoresApiRes:  getStoresApiRes ?? this.getStoresApiRes,
    myStores: myStores ?? this.myStores,
    mySelectedStores: mySelectedStores ?? this.mySelectedStores,
    
  );
}
