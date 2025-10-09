import 'package:push_price_manager/views/manager/listing_request/select_store_view.dart';

import '../../../export_all.dart';

class SelectListingTypeView extends StatefulWidget {
  const SelectListingTypeView({super.key});

  @override
  State<SelectListingTypeView> createState() => _SelectListingTypeViewState();
}

class _SelectListingTypeViewState extends State<SelectListingTypeView> {
  int selectIndex = 0;
  List<String> types = [
    "Best By Products",
    "Instant Sales",
    "Weighted Items",
    "Promotional Products",
  ];
  

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      bottomButtonText: "next",
      onButtonTap: () {
        final route = ModalRoute.of(context);
        final args = route?.settings.arguments;

        Map<String, dynamic> data = {};
        if (args is Map<String, dynamic>) {
          data = Map<String, dynamic>.from(args);
        }

        data['listing_type'] = Helper.setType(types[selectIndex]);
        if (AppConstant.userType == UserType.employee) {
          AppRouter.push(
            ListingProductView(type: types[selectIndex], popTime: 6),
            settings: RouteSettings(arguments: data),
          );
        } else {
          AppRouter.push(SelectStoreView());
        }
      },
      showBottomButton: true,
      title: "Listing Type",
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: List.generate(
              types.length,
              (index) => SelectTypeWidget(
                isSelect: selectIndex == index,
                title: types[index],
                onTap: () {
                  setState(() {
                    selectIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectTypeWidget extends StatelessWidget {
  final bool isSelect;
  final String title;
  final VoidCallback onTap;
  const SelectTypeWidget({
    super.key,
    required this.isSelect,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return isSelect
        ? CustomButtonWidget(title: title, onPressed: () {})
        : CustomOutlineButtonWidget(title: title, onPressed: onTap);
  }
}
