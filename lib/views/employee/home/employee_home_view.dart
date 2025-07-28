import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class EmployeeHomeView extends StatefulWidget {
  final ScrollController scrollController;
  const EmployeeHomeView({super.key, required this.scrollController});

  @override
  State<EmployeeHomeView> createState() => _EmployeeHomeViewState();
}

class _EmployeeHomeViewState extends State<EmployeeHomeView> {
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
              Expanded(child: Text("ABC BUSINESS", style: context.textStyle.displayMedium,)),
            
              CustomButtonWidget(
                height: 30.h,
                width: 110.w,
                title: "", onPressed: (){
                  AppRouter.push(ListProductView());
                }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text("List Product", style: context.textStyle.bodySmall!.copyWith(
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
          ListingRequestSection(),
          30.ph,
          ProductListingSection()
        ],
      ),
    );
  }
}

class ListingRequestSection extends StatelessWidget {
  const ListingRequestSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Listing Request", style: context.textStyle.displayMedium,),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: (){}, child: Text("See All", style:   context.textStyle.displayMedium!.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline
              ),))
            ],
          ),
          SizedBox(
                    height: 125.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index)=>ProductDisplayBoxWidget(), separatorBuilder: (context, index)=> 10.pw, itemCount: 5),
                  )
        ],
    );
  }
}

class ProductListingSection extends StatelessWidget {
  const ProductListingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Product Listings", style: context.textStyle.displayMedium,),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: (){}, child: Text("See All", style:   context.textStyle.displayMedium!.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline
              ),))
            ],
          ),
          SizedBox(
                    height: 125.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index)=>ProductDisplayBoxWidget(), separatorBuilder: (context, index)=> 10.pw, itemCount: 5),
                  )
        ],
    );
  }
}



