import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class MyPaymentMethodView extends StatefulWidget {
  const MyPaymentMethodView({super.key});

  @override
  State<MyPaymentMethodView> createState() => _MyPaymentMethodViewState();
}

class _MyPaymentMethodViewState extends State<MyPaymentMethodView> {
  List<CardDataModel> myCards = [
    CardDataModel(cardNum: "**** **** **** 6215", cardType: "visa", isPrimary: true),
    CardDataModel(cardNum: "**** **** **** 0032", cardType: "master", isPrimary: false),
  ];

  removeCard(index){
    
    setState(() {
      myCards.removeAt(index);
    });
  }
 void setPrimaryCard(int selectedIndex) {
  setState(() {
    myCards = List.generate(
      myCards.length,
      (index) => myCards[index].copyWith(
        isPrimary: index == selectedIndex, // true for selected, false for others
      ),
    );
  });
}
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      
      title: "Payment Methods", child: Column(
        children: [
          Expanded(
            child: ListView.separated(
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
              return CardTitleWidget(card: card, removeFun: (){
                removeCard(index);
              }, setPrimaryFun: (){
                setPrimaryCard(index);
              });
              }
              
            }, separatorBuilder: (context, index)=> 10.ph , itemCount: myCards.length + 1),
          ),
         
        ],
      ));
  }
}

class CardTitleWidget extends StatelessWidget {
  final CardDataModel card;
  final VoidCallback removeFun;
  final VoidCallback setPrimaryFun;
  const CardTitleWidget({
    super.key,
    required this.card,
    required this.removeFun,
    required this.setPrimaryFun
  });

  @override
  Widget build(BuildContext context) {
    return Container(
                
      padding: EdgeInsets.symmetric(
        horizontal: 20.r,
        vertical: 15.r
      ),
      decoration: AppTheme.boxDecoration,
      child: Column(
        children: [
          Row(
            spacing: 10,
            children: [
              SvgPicture.asset(setCardIcon(card.cardType)),
              Text(card.cardNum, style: context.textStyle.displayMedium,)
            ],
          ),
          Row(
            children: [

             card.isPrimary!? Text("(Primary)", style: context.textStyle.bodyMedium!.copyWith(
                color: AppColors.secondaryColor
              ),) : TextButton(
                style: ButtonStyle(
                  visualDensity: VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0
                  )
                ),
                onPressed: setPrimaryFun, child: Text("Set as Primary", style: context.textStyle.bodyMedium!.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline
              ),)),
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity(
                  vertical: -4.0
                ),
                onPressed: removeFun, icon: Icon(Icons.delete, color: Color.fromRGBO(199, 2, 2, 1), ))
                
            ],
          )
                
        ],
      ),
    );
  }
}

class CardDataModel {
  final String cardNum;
  final String cardType;
  final bool? isPrimary;

  CardDataModel({
    required this.cardNum,
    required this.cardType,
     this.isPrimary,
  });

  CardDataModel copyWith({
    String? cardNum,
    String? cardType,
    bool? isPrimary,
  }) {
    return CardDataModel(
      cardNum: cardNum ?? this.cardNum,
      cardType: cardType ?? this.cardType,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}


