import 'dart:io';

import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
   BarcodeViewController? controller;
  String result = '';
  @override
  Widget build(BuildContext context) {
   
    return CustomScreenTemplate(
      title: "Barcode",
      showBottomButton: false,
      bottomButtonText: "scan now",
      // onButtonTap: (){
      //   AppRouter.push(ScanProductView());
      // },
      
      child: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding), children: [
           Platform.isIOS ?
          Consumer(
            builder: (context, ref, child) {
              final providerVM = ref.watch(productProvider);
              return GestureDetector(
                onTap: ()async{
                  String? res = await SimpleBarcodeScanner.scanBarcode(
                      context,
                      cameraFace: CameraFace.front,
                      barcodeAppBar: const BarcodeAppBar(
                        appBarTitle: 'Test',
                        centerTitle: false,
                        enableBackButton: true,
                        backButtonIcon: Icon(Icons.arrow_back_ios),
                      ),
                      isShowFlashIcon: true,
                      delayMillis: 100,
                      
                   
                    );
                    print(res);
                    if(providerVM.getProductReponse.status != Status.loading && res != null){
                      if(!context.mounted) return;
                                Helper.showFullScreenLoader(context);
                                ref.read(productProvider.notifier).getProductData(res);
                              }
                },
                child: Container(
                  height: context.screenheight * 0.42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Color.fromRGBO(50, 50, 50, 1)
                  ),
                  child: SvgPicture.asset(Assets.scanIcon),
                ),
              );
            }
          ): 
           ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
             child: Consumer(
               builder: (context, ref, child) {
                final providerVM = ref.watch(productProvider);
                 return SizedBox(
                      width: 200,
                      height: context.screenheight * 0.42,
                      child: SimpleBarcodeScanner(
                        // scanType: ScanType.qr,
                        scaleHeight: 200,
                        delayMillis: 2000,
                        scaleWidth: 500,
                        continuous: true,
    
                        onScanned: (code) {
                          print(code);
                          
                          if(providerVM.getProductReponse.status != Status.loading){
                            Helper.showFullScreenLoader(context);
                            ref.read(productProvider.notifier).getProductData(code);
                          }
                         
                          // setState(() {
                          //   result = code;
                          // });
                        },
                        
                        
                        onBarcodeViewCreated: (BarcodeViewController controller) {
                          this.controller = controller;
                        },
                      ));
               }
             ),
           ),
          Padding(padding: EdgeInsets.symmetric(
            vertical: 20.r,
            horizontal: 50.r
          ), child: Text("Align Barcode Within The Frame To Scan", textAlign: TextAlign.center, style: context.textStyle.displayMedium!.copyWith(
            fontSize: 16.sp
          ),),)

        ],),
    );
  }
}
