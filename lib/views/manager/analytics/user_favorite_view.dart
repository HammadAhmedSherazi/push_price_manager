
import '../../../export_all.dart';

class UserFavoriteView extends StatelessWidget {
  const UserFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
           padding: EdgeInsets.all(AppTheme.horizontalPadding ),
           child: CustomSearchBarWidget(
            hintText: context.tr("hinted_search_text"),
            suffixIcon: SvgPicture.asset(Assets.filterIcon),
            onTapOutside: (v){
               FocusScope.of(context).unfocus();
              
            }
                   ),
         ),
          //  Expanded(
          //   child: ListView.separated(
          //     padding: EdgeInsets.all(AppTheme.horizontalPadding).copyWith(
          //       bottom: 100.r
          //     ),
          //     itemBuilder: (context, index)=>Stack(
          //       children: [
                  
          //         ProductDisplayWidget(
          //           onTap: (){
          //             AppRouter.push(UserFavoriteProductDetailView());
          //           },
          //         ),
          //         Positioned(right: 20.r, top: 20.r,child: Text("300+", style: context.textStyle.bodySmall,),),
          //       ],
          //     ), separatorBuilder: (context, index)=> 10.ph, itemCount: 10),
          // )
       
       
      ],
    );
  }
}