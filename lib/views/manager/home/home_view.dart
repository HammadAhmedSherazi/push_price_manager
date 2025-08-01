import 'package:push_price_manager/utils/extension.dart';
import '../../../export_all.dart';


class HomeView extends StatefulWidget {
  final ScrollController scrollController;
  const HomeView({super.key, required this.scrollController});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

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
              Text("ABC BUSINESS", style: context.textStyle.displayMedium,),
              Spacer(),
              CustomButtonWidget(
                height: 30.h,
                width: 120.w,
                title: "", onPressed: (){
                  AppRouter.push(ListingRequestView());
                }, child: Row(
                children: [
                  Icon(Icons.add),
                  Text("Listing Request", style: context.textStyle.bodySmall!.copyWith(
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
          PendingListingSection(),
          30.ph,
          LiveListingSection()
        ],
      ),
    );
  }
}

class PendingListingSection extends StatelessWidget {
  const PendingListingSection({
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
              Text("Pending Listings", style: context.textStyle.displayMedium,),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: (){
                  AppRouter.push(SeeAllProductView(title: "Pending Listings"));
                }, child: Text("See All", style:   context.textStyle.displayMedium!.copyWith(
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

class LiveListingSection extends StatelessWidget {
  const LiveListingSection({
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
              Text("Live Listings", style: context.textStyle.displayMedium,),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: (){
                  AppRouter.push(SeeAllProductView(title: "Live Listings"));
                }, child: Text("See All", style:   context.textStyle.displayMedium!.copyWith(
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



