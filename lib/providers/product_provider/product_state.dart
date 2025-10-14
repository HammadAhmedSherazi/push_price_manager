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
  final ApiResponse deleteApiRes;
  final ApiResponse updateApiRes;
  final ApiResponse listLiveApiResponse;

  final ApiResponse<ProductDataModel> getProductReponse;
  final List<ProductDataModel>? products;
  final List<ListingModel>? listRequestproducts;
  final List<ListingModel>? listApprovedproducts;
  final List<ListingModel>? listLiveProducts;
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

    required this.updateApiRes,
    required this.deleteApiRes,
    required this.listLiveApiResponse,
    this.listApprovedproducts,
    this.listRequestproducts,
    this.listLiveProducts,
    this.pendingReviewList,
    this.listItem,
    this.skip,
    this.myStores,
    this.mySelectedStores
  });

  ProductState copyWith({
    ApiResponse? listRequestApiResponse,
    ApiResponse? listLiveApiResponse,
    ApiResponse? productListingApiResponse,
    ApiResponse? productApiResponse,
    ApiResponse? pendingReviewApiRes,
    ApiResponse? getSuggestionApiRes,
    ApiResponse? setReviewApiRes,

    ApiResponse? deleteApiRes,
    ApiResponse? updateApiRes,
    List<ProductDataModel>? products,
    String? searchText,
    int? skip,
    ApiResponse<ProductDataModel>? getProductReponse,
    ApiResponse? listNowApiResponse,
    List<ListingModel>? listRequestproducts,
    List<ListingModel>? listApprovedproducts,
    List<ListingModel>? pendingReviewList,
    List<ListingModel>? listLiveProducts,
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
    myStores: myStores ?? this.myStores,
    mySelectedStores: mySelectedStores ?? this.mySelectedStores,
    updateApiRes: updateApiRes ?? this.updateApiRes,
    deleteApiRes: deleteApiRes ?? this.deleteApiRes,
    listLiveApiResponse: listLiveApiResponse ?? this.listLiveApiResponse,
    listLiveProducts: listLiveProducts ?? this.listLiveProducts
    
    
  );
}
