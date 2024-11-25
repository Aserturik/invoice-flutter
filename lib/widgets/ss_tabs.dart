import 'package:facturacion/widgets/ss_colors.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class SsTab {
  final String title;
  final Widget? child;
  final int initialTab;

  const SsTab({
    required this.title,
    this.child,
    this.initialTab = 0,
  });
}

class SsTabs extends StatefulWidget {
  final List<SsTab> tabs;
  final EdgeInsets? paddingTab;
  final int index;
  final ValueChanged<int>? onChange;
  final bool preChargeTabs;

  const SsTabs({
    required this.tabs,
    this.paddingTab,
    this.index = 0,
    this.onChange,
    this.preChargeTabs = false,
    super.key,
  });

  @override
  State<SsTabs> createState() => _SsTabsState();
}

class _SsTabsState extends State<SsTabs> {
  int index = 0;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: widget.paddingTab ?? EdgeInsets.zero,
          child: Stack(
            children: [
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 2,
                ),
              ),
              Row(
                children: List.generate(widget.tabs.length, (index) {
                  final e = widget.tabs[index];
                  BorderRadius borderRadius(double value) => BorderRadius.only(
                        topLeft:
                            index == 0 ? Radius.circular(value) : Radius.zero,
                        bottomLeft:
                            index == 0 ? Radius.circular(value) : Radius.zero,
                        topRight: index == widget.tabs.length - 1
                            ? Radius.circular(value)
                            : Radius.zero,
                        bottomRight: index == widget.tabs.length - 1
                            ? Radius.circular(value)
                            : Radius.zero,
                      );
                  return Expanded(
                    child: _buildInkWell(
                      index,
                      borderRadius,
                      e,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (widget.preChargeTabs)
          Expanded(
            child: IndexedStack(
              index: index,
              children: widget.tabs.map((e) => e.child!).toList(),
            ),
          )
        else
          Expanded(
            child: LazyLoadIndexedStack(
              index: index,
              children: widget.tabs.map((e) => e.child!).toList(),
            ),
          ),
      ],
    );
  }

  InkWell _buildInkWell(
    int index,
    BorderRadius Function(double value) borderRadius,
    SsTab e,
  ) {
    return InkWell(
      onTap: () {
        this.index = index;
        setState(() {});
        widget.onChange?.call(index);
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 1, left: 0, top: 1, right: 0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: borderRadius(5),
        ),
        child: ClipRRect(
          borderRadius: borderRadius(4),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: this.index == index
                      ? const BorderSide(
                          color: SsColors.orange,
                          width: 1,
                        )
                      : BorderSide.none,
                )),
            child: Text(
              e.title,
              style: TextStyle(
                color: this.index == index ? SsColors.orange : Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
