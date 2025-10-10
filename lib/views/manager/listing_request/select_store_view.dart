import 'dart:async';

import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class SelectStoreView extends ConsumerStatefulWidget {
  const SelectStoreView({super.key});

  @override
  ConsumerState<SelectStoreView> createState() => _SelectStoreViewState();
}

class _SelectStoreViewState extends ConsumerState<SelectStoreView> {
  // List<StoreSelectDataModel> recentStores = List.generate(
  //   2,
  //   (index) => StoreSelectDataModel(
  //     title: "ABC Store",
  //     address: "abc street, lorem ipsum",
  //     rating: 4.0,
  //     icon: Assets.store,
  //     isSelected: false,
  //   ),
  // );
  // List<StoreSelectDataModel> selectedStores = [];

  late final TextEditingController searchTextEditController;
  Timer? _searchDebounce;
  @override
  void initState() {
    searchTextEditController = TextEditingController();
    Future.microtask(() {
      fetchStores();
    });
    super.initState();
  }
  void fetchStores({String? searchText}){
    ref.read(productProvider.notifier).getMyStores(searchText: searchText);
  }
  @override
  Widget build(BuildContext context) {
    final providerVM = ref.watch(productProvider);
    final recentStores = providerVM.myStores ?? [];
    final selectedStores = providerVM.mySelectedStores ?? [];
    return CustomScreenTemplate(
      title: "Select Store",
      showBottomButton: true,
      customBottomWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
        child: Consumer(
          builder: (context, ref, child) {
            ref.watch(productProvider.select((e) => e.listNowApiResponse));
            return CustomButtonWidget(
              isLoad: providerVM.listNowApiResponse.status == Status.loading,
              title: "send request",
              onPressed: () {
                if (selectedStores.isEmpty) {
                  Helper.showMessage(context, message: "Please select a store");
                  return;
                }
                final route = ModalRoute.of(context);
                final args = route?.settings.arguments;

                Map<String, dynamic> data = {};
                if (args is Map<String, dynamic>) {
                  data = Map<String, dynamic>.from(args);
                }
                data['store_ids'] = List.generate(providerVM.mySelectedStores!.length, (index)=>selectedStores[index].storeId);
                
                ref.read(productProvider.notifier).listNow(input: data, popTime: 6);
              },
            );
          },
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppTheme.horizontalPadding),
            child: CustomSearchBarWidget(
              onTapOutside: (v) {
                FocusScope.of(context).unfocus();
              },
              hintText: "Hinted search text",
              controller: searchTextEditController,
              onChanged: (text) {
                 if (_searchDebounce?.isActive ?? false) {
                    _searchDebounce!.cancel();
                  }

                  _searchDebounce = Timer(
                    const Duration(milliseconds: 500),
                    () {
                      if (text.length >= 3) {
                          fetchStores(searchText: text);
                      }
                    },
                  );
              },
            ),
          ),
          if (selectedStores.isNotEmpty &&
              searchTextEditController.text == "") ...[
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
                      ref.read(productProvider.notifier).removeProduct(index);
                    },
                  );
                },
              ),
            ),
            10.ph,
          ],
          if (recentStores.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding,
              ),
              child: Text(
                searchTextEditController.text == ""
                    ? "Recent"
                    : "Search Result",
                style: context.textStyle.displayMedium,
              ),
            ),
            10.ph,
            Expanded(
              child: AsyncStateHandler(
                status: providerVM.getStoresApiRes.status,
                dataList: recentStores,
                itemBuilder: null,
                onRetry: () {
                  ref.read(productProvider.notifier).getMyStores();
                },
                customSuccessWidget: GridView.builder(
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
                        ref
                            .read(productProvider.notifier)
                            .addSelectProduct(index);
                      },
                    );
                  },
                ),
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
          color: data.isSelected
              ? AppColors.secondaryColor
              : Color(0xFFF3F3F3), // Background color
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
            DisplayNetworkImage(imageUrl: "", width: 60.r, height: 60.r),
            Text(
              data.storeName,
              style: context.textStyle.bodyMedium!.copyWith(color: textColor),
            ),
            Text(
              '4.0',
              style: context.textStyle.titleSmall!.copyWith(color: textColor),
            ),
            Text(
              data.storeLocation,
              style: context.textStyle.titleSmall!.copyWith(color: textColor),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
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
                      // height: 12.r,
                      // width: 12.r,
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
