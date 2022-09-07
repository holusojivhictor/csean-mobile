import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/shared/bottom_sheets/common_bottom_sheet.dart';
import 'package:csean_mobile/presentation/shared/bottom_sheets/common_button_bar.dart';
import 'package:csean_mobile/presentation/shared/item_popup_menu_filter.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/payment_type_button_bar.dart';
import 'package:csean_mobile/presentation/shared/sort_direction_popupmenu_filter.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class EventBottomSheet extends StatelessWidget {
  const EventBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      title: 'Filters',
      titleIcon: Icons.sort,
      showCancelButton: false,
      showOkButton: false,
      child: BlocBuilder<CommunityEventsBloc, CommunityEventsState>(
        builder: (context, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Main'),
              PaymentTypeButtonBar(
                selectedValues: state.tempPaymentTypes,
                onClick: (v) => context.read<CommunityEventsBloc>().add(CommunityEventsEvent.eventPaymentTypeChanged(v)),
              ),
              const Text('Others'),
              _OtherFilters(
                tempItemRegisterStatusType: state.tempStatusType,
                tempEventFilterType: state.tempEventFilterType,
                tempSortDirectionType: state.tempSortDirectionType,
              ),
              const _ButtonBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtherFilters extends StatelessWidget {
  final ItemRegisterStatusType? tempItemRegisterStatusType;
  final EventFilterType tempEventFilterType;
  final SortDirectionType tempSortDirectionType;
  const _OtherFilters({
    Key? key,
    required this.tempItemRegisterStatusType,
    required this.tempEventFilterType,
    required this.tempSortDirectionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonButtonBar(
      spacing: 5,
      alignment: WrapAlignment.spaceBetween,
      children: [
        ItemPopupMenuFilterWithAllValue(
          toolTipText: 'Registered / Not Registered',
          values: ItemRegisterStatusType.values.map((e) => e.index).toList(),
          selectedValue: tempItemRegisterStatusType?.index,
          onAllOrValueSelected: (v) => context.read<CommunityEventsBloc>().add(CommunityEventsEvent.itemRegisterStatusChanged(v != null ? ItemRegisterStatusType.values[v] : null)),
          icon: Icon(Icons.tune, size: Styles.getIconSizeForItemPopupMenuFilter(true)),
          itemText: (val, _) => Assets.translateItemRegisterStatusType(ItemRegisterStatusType.values[val]),
        ),
        ItemPopupMenuFilter<EventFilterType>(
          toolTipText: 'Sort by',
          selectedValue: tempEventFilterType,
          values: EventFilterType.values,
          onSelected: (v) => context.read<CommunityEventsBloc>().add(CommunityEventsEvent.eventFilterChanged(v)),
          icon: Icon(Icons.filter_list, size: Styles.getIconSizeForItemPopupMenuFilter(true)),
          itemText: (val, _) => Assets.translateEventFilterType(val),
        ),
        SortDirectionPopupMenuFilter(
          selectedSortDirection: tempSortDirectionType,
          onSelected: (v) => context.read<CommunityEventsBloc>().add(CommunityEventsEvent.sortDirectionChanged(v)),
          icon: Icon(Icons.sort, size: Styles.getIconSizeForItemPopupMenuFilter(true)),
        ),
      ],
    );
  }
}


class _ButtonBar extends StatelessWidget {
  const _ButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CommonButtonBar(
      children: <Widget>[
        OutlinedButton(
          onPressed: () {
            context.read<CommunityEventsBloc>().add(const CommunityEventsEvent.cancelChanges());
            Navigator.pop(context);
          },
          child: Text('Cancel', style: TextStyle(color: theme.primaryColor)),
        ),
        OutlinedButton(
          onPressed: () {
            context.read<CommunityEventsBloc>().add(const CommunityEventsEvent.resetFilters());
            Navigator.pop(context);
          },
          child: Text('Reset', style: TextStyle(color: theme.primaryColor)),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(theme.primaryColor.withOpacity(0.7)),
          ),
          onPressed: () {
            context.read<CommunityEventsBloc>().add(const CommunityEventsEvent.applyFilterChanges());
            Navigator.pop(context);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
