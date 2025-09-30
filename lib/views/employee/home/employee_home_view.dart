import 'package:push_price_manager/utils/extension.dart';
import '../../../services/product_service.dart';
import '../../manager/listing_request/listing_request_view.dart';

import '../../../export_all.dart';

class EmployeeHomeView extends StatefulWidget {
  final ScrollController scrollController;
  const EmployeeHomeView({super.key, required this.scrollController});

  @override
  State<EmployeeHomeView> createState() => _EmployeeHomeViewState();
}

class _EmployeeHomeViewState extends State<EmployeeHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: context.screenheight * 0.15,
        title: "Home",
        children: [
          Row(
            children: [
              UserProfileWidget(radius: 18.r, imageUrl: Assets.userImage, borderWidth: 1.4,),
              10.pw,
              Expanded(child: Text("GROCERY STORE", style: context.textStyle.displayMedium,)),
            
              CustomButtonWidget(
                height: 30.h,
                width: 110.w,
                title: "", onPressed: (){
                  AppRouter.push(ListingRequestView());
                }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text("List Product", style: context.textStyle.bodySmall!.copyWith(
                    color: Colors.white
                  ),)
                ],
              ),)
            ],
          )
          ],
      ),
      body: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        controller: widget.scrollController,
        children: [
          ListingRequestSection(),
          30.ph,
          ProductListingSection()
        ],
      ),
    );
  }
}

class ListingRequestSection extends StatefulWidget {
  const ListingRequestSection({
    super.key,
  });

  @override
  State<ListingRequestSection> createState() => _ListingRequestSectionState();
}

class _ListingRequestSectionState extends State<ListingRequestSection> {
  List<ProductSelectionDataModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final productSelectionModels = await ProductService.getProductSelectionModels();
      setState(() {
        products = productSelectionModels.take(4).toList(); // Show first 4 products
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Listing Request", style: context.textStyle.displayMedium,),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: (){
                  AppRouter.push(SeeAllProductView(title: "Listing Request"
                  // ,onTap: (){
                            
                  //           AppRouter.push(
                  //            ListingProductDetailView(isRequest: true, type: setType(-1),));
                  //         },
                          ));
                }, child: Text("See All", style:   context.textStyle.displayMedium!.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline
              ),))
            ],
          ),
          SizedBox(
                    height: 125.h,
                    child: isLoading 
                      ? Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index)=>GestureDetector(
                            onTap: (){
                              AppRouter.push( ListingProductDetailView(isRequest: true, type:setType(index), product: products[index]));
                            },
                            child: ProductDisplayBoxWidget(product: products[index])), 
                          separatorBuilder: (context, index)=> 10.pw, 
                          itemCount: products.length),
                        )
        ],
    );
  }
}

class ProductListingSection extends StatefulWidget {
  const ProductListingSection({
    super.key,
  });

  @override
  State<ProductListingSection> createState() => _ProductListingSectionState();
}

class _ProductListingSectionState extends State<ProductListingSection> {
  List<ProductSelectionDataModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final productSelectionModels = await ProductService.getProductSelectionModels();
      setState(() {
        products = productSelectionModels.skip(1).take(4).toList(); // Show different products
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Product Listings", style: context.textStyle.displayMedium,),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: (){
                  AppRouter.push(SeeAllProductView(title: "Product Listings"
                  // , onTap: (){
                  //           AppRouter.push(PendingProductDetailView(
                  //   type: "Best By Products",
                  // ));
                  //           // AppRouter.push(
                  //           // ListingProductDetailView());
                  //         },
                          ));
                }, child: Text("See All", style:   context.textStyle.displayMedium!.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline
              ),))
            ],
          ),
          SizedBox(
                    height: 125.h,
                    child: isLoading 
                      ? Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index)=>GestureDetector(
                            onTap: (){
                               AppRouter.push(PendingProductDetailView(
                        type: setType(index),
                        product: products[index],
                      ));
                            },
                            child: ProductDisplayBoxWidget(product: products[index])), 
                          separatorBuilder: (context, index)=> 10.pw, 
                          itemCount: products.length),
                        )
        ],
    );
  }
}



String setType(int index){
  switch (index) {
    case 0:
     return "Best By Products";
    case 1:
    return "Instant Sales";
    case 2:
    return "Weighted Items";
    case 3:
    return "Promotional Products"; 
    default: 
    return "Best By Products";

  }
}
  // List<String> types = [
  //   "Best By Products",
  //   "Instant Sales",
  //   "Weighted Items",
  //   "Promotional Products"
  // ];