import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> with SingleTickerProviderStateMixin {
   late TabController tabController;
   final List<Widget> tabs = [
    Tab(text: "In Process",),
    Tab(text: "Completed",),
    Tab(text: "Cancelled",),
   ];
  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    
 
    return CustomScreenTemplate(
      title: "My Orders", child: Column(
      children: [
        
        CustomTabBarWidget(tabController: tabController, tabs: tabs,),
      
        Expanded(child:ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.horizontalPadding,
            vertical: 30.r
          ),
          itemBuilder: (context, index)=>GestureDetector(
            onTap: (){
              AppRouter.push(OrderDetailView(orderStatus: setOrderStatus(tabController.index)));
            },
            child: OrderCardWidget()), separatorBuilder: (context, index)=>const Divider(), itemCount: 4))
      ],
    ));
  }
}

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(
      vertical: 10.r,
      horizontal: 20.r
    ),
    
    decoration: AppTheme.productBoxDecoration,
    child: Row(
      spacing: 15,
      children: [
        Image.asset(Assets.store, width: 50.r,),
        Expanded(child: Column(
          spacing: 4,
          children: [
            Row(
              children: [
                Expanded(child: Text("ABC Store",style: context.textStyle.displayMedium,)),
                Text("\$80.00", style: context.textStyle.titleSmall!.copyWith(
                  color: AppColors.secondaryColor
                ),)
              ],
            ),
             Row(
              children: [
                Expanded(child: Text("Order ID #652327",style: context.textStyle.bodyMedium,)),
               TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity(
                    vertical: -4.0,
                    horizontal: -4.0
                  )
                ),
                onPressed: (){}, child: Text("View Details", style: context.textStyle.bodyMedium!.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline
               ),))
              ],
            )
          ],
        ))
      ],
    ),
            );
  }
}

setOrderStatus(int index){
  switch (index) {
    case 0:
      return OrderStatus.inProcess;
    case 1:
      return OrderStatus.completed;
    case 2:
      return OrderStatus.cancelled;
  }
  
}
