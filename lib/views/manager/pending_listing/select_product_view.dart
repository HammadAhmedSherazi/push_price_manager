import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class SelectProductView extends StatefulWidget {
  final bool ? isInstant;
  const SelectProductView({super.key, this.isInstant = false});

  @override
  State<SelectProductView> createState() => _SelectProductViewState();
}

class _SelectProductViewState extends State<SelectProductView> {
  List<ProductSelectionDataModel> recentStores = List.generate(
    2,
    (index) => ProductSelectionDataModel(
      title: "ABC Store",
      description: "Abc Category",
      image: Assets.groceryBag, isSelect: false,
      
    ),
  );
  List<ProductSelectionDataModel> selectedProducts = [];
  addSelectProduct(int index) {
    final product = recentStores[index];
    setState(() {
      selectedProducts.add(product.copyWith(isSelect: true));
    recentStores.removeAt(index);
    });
  }
  removeProduct(int index){
    final product = selectedProducts[index];
    setState(() {
      recentStores.add(product.copyWith(isSelect: false));
    selectedProducts.removeAt(index);
    });
  }
  late TextEditingController searchTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      title: "Select Product",
      showBottomButton: true,
      onButtonTap: (){
        AppRouter.customback(
                times: widget.isInstant! ? 5 : 4
              );
        AppRouter.push(SuccessListingRequestView(message: "Listing is Live!"));
      },
      bottomButtonText: "list now",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppTheme.horizontalPadding),
            child: CustomSearchBarWidget(hintText: "Hinted search text", controller: searchTextEditController, onChanged: (v){
              setState(() {
                
              });
            },),
          ),
          if (selectedProducts.isNotEmpty && searchTextEditController.text == "") ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding,
              ),
              child: Text("Selected", style: context.textStyle.displayMedium),
            ),
            10.ph,
            SizedBox(
              height: context.screenheight * 0.179,
              width: context.screenwidth,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.horizontalPadding,
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  // item height (since scrolling is horizontal)
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.93,
                  maxCrossAxisExtent: 200,
                ),
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ProductDisplayBoxWidget()),
                        Positioned(
                      right: 0,
                      child: Checkbox(
                        activeColor: AppColors.secondaryColor,
                        shape: CircleBorder(
                          
                        ),
                        side: BorderSide(
                          color: AppColors.secondaryColor
                        ),
                        value: selectedProducts[index].isSelect, onChanged: (value){
                          removeProduct(index);
                        }))
                    ],
                  );
                },
              ),
            ),
            10.ph,
          ],
          if(recentStores.isNotEmpty )...[
            Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding,
            ),
            child: Text(searchTextEditController.text == ""? "Recent" : "Search Result", style: context.textStyle.displayMedium),
          ),
          10.ph,
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio:
                    1.09, // Adjust if you want different box shapes
              ),
              itemCount: recentStores.length, // Set how many items you want
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ProductDisplayBoxWidget()),
                    Positioned(
                      right: 0,
                      child: Checkbox(
                        shape: CircleBorder(
                          
                        ),
                         activeColor: AppColors.secondaryColor,
                        side: BorderSide(
                          color: AppColors.secondaryColor
                        ),
                        value: recentStores[index].isSelect, onChanged: (value){
                          addSelectProduct(index);
                        }))
                  ],
                );
              },
            ),
          ),
          ],

          
        ],
      ),
    );
  }


}