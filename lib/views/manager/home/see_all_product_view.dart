import 'package:push_price_manager/export_all.dart';

class SeeAllProductView extends ConsumerStatefulWidget {
  final String title;
  // final VoidCallback onTap;
  final VoidCallback initFunCall;
  final VoidCallback onMoreFunCall;
  const SeeAllProductView({super.key, required this.title, required this.initFunCall, required this.onMoreFunCall });

  @override
  ConsumerState<SeeAllProductView> createState() => _SeeAllProductViewState();
}

class _SeeAllProductViewState extends ConsumerState<SeeAllProductView> {
  late final ScrollController _scrollController;
  @override
  void initState() {
   
    super.initState();
    _scrollController = ScrollController();
    Future.microtask((){
      widget.initFunCall;
    });
  }
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: widget.title, 
    child: GridView.builder(
      controller: _scrollController,
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
                            if(widget.title ==  "Listing Request"){
                              // AppRouter.push(
                            //  ListingProductDetailView(isRequest: true, type: setType(index),));
                       
                            }
                            else if(widget.title == "Product Listings"){
                  //              AppRouter.push(PendingProductDetailView(
                  //   type: setType(index),
                  // ));
                            }
                            else if(widget.title == "Pending Listings"){
                  //              AppRouter.push(PendingProductDetailView(
                  //   type: setType(index),
                  // ));
                            }
                            else{
        //                          AppRouter.push(ProductLiveListingDetailView(
        //   type: setType(index),
        //  ));
                            }
                          },
                          child: 
                          SizedBox.shrink()
                          // ProductDisplayBoxWidget()
                          ));
                },
              ),
           
           );
  }
}