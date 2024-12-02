import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SsListView extends StatefulWidget {
  final ScrollController? controller;
  final VoidFutureCallBack? onRefresh;
  final VoidFutureCallBack? onLoadMore;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double? cacheExtent;
  final Axis scrollDirection;

  const SsListView({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.cacheExtent,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<SsListView> createState() => _SsListViewState();
}

class _SsListViewState extends State<SsListView> {
  late ScrollController controller;
  late double cacheExtent;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    controller = widget.controller ?? ScrollController();
    cacheExtent = widget.cacheExtent ?? double.infinity;
    controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const BouncingScrollPhysics(),
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoadMore != null,
      controller: _refreshController,
      scrollController: controller,
      scrollDirection: widget.scrollDirection,
      cacheExtent: cacheExtent,
      onLoading: () async {
        await widget.onLoadMore!().then((value) {
          _refreshController.loadComplete();
        }).catchError((e) {
          _refreshController.loadFailed();
        });
      },
      onRefresh: () async {
        await widget.onRefresh!().then((value) {
          _refreshController.refreshCompleted();
        }).catchError((e) {
          _refreshController.refreshFailed();
        });
      },
      child: ListView.builder(
        scrollDirection: widget.scrollDirection,
        cacheExtent: cacheExtent,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
      ),
    );
  }

  Future<void> _scrollListener() async {
    if (kIsWeb &&
        _refreshController.position != null &&
        (_refreshController.position!.pixels -
                _refreshController.position!.maxScrollExtent) >=
            0) {
      await _refreshController.requestLoading();
    }
  }
}
