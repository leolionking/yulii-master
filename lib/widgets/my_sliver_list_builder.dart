import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/no_data.dart';

class MySliverListBuilder<T> extends StatelessWidget {
  final bool hasDivider;
  final List<T> items;
  final Widget divider;
  final Widget Function(BuildContext context, T item, int index) onItemBuilder;

  const MySliverListBuilder({
    Key key,
    @required this.items,
    @required this.onItemBuilder,
    this.hasDivider = true,
    this.divider = const Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.lgPadding,
      ),
      child: const Divider(
        color: AppColors.dividerColor,
      ),
    ),
  })  : assert(items != null),
        assert(divider != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? SliverFillRemaining(
            hasScrollBody: false,
            child: SizedBox.expand(
              child: NoData(),
            ),
          )
        : SliverList(
            key: PageStorageKey("my_sliver_list_builder_list"),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final itemIndex = index ~/ 2;

                if (index.isEven) {
                  return onItemBuilder(context, items[itemIndex], itemIndex);
                }
                return divider;
              },
              childCount:
                  Math.max(0, hasDivider ? items.length * 2 : items.length),
              semanticIndexCallback: hasDivider
                  ? (_, localIndex) {
                      if (localIndex.isEven) {
                        return localIndex ~/ 2;
                      }
                      return null;
                    }
                  : null,
            ),
          );
  }
}
