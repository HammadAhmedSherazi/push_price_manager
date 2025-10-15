import 'package:push_price_manager/utils/extension.dart';
import '../../../export_all.dart';

class ScanProductView extends StatelessWidget {
  final ProductDataModel data;
  const ScanProductView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: context.tr("barcode"), child: SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(Assets.barCodeScanIcon)),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding,
              vertical: 30.r
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(242, 248, 254, 1)
            ),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title, style: context.textStyle.bodyMedium!.copyWith(
                  fontSize: 18.sp
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category", style: context.textStyle.bodyMedium!.copyWith(
                      color: Colors.grey
                    ),),
                    Text("${data.category?.title}", style: context.textStyle.bodyMedium!,),
                  ],
                ),
                SizedBox(
  width: double.infinity,
  height: 1,
  child: CustomPaint(
    painter: DottedLinePainter(),
  ),
),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Regular Price", style: context.textStyle.bodyMedium!.copyWith(
                      color: Colors.grey
                    ),),
                    Text("\$${data.price!.toStringAsFixed(2)}", style: context.textStyle.bodyMedium!,),
                  ],
                ),
                5.ph,
                CustomButtonWidget(title: "select product", onPressed: (){
                  AppRouter.push(ListingProductDetailView(
                    data: ListingModel(product: data),
                  ));
                })
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DottedLinePainter({
    this.color = Colors.black,
    this.dashWidth = 3,
    this.dashSpace = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}