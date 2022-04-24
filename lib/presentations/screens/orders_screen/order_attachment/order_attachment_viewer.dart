import 'package:cached_network_image/cached_network_image.dart';
import 'package:delicious_inventory_system/presentations/utils/constant.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'bloc/order_attachment_bloc.dart';

class OrderAttachmentViewer extends StatefulWidget {
  const OrderAttachmentViewer({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final int orderId;

  @override
  State<OrderAttachmentViewer> createState() => _OrderAttachmentViewerState();
}

class _OrderAttachmentViewerState extends State<OrderAttachmentViewer> {
  int pageIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderAttachmentBloc>(
      create: (_) => OrderAttachmentBloc()
        ..add(
          GetOrderAttachment(widget.orderId),
        ),
      child: Builder(builder: (context) {
        return BlocBuilder<OrderAttachmentBloc, OrderAttachmentState>(
          builder: (context, state) {
            return Column(
              children: [
                Flexible(
                  child: SizedBox(
                    child: PhotoViewGallery.builder(
                      pageController: pageController,
                      itemCount: state.attachments.length,
                      builder: (context, index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: CachedNetworkImageProvider(
                            state.attachments[index].imageUrl,
                          ),
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 2,
                        );
                      },
                      scrollPhysics: const BouncingScrollPhysics(),
                      backgroundDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: FluentTheme.of(context).acrylicBackgroundColor,
                      ),
                      enableRotation: true,
                      onPageChanged: (index) {
                        setState(() {
                          pageIndex = index;
                        });
                      },
                      loadingBuilder: (context, event) => Center(
                        child: SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: ProgressRing(
                            backgroundColor: Colors.orange,
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    event.expectedTotalBytes!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Constant.columnSpacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(FluentIcons.previous),
                      onPressed: pageIndex == 0
                          ? null
                          : () {
                              if (pageIndex > 0) {
                                pageController.animateToPage(
                                  pageIndex -= 1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              }
                            },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Image ${pageIndex + 1}",
                      style: const TextStyle(
                        fontSize: 17.0,
                        decoration: null,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: const Icon(FluentIcons.next),
                      onPressed: pageIndex == state.attachments.length - 1
                          ? null
                          : () {
                              if (pageIndex < state.attachments.length - 1) {
                                pageController.animateToPage(
                                  pageIndex += 1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              }
                            },
                    ),
                  ],
                )
              ],
            );
          },
        );
      }),
    );
  }
}
