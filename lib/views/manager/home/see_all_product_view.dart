import 'package:push_price_manager/export_all.dart';

class SeeAllProductView extends StatelessWidget {
  final String title;
  // final VoidCallback onTap;
  const SeeAllProductView({super.key, required this.title, });

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: title, child: GridView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.horizontalPadding,
                  vertical: AppTheme.horizontalPadding
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  // item height (since scrolling is horizontal)
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.999,
                  maxCrossAxisExtent: 200,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: GestureDetector(
                          onTap: (){
                            if(title ==  "Listing Request"){
                              // AppRouter.push(
                            //  ListingProductDetailView(isRequest: true, type: setType(index),));
                       
                            }
                            else if(title == "Product Listings"){
                               AppRouter.push(PendingProductDetailView(
                    type: setType(index),
                  ));
                            }
                            else if(title == "Pending Listings"){
                               AppRouter.push(PendingProductDetailView(
                    type: setType(index),
                  ));
                            }
                            else{
                                 AppRouter.push(ProductLiveListingDetailView(
          type: setType(index),
         ));
                            }
                          },
                          child: ProductDisplayBoxWidget()));
                },
              ),
           );
  }
}