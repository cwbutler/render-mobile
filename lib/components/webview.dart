import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RenderWebView extends HookConsumerWidget {
  final String? url;
  final JavascriptMode javascriptMode;
  const RenderWebView({
    Key? key,
    this.url,
    this.javascriptMode = JavascriptMode.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);

    return Stack(
      children: [
        WebView(
          initialUrl: url,
          backgroundColor: Colors.black,
          javascriptMode: javascriptMode,
          onPageFinished: ((url) => isLoading.value = false),
        ),
        Visibility(
          visible: isLoading.value,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
