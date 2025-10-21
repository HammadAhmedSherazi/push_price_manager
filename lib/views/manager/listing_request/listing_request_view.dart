import 'dart:async';

import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingRequestView extends ConsumerStatefulWidget {
  const ListingRequestView({super.key});

  @override
  ConsumerState<ListingRequestView> createState() => _ListingRequestViewState();
}

class _ListingRequestViewState extends ConsumerState<ListingRequestView> {
  late TextEditingController _searchTextEditController;
  late ScrollController _scrollController;

  Timer? _searchDebounce;

  void _showCategoriesModal(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(authProvider.select((e) => e.categories)) ?? [];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(AppTheme.horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.tr("categories"), style: context.textStyle.displayMedium),
              20.ph,
              SizedBox(
                height: 200.h,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10.r,
                    mainAxisSpacing: 10.r,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: NetworkImage(category.icon),
                        ),
                        5.ph,
                        Text(
                          category.title,
                          style: context.textStyle.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    _searchTextEditController = TextEditingController();
    _scrollController = ScrollController();
    Future.microtask(() {
     fetchProduct(skip: 0);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        int skip = ref.read(productProvider).skip ?? 0;
        if (skip > 0) {
          Future.microtask(() {
            fetchProduct(skip: skip);
          });
        }
      }
    });
  }

  void fetchProduct({String ?searchText, required int skip}){
    final String? text = _searchTextEditController.text.isEmpty ? null :  _searchTextEditController.text;
    ref
                .read(productProvider.notifier)
                .getProductfromDatabase(limit: 10, skip: skip, searchText: searchText ?? text);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: context.tr("scan"),
      onButtonTap: ()async{
                  final providerVM = ref.watch(productProvider);
                  String? res = await SimpleBarcodeScanner.scanBarcode(
                      context,
                      cameraFace: CameraFace.front,
                      barcodeAppBar:  BarcodeAppBar(
                        appBarTitle: "${context.tr("scan")} ${context.tr("barcode")}",
                        centerTitle: false,
                        enableBackButton: true,
                        backButtonIcon: Icon(Icons.arrow_back_ios),
                      ),
                      isShowFlashIcon: true,
                      delayMillis: 100,
                      
                   
                    );
                   
                    if(providerVM.getProductReponse.status != Status.loading && res != null){
                      if(!context.mounted) return;
                                Helper.showFullScreenLoader(context);
                                ref.read(productProvider.notifier).getProductData(res);
                              }
                },
      title: AppConstant.userType == UserType.employee
          ? context.tr("search_from_database")
          : context.tr("listing_request_select_product"),
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref
              .read(productProvider.notifier)
              .getProductfromDatabase(limit: 10, skip: 0);
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppTheme.horizontalPadding),
              child: CustomSearchBarWidget(
                controller: _searchTextEditController,
                onChanged: (text) {
                  if (_searchDebounce?.isActive ?? false) {
                    _searchDebounce!.cancel();
                  }

                  _searchDebounce = Timer(
                    const Duration(milliseconds: 500),
                    () {
                      if (text.length >= 3) {
                        fetchProduct(skip: ref.watch(productProvider).skip ?? 0, searchText: text);
                      }
                      else{
                        fetchProduct(skip: 0);
                      }
                    },
                  );
                },
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                hintText: context.tr("search_product"),
                suffixIcon: GestureDetector(
                  onTap: () => _showCategoriesModal(context, ref),
                  child: SvgPicture.asset(Assets.filterIcon),
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final providerVM = ref.watch(
                  productProvider.select((e) => e.productApiResponse),
                );
                return Expanded(
                  child: AsyncStateHandler(
                    scrollController: _scrollController,
                    status: providerVM.status,

                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.horizontalPadding,
                    ),
                    itemBuilder: (context, index) {
                      final product = ref
                          .watch(productProvider)
                          .products![index];
                      return ProductDisplayWidget(
                        data: product,
                        onTap: () {
                          AppRouter.push(
                            ListingProductDetailView(data: ListingModel(product: product)),
                            fun: (){fetchProduct(skip: 0);}
                          );
                        },
                      );
                    },
                    dataList: ref.watch(productProvider).products!,
                    onRetry: () {
                      String? txt = _searchTextEditController.text.isEmpty ? null : _searchTextEditController.text; 
                      fetchProduct(skip: 0,searchText: txt);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: CustomAppBarWidget(
    //     height: context.screenheight * 0.15,
    //     title: AppConstant.userType == UserType.employee? context.tr("search_from_database"): "context.tr("listing_request_select_product")",
    //     children: [
    // CustomSearchBarWidget(
    //   hintText: context.tr("search_product"),
    //   suffixIcon: SvgPicture.asset(Assets.filterIcon),
    // ),
    //     ],
    //   ),
    //   body: Column(
    //     children: [
    // Expanded(child: ListView.separated(
    //   padding: EdgeInsets.all(AppTheme.horizontalPadding),
    //   itemBuilder: (context, index)=>ProductDisplayWidget(
    //     onTap: (){},
    //   ), separatorBuilder: (context, index)=> 10.ph, itemCount: 10)),
    //       Padding(
    //         padding: EdgeInsets.all(AppTheme.horizontalPadding),
    //         child: CustomButtonWidget(title: context.tr("scan"), onPressed: (){
    //           AppRouter.push(ScanView());
    //         }),
    //       )
    //     ],
    //   ),
    // );
  }
}
