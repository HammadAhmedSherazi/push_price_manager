import 'package:push_price_manager/utils/extension.dart';
import '../../../services/product_service.dart';
import '../../../export_all.dart';


class HomeView extends StatefulWidget {
  final ScrollController scrollController;
  const HomeView({super.key, required this.scrollController});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

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
              Text("GROCERY STORE", style: context.textStyle.displayMedium,),
              Spacer(),
              CustomButtonWidget(
                height: 30.h,
                width: 120.w,
                title: "", onPressed: (){
                  AppRouter.push(ListingRequestView());
                }, child: Row(
                children: [
                  Icon(Icons.add),
                  Text("Listing Request", style: context.textStyle.bodySmall!.copyWith(
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
          PendingListingSection(),
          30.ph,
          LiveListingSection()
        ],
      ),
    );
  }
}

class PendingListingSection extends StatefulWidget {
  const PendingListingSection({
    super.key,
  });

  @override
  State<PendingListingSection> createState() => _PendingListingSectionState();
}

class _PendingListingSectionState extends State<PendingListingSection> {
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
        products = productSelectionModels.take(5).toList(); // Show first 5 products
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
              Text("Pending Listings", style: context.textStyle.displayMedium,),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: (){
                  AppRouter.push(SeeAllProductView(title: "Pending Listings"
                //   , onTap: (){
                //   AppRouter.push(PendingProductDetailView(
                //     type: "Best By Products",
                //   ));
                // },
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
                        type: "Best By Products",
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

class LiveListingSection extends StatefulWidget {
  const LiveListingSection({
    super.key,
  });

  @override
  State<LiveListingSection> createState() => _LiveListingSectionState();
}

class _LiveListingSectionState extends State<LiveListingSection> {
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
        products = productSelectionModels.skip(2).take(5).toList(); // Show different products for variety
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
              Text("Live Listings", style: context.textStyle.displayMedium,),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: (){
                  AppRouter.push(SeeAllProductView(title: "Live Listings"
        //           , onTap: (){
        //            AppRouter.push(ProductLiveListingDetailView(
        //   type: "Best By Products",
        //  ));
        //         }
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
                              AppRouter.push(ProductLiveListingDetailView(
              type: "Best By Products",
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



