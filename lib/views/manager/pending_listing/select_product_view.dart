import 'package:push_price_manager/utils/extension.dart';
import '../../../services/product_service.dart';

import '../../../export_all.dart';

class SelectProductView extends StatefulWidget {
  final bool ? isInstant;
  const SelectProductView({super.key, this.isInstant = false});

  @override
  State<SelectProductView> createState() => _SelectProductViewState();
}

class _SelectProductViewState extends State<SelectProductView> {
  List<ProductSelectionDataModel> recentStores = [];
  List<ProductSelectionDataModel> selectedProducts = [];
  List<ProductSelectionDataModel> filteredProducts = [];
  bool isLoading = true;
  
  late TextEditingController searchTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
    searchTextEditController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchTextEditController.removeListener(_onSearchChanged);
    searchTextEditController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final productSelectionModels = await ProductService.getProductSelectionModels();
      setState(() {
        recentStores = productSelectionModels;
        filteredProducts = productSelectionModels;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    final query = searchTextEditController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredProducts = recentStores.where((product) => !selectedProducts.any((selected) => selected.title == product.title)).toList();
      } else {
        filteredProducts = recentStores.where((product) => 
          product.title.toLowerCase().contains(query) &&
          !selectedProducts.any((selected) => selected.title == product.title)
        ).toList();
      }
    });
  }

  addSelectProduct(int index) {
    final product = filteredProducts[index];
    setState(() {
      selectedProducts.add(product.copyWith(isSelect: true));
      filteredProducts.removeAt(index);
    });
  }
  
  removeProduct(int index){
    final product = selectedProducts[index];
    setState(() {
      filteredProducts.add(product.copyWith(isSelect: false));
      selectedProducts.removeAt(index);
    });
  }

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
            },onTapOutside: (v){
               FocusScope.of(context).unfocus();
              
            }),
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
                        child: ProductDisplayBoxWidget(product: selectedProducts[index])),
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
          if(isLoading) 
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if(filteredProducts.isNotEmpty) ...[
            Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding,
            ),
            child: Text(searchTextEditController.text == ""? "Available Products" : "Search Result", style: context.textStyle.displayMedium),
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
              itemCount: filteredProducts.length, // Set how many items you want
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ProductDisplayBoxWidget(product: filteredProducts[index])),
                    Positioned(
                      right: 0,
                      child: Checkbox(
                        shape: CircleBorder(
                          
                        ),
                         activeColor: AppColors.secondaryColor,
                        side: BorderSide(
                          color: AppColors.secondaryColor
                        ),
                        value: filteredProducts[index].isSelect, onChanged: (value){
                          addSelectProduct(index);
                        }))
                  ],
                );
              },
            ),
          ),
          ]
          else ...[
            Expanded(
              child: Center(
                child: Text(
                  "No products found", 
                  style: context.textStyle.bodyMedium
                )
              )
            )
          ]

          
        ],
      ),
    );
  }


}