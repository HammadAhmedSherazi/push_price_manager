import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class StoreDetailView extends StatelessWidget {
  const StoreDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserRatingDataModel> userRating = List.generate(4, (index)=> UserRatingDataModel(userName: "Sara Williams", userImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQn9zilY2Yu2hc19pDZFxgWDTUDy5DId7ITqA&s", rating: 4.0, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit,  eiusmod tempor Lorem ipsum dolor sit amet, consectetur adipiscing elit,  eiusmod tempor i ", date: DateTime.now()));

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(context.screenheight * 0.15), child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.horizontalPadding,

        ),
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryAppBarColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r)
          )
        ),
        child: Column(
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackWidget(
                  height: 24.r,
                ),
                Text("Abc Store", style: context.textStyle.displayMedium!,),
                25.pw,
              ],
            ),
            10.ph,
            Image.asset(Assets.store, width: 70.r,),
            10.ph,
          ],
        ),
      )),
      body: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        children: [
          Text("Store Information", style: context.textStyle.displayMedium!.copyWith(
            fontSize: 16.sp
          ),),
          10.ph,
          StoreDetailTitleWidget(
            title: "Store Address",
            description: "abc street, lorem ipsum" ,
          ),
          StoreDetailTitleWidget(
            title: "Operational Hours",
            description: "9AM To 6PM" ,
          ),
          10.ph,
          Row(
            children: [
               Text("Rating & Reviews", style: context.textStyle.displayMedium!.copyWith(
            fontSize: 16.sp
          ),),
          Spacer(),
          Icon(Icons.star, color: Color(0xffFF901C),),
          5.pw,
          Text("4.5", style: context.textStyle.bodyMedium!.copyWith(
            fontSize: 16.sp
          ),)
            ],
          ),
          10.ph,
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = userRating[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
              children: [
                UserProfileWidget(radius: 20.r, imageUrl: data.userImage, borderWidth: 1.3,),
                Expanded(child: Column(
                  spacing: 5,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.userName, style: context.textStyle.displayMedium,),
                            Text('Today | 02:35 pm', style: context.textStyle.titleMedium,)
                          ],
                        )),
                        RatingBarIndicator(
    rating: data.rating,
    itemBuilder: (context, index) => Icon(
         Icons.star_rounded,
         color: Color(0xffFF901C),
    ),
    itemCount: 5,
    itemSize: 20.r,
    direction: Axis.horizontal,
),
                      ],
                    ),
                    Text(data.description, style: context.textStyle.titleMedium, maxLines: 3,)
                  ],
                ))
              ],
            );
            }, separatorBuilder: (context, index)=> Divider(), itemCount: userRating.length)
        ],
      ),
    );
  }
}

class StoreDetailTitleWidget extends StatelessWidget {
  final String title;
  final String description;
  const StoreDetailTitleWidget({
    super.key,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5.r
      ),
      padding: EdgeInsets.only(
        bottom: 5.r
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          color: AppColors.borderColor
        ))
      ),
      child: Row(
        children: [
          Text(title, style: context.textStyle.bodyMedium!.copyWith(
            color: Color(0xff5B5B5B)
          ),),
           Expanded(child: Text(description, style: context.textStyle.bodyMedium!,textAlign: TextAlign.end,))
        ],
      ),
    );
  }
}