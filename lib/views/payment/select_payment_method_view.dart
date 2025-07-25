import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class SelectPaymentMethodView extends StatefulWidget {
  const SelectPaymentMethodView({super.key});

  @override
  State<SelectPaymentMethodView> createState() => _SelectPaymentMethodViewState();
}

class _SelectPaymentMethodViewState extends State<SelectPaymentMethodView> {
   List<CardDataModel> myCards = [
    CardDataModel(cardNum: "**** **** **** 6215", cardType: "visa", ),
    CardDataModel(cardNum: "**** **** **** 0032", cardType: "master",),
    CardDataModel(cardNum: "**** **** **** 2541", cardType: "apple pay",),
    CardDataModel(cardNum: "**** **** **** 9634", cardType: "paypal",),
  ];
  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: selectIndex >= 0,
      bottomButtonText: "Proceed with Payment",
      onButtonTap: (){
        AppRouter.push(StoreCodeView());
      },
      title: "Select Payment Method", child: ListView.separated(
      
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      itemBuilder: (context, index) {
      if(myCards.length == index){
        return CustomButtonWidget(title: "", onPressed: (){}, child: Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text("ADD A NEW PAYMENT METHOD", style: context.textStyle.displayMedium!.copyWith(
                      color: Colors.white
                    ),)
                  ],
                ) ,);
      }
      else{
        final card = myCards[index];
        return Container(
          decoration: AppTheme.boxDecoration,
          padding: EdgeInsets.symmetric(
            vertical: 5.r
          ),
          child: ListTile(
            onTap: (){
              setState(() {
                selectIndex = index;
              });
            },
            leading: SvgPicture.asset(setCardIcon(card.cardType)),
            title: Text(card.cardNum, style: context.textStyle.displayMedium,),
            trailing: Container(
              width: 18.r,
              height: 18.r,
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: AppColors.secondaryColor
                )
              ),
              child: index == selectIndex? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle
                ),
              ) : null,
            ) ,
          ),
        ) ;
      }
    }, separatorBuilder: (context, index)=> 10.ph, itemCount: myCards.length + 1));
  }
}