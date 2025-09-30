import 'package:push_price_manager/export_all.dart';
import '../../../services/product_service.dart';

class SeeAllProductView extends StatefulWidget {
  final String title;
  // final VoidCallback onTap;
  const SeeAllProductView({super.key, required this.title, });

  @override
  State<SeeAllProductView> createState() => _SeeAllProductViewState();
}

class _SeeAllProductViewState extends State<SeeAllProductView> {
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
        products = productSelectionModels;
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
    return CustomScreenTemplate(
      title: widget.title, 
      child: isLoading 
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding,
              vertical: AppTheme.horizontalPadding
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.999,
              maxCrossAxisExtent: 200,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: GestureDetector(
                      onTap: (){
                        if(widget.title ==  "Listing Request"){
                          AppRouter.push(
                         ListingProductDetailView(isRequest: true, type: setType(index), product: products[index]));
                   
                        }
                        else if(widget.title == "Product Listings"){
                           AppRouter.push(ListingProductDetailView(
                  type: setType(index),
                  product: products[index],
                  source: "product_listing",
                ));
                        }
                        else if(widget.title == "Pending Listings"){
                           AppRouter.push(PendingProductDetailView(
                  type: setType(index),
                  product: products[index],
                ));
                        }
                        else{
                             AppRouter.push(ProductLiveListingDetailView(
            type: setType(index),
            product: products[index],
           ));
                        }
                      },
                      child: ProductDisplayBoxWidget(product: products[index])));
            },
          ),
         );
  }
}