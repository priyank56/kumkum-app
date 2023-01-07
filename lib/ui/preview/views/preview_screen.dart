import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/params.dart';
import '../../../utils/sizer_utils.dart';
import '../controllers/preview_controller.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewController>(
        id: Constant.isShowProgressUpload,
        builder: (logic) {
      return ProgressDialog(
        child: _webView(context,logic),
        inAsyncCall: logic.isShowProgress,
      );
    });
  }

  _webView(BuildContext context, PreviewController logic) {
    return WillPopScope(
      onWillPop:  () async {
        if(logic.isFromPreviewScreen == Constant.isFromSubmit) {
          Get.back();
          Get.back();
        } else if(logic.isFromPreviewScreen == Constant.isFromPreview) {
          var map = <String,String>{};
          map.putIfAbsent(Params.createdCardId, () => logic.createData.marriageInvitationCardId.toString());
          Get.back(result: map);
        } else if(logic.isFromPreviewScreen == Constant.isFromCategoryPreview) {
          Get.back();
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<PreviewController>(builder: (logic) {
            return Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.offAllNamed(AppRoutes.main);
                        // Get.back();
                        if(logic.isFromPreviewScreen == Constant.isFromSubmit) {
                          Get.back();
                          Get.back();
                        } else if(logic.isFromPreviewScreen == Constant.isFromPreview) {
                          var map = <String,String>{};
                          map.putIfAbsent(Params.createdCardId, () => logic.createData.marriageInvitationCardId.toString());
                          Get.back(result: map);
                        } else if(logic.isFromPreviewScreen == Constant.isFromCategoryPreview) {
                          Get.back();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(Sizes.height_2),
                        child: SvgPicture.asset(
                          "assets/svg/login_flow/ic_back.svg",
                          height: Sizes.height_4,
                          width: Sizes.height_4,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "txtPreview".tr,
                          style: TextStyle(
                              color: CColor.black,
                              fontSize: FontSize.size_14,
                              fontWeight: FontWeight.w500,
                              fontFamily: Constant.appFont),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        logic.showCustomizeDialog(context, logic);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: Sizes.width_5),
                        child: SvgPicture.asset("assets/svg/ic_download.svg",
                            height: Sizes.height_3, width: Sizes.height_3),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: (logic.previewURL != "")
                      ? WebView(
                          initialUrl: logic.previewURL,
                          /*initialUrl:
                          'about:blank',*/
                          onWebViewCreated: (controller) {
                            // logic.webViewController = controller;
                            // logic.webViewController!.loadUrl('data:text/html;base64,${base64Encode(const Utf8Encoder().convert(logic.kNavigationExamplePage))}');
                          },
                          javascriptMode: JavascriptMode.unrestricted,
                          onPageFinished: (url) {
                            logic.changeProgressValue(false);
                          },
                        )
                      /*Container(
                        child: InAppWebView(
                          initialUrlRequest: URLRequest(url: Uri.parse(logic.previewURL.toString()) ),
                            initialOptions: InAppWebViewGroupOptions(
                              android: AndroidInAppWebViewOptions(
                                minimumLogicalFontSize: 1,
                                defaultFixedFontSize: 1,
                                defaultFontSize: 1,
                              ),
                              crossPlatform: InAppWebViewOptions(
                                minimumFontSize: 5,
                                supportZoom: true,
                              )

                          ),
                          onWebViewCreated: (InAppWebViewController controller) {
                          },
                          onLoadStart: (controller, url) {

                          },
                          onLoadStop:  (controller, url) {
                            logic.changeProgressValue(false);
                          },
                          onProgressChanged: (InAppWebViewController controller, int progress) {

                          },
                        ),
                      )*/
                      : Container(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

}
