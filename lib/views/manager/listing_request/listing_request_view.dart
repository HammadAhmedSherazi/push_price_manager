import 'package:push_price_manager/utils/extension.dart';
import '../../../services/product_service.dart';

import '../../../export_all.dart';

class ListingRequestView extends StatefulWidget {
  const ListingRequestView({super.key});

  @override
  State<ListingRequestView> createState() => _ListingRequestViewState();
}

class _ListingRequestViewState extends State<ListingRequestView> {
  List<RealProductDataModel> products = [];
  List<RealProductDataModel> filteredProducts = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final allProducts = await ProductService.getAllProducts();
      setState(() {
        products = allProducts;
        filteredProducts = allProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredProducts = products;
      } else {
        filteredProducts = products.where((product) {
          return product.item.toLowerCase().contains(query.toLowerCase()) ||
                 product.category?.toLowerCase().contains(query.toLowerCase()) == true ||
                 product.description?.toLowerCase().contains(query.toLowerCase()) == true;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "scan",
      onButtonTap: (){
        AppRouter.push(ScanView());
      },
      title: AppConstant.userType == UserType.employee? "Search From Database": "Listing Request - Select Product", 
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppTheme.horizontalPadding), 
            child: CustomSearchBarWidget(
              onTapOutside: (v){
                FocusScope.of(context).unfocus();
              },
              hintText: "Search products...",
              suffixIcon: SvgPicture.asset(Assets.filterIcon),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: isLoading 
              ? Center(child: CircularProgressIndicator())
              : filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        SizedBox(height: 16),
                        Text(
                          searchQuery.isNotEmpty 
                            ? "No products found for '$searchQuery'"
                            : "No products available",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
                    itemBuilder: (context, index) => ProductDisplayWidget(
                      product: filteredProducts[index].toProductSelectionDataModel(),
                      onTap: (){
                        AppRouter.push(
                          ListingProductDetailView(
                            type: "Best By Products", // Default type, can be made dynamic
                            product: filteredProducts[index].toProductSelectionDataModel(),
                          )
                        );
                      },
                    ), 
                    separatorBuilder: (context, index) => 10.ph, 
                    itemCount: filteredProducts.length
                  )
          )
        ],
      )
    );
  }
}
