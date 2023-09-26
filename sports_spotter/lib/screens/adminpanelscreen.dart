import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('$baseUrl/admin/'));
  @override
  void dispose() {
    final WebViewCookieManager cookieManager = WebViewCookieManager();
    cookieManager.clearCookies();
    controller.clearLocalStorage();
    controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Management console'),
      ),
      body: WebViewWidget(controller: controller),
      bottomNavigationBar: SizedBox(
        height: 72,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    controller.goBack();
                  }
                },
                icon: const Icon(Icons.arrow_back)),
            IconButton(
                onPressed: () async {
                  if (await controller.canGoForward()) {
                    controller.goForward();
                  }
                },
                icon: const Icon(Icons.arrow_forward)),
            IconButton(
                onPressed: () async {
                  controller.reload();
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}
