import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' hide NavigationDecision, NavigationRequest;
import 'package:webview_flutter/webview_flutter.dart';

class VideoEmbed extends StatelessWidget {
  final String embedUrl;
  const VideoEmbed({Key? key, required this.embedUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = Html(
      data: """
      <iframe width="560" height="300" src="https://www.youtube.com/embed/$embedUrl" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
      """,
      customRender: {
        "iframe": (RenderContext context, Widget child) {
          final attrs = context.tree.element?.attributes;
          if (attrs != null) {
            double? width = double.tryParse(attrs['width'] ?? "");
            double? height = double.tryParse(attrs['height'] ?? "");
            return SizedBox(
              width: width ?? (height ?? 250) * 2,
              height: height ?? (width ?? 450) / 2,
              child: WebView(
                initialUrl: attrs['src'] ?? "about:blank",
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request) async => NavigationDecision.prevent,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      },
    );
    return body;
  }
}
