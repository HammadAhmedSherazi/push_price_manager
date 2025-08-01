import 'package:push_price_manager/export_all.dart';

class SeeAllProductView extends StatelessWidget {
  final String title;
  const SeeAllProductView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: title, child: GridView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.horizontalPadding,
                  vertical: AppTheme.horizontalPadding
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  // item height (since scrolling is horizontal)
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.999,
                  maxCrossAxisExtent: 200,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ProductDisplayBoxWidget());
                },
              ),
           );
  }
}