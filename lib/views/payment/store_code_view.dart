import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class StoreCodeView extends StatelessWidget {
  const StoreCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: "Store Code", child: ListView(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Code",
            hintText: "Enter Store Code"
          ),
        ),
        30.ph,
        CustomButtonWidget(title: "pay now", onPressed: (){ 
          AppRouter.push(OrderDetailView(orderStatus: OrderStatus.completed, afterPayment: true,));
        })
        
      ],
    ));
  }
}