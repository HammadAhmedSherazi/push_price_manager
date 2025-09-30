import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class SelectStoreView extends StatefulWidget {
  const SelectStoreView({super.key});

  @override
  State<SelectStoreView> createState() => _SelectStoreViewState();
}

class _SelectStoreViewState extends State<SelectStoreView> {
  List<StoreSelectDataModel> recentStores = List.generate(
    2,
    (index) => StoreSelectDataModel(
      title: "Store ${index + 1}",
      address: "",
      rating: 4.0,
      icon: Assets.store,
      isSelected: false,
    ),
  );
  List<StoreSelectDataModel> selectedStores = [];
  addSelectProduct(int index) {
    final store = recentStores[index];
    selectedStores.add(store.copyWith(isSelected: true));
    recentStores.removeAt(index);
  }
  removeProduct(int index){
    final store = selectedStores[index];
    recentStores.add(store.copyWith(isSelected: false));
    selectedStores.removeAt(index);
  }
  late TextEditingController searchTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      title: "Select Store",
      showBottomButton: true,
      onButtonTap: (){
        AppRouter.customback(
                times: 6
              );
        AppRouter.push(SuccessListingRequestView(message: "Listing Request Sent Successfully!"));
      },
      bottomButtonText: "send request",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppTheme.horizontalPadding),
            child: CustomSearchBarWidget(
              onTapOutside: (v){
               FocusScope.of(context).unfocus();
              
            },
              hintText: "Hinted search text", controller: searchTextEditController, onChanged: (v){
              setState(() {
                
              });
            },),
          ),
          if (selectedStores.isNotEmpty && searchTextEditController.text == "") ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding,
              ),
              child: Text("Selected", style: context.textStyle.displayMedium),
            ),
            10.ph,
            SizedBox(
              height: context.screenheight * 0.199,
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
                  childAspectRatio: 1.0,
                  maxCrossAxisExtent: 200,
                ),
                itemCount: selectedStores.length,
                itemBuilder: (context, index) {
                  return StoreCardWidget(
                    data: selectedStores[index],
                    onTap: () {
                      setState(() {
                        removeProduct(index);
                      });
                    },
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
                    0.97, // Adjust if you want different box shapes
              ),
              itemCount: recentStores.length, // Set how many items you want
              itemBuilder: (context, index) {
                return StoreCardWidget(
                  data: recentStores[index],
                  onTap: () {
                    setState(() {
                      addSelectProduct(index);
                    });
                  },
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



class StoreCardWidget extends StatelessWidget {
  final StoreSelectDataModel data;
  final VoidCallback? onTap;
  const StoreCardWidget({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textColor = data.isSelected
        ? Colors.white
        : AppColors.primaryTextColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: data.isSelected ? AppColors.secondaryColor : Color(0xFFF3F3F3), // Background color
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000), // #00000040 = 25% opacity black
              offset: Offset(0, -3), // Moves shadow upward
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            Image.asset(data.icon, width: 60.r),
            Text(
              data.title,
              style: context.textStyle.bodyMedium!.copyWith(color: textColor),
            ),
            // Text(
            //   data.rating.toString(),
            //   style: context.textStyle.titleSmall!.copyWith(color: textColor),
            // ),
            // Text(
            //   data.address,
            //   style: context.textStyle.titleSmall!.copyWith(color: textColor),
            //   maxLines: 1,
            //   textAlign: TextAlign.center,
            // ),
            data.isSelected
                ? Expanded(
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 22.r,
                      color: Colors.white,
                    ),
                  )
                : Expanded(
                    child: Container(
                      height: 15.r,
                      width: 15.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondaryColor),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
