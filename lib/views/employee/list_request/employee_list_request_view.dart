import 'dart:async';

import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class EmployeeListRequestView extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const EmployeeListRequestView({super.key, required this.scrollController});

  @override
  ConsumerState<EmployeeListRequestView> createState() => _EmployeeListRequestViewState();
}

class _EmployeeListRequestViewState extends ConsumerState<EmployeeListRequestView> {
late final ScrollController _scrollController;
  late final TextEditingController _searchTextEditController;
  Timer? _searchDebounce;
  List<String> types = [
  "best_by_products",
  "instant_sales",
  "weighted_items",
  "promotional_products",
];
  int selectIndex = -1;

  int selectCategoryId = -1;

  void _showCategoriesModal(BuildContext context, WidgetRef ref) {
  
    final categories =
        ref.watch(authProvider.select((e) => e.categories)) ?? [];
   
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState)=>Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.horizontalPadding
          ),

          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr("categories"),
                style: context.textStyle.displayMedium!.copyWith(
                  fontSize: 18.sp,
                ),
              ),

              SizedBox(
                height: 85.r,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // Only 1 row vertically
                    mainAxisSpacing: 2.r,
                    crossAxisSpacing: 5.r,
                    childAspectRatio: 1.2, // Keep boxes square
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelect = category.id == selectCategoryId;
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          if(isSelect){
                            selectCategoryId = -1;
                          }
                          else{
                          selectCategoryId = category.id!;

                          }
                        });
                      },
                      child: Column(
                        // spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor:isSelect  ? null : AppColors.primaryAppBarColor ,
                            child: DisplayNetworkImage(
                              width: 30.r,
                              height: 30.r,
                              imageUrl: category.icon,
                            ),
                          ),
                          Text(
                            category.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: context.textStyle.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
             ],
          ),
        )
     ); },
    ).then((c){
     
        fetchProduct(skip: 0);
      
    });
  }


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchTextEditController = TextEditingController();
    Future.microtask(() {
      fetchProduct(skip: 0);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        int skip = ref.read(productProvider).skip ?? 0;
        if (skip > 0) {
          fetchProduct(skip: skip);
        }
      }
    });
  }

  void fetchProduct({String ? text, required int skip}) {
    String ? txt = _searchTextEditController.text.isEmpty ? null : _searchTextEditController.text;
         
    ref
        .read(productProvider.notifier)
        .getListRequestProducts(
          limit: 10,
          type:selectIndex == -1? null: Helper.setType(types[selectIndex]),
          searchText: text ?? txt,
          skip: skip,
          categoryId: selectCategoryId == -1 ? null : selectCategoryId
          
        );
  }
  void selectChip(int index){
     setState(() {
                    selectIndex = index == selectIndex ? -1: index;
                  });
                  fetchProduct(skip:0);
  }
  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerVM = ref.watch(productProvider);
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: context.screenheight * 0.22,
        backgroundColor: Colors.transparent,
        radius: 0.0,
        title: context.tr("listing_requests"),
        children: [
          15.ph,
          Expanded( 
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.r,
                vertical: 8.r
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryAppBarColor,
                borderRadius: BorderRadius.circular(30.r)
              ),
              child: Column(
                spacing: 8,
  children: [
    for (int i = 0; i < types.length; i += 2)
      Expanded(
        child: Row(
          spacing: 8,
          children: [
            // First item in the row
            Expanded(
              child: GestureDetector(
                onTap: () {
                  selectChip(i);
                },
                child: Container(
                  // margin: EdgeInsets.only(bottom: 8),
                  // padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectIndex == i
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30.r),
                    border: selectIndex == i
                        ? null
                        : Border.all(color: AppColors.borderColor),
                  ),
                  child: Text(
                    context.tr(types[i]),
                    style: selectIndex == i
                        ? context.textStyle.displaySmall!
                            .copyWith(color: Colors.white)
                        : context.textStyle.bodySmall!
                            .copyWith(color: AppColors.primaryTextColor),
                  ),
                ),
              ),
            ),
        
          
        
            // Second item in the row (check if it exists)
            if (i + 1 < types.length)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                   
                    selectChip(i + 1);
                  },
                  child: Container(
                    // margin: EdgeInsets.only(bottom: 8),
                    // padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectIndex == i + 1
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30.r),
                      border: selectIndex == i + 1
                          ? null
                          : Border.all(color: AppColors.borderColor),
                    ),
                    child: Text(
                      context.tr(types[i + 1]),
                      style: selectIndex == i + 1
                          ? context.textStyle.displaySmall!
                              .copyWith(color: Colors.white)
                          : context.textStyle.bodySmall!
                              .copyWith(color: AppColors.primaryTextColor),
                    ),
                  ),
                ),
              )
            else
              Expanded(child: SizedBox()), // Filler if odd number
          ],
        ),
      ),
  
  ],
)

//               GridView.builder(
//                 padding: EdgeInsets.zero,
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2, // 👈 2 items per row
//     crossAxisSpacing: 5,
//     mainAxisSpacing: 8,
//     childAspectRatio: 4.3, // Adjust this as needed
//   ),
//   itemCount: types.length,
//   itemBuilder: (context, index) {
//     final bool isSelect = selectIndex == index;
//     return GestureDetector(
//       onTap: (){
//         setState(() {
//           selectIndex = index;
//         });
//         // AppRouter.push(ProductAddDetailView(title: "Pending Listing- Select Product"));

//       },
//       child: Container(
       
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelect ? AppColors.primaryColor : Colors.transparent,
//             borderRadius: BorderRadius.horizontal(
//               right: Radius.circular(30.r),
//               left: Radius.circular(30.r)
//             ),
//             border: !isSelect ? Border.all(color: AppColors.borderColor) : null
//           ),
//           child: Text(types[index], style: isSelect? context.textStyle.displaySmall!.copyWith(
//             color:  Colors.white ,
      
//           ) : context.textStyle.bodySmall!.copyWith(
//             color: AppColors.primaryTextColor
//           ),),
//       ),
//     );
//   },
// ),
            
            ),
          )
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: ()async {
          fetchProduct(skip: 0);
        },
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding
              ),
              child: CustomSearchBarWidget(
                controller: _searchTextEditController,
                onChanged: (text){
                  if (_searchDebounce?.isActive ?? false) {
                      _searchDebounce!.cancel();
                    }
        
                    _searchDebounce = Timer(
                      const Duration(milliseconds: 500),
                      () {
                        if (text.length >= 3) {
                         fetchProduct(text: text, skip: 0);
                        }
                        else{
                          fetchProduct(skip: 0);
                        }
                      },
                    );
                },
                hintText: context.tr("search_product"), suffixIcon: GestureDetector(
                  onTap: () => _showCategoriesModal(context, ref),
                  child: SvgPicture.asset(Assets.filterIcon),
                ), onTapOutside: (v){
                 FocusScope.of(context).unfocus();

              }, ),
            ),
             Expanded(
              child: AsyncStateHandler(
                status: providerVM.listRequestApiResponse.status,
                dataList: providerVM.listRequestproducts!,
                onRetry: () {
                  fetchProduct(skip: 0);
                },
                scrollController: _scrollController,
                padding: EdgeInsets.all(
                  AppTheme.horizontalPadding,
                ).copyWith(bottom: 100.r),
                itemBuilder: (context, index) {
                  final item =providerVM.listRequestproducts![index];
                  return ProductDisplayWidget(
                  onTap: () {
                     AppRouter.push(
                        ListingProductDetailView(isRequest: true,  data: ListingModel(product: item.product!), ),fun: (){
                          fetchProduct(skip: 0);
                        }
                      
                    );
                    // AppRouter.push(
                    //   PendingProductDetailView(
                    //     type: types[selectIndex],
                    //     data: providerVM.listRequestproducts![index],
                    //   ),
                    // );
                  },
                  data: item.product!,
                );
                },
              ),
            ),
         
          ],
        ),
      ),
    );
  }
}