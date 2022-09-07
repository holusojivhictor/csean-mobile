import 'dart:async';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:csean_mobile/injection.dart';
import 'package:csean_mobile/presentation/mobile_scaffold.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> with SingleTickerProviderStateMixin {
  final cseanService = getIt<CseanService>();
  bool _didChangeDependencies = false;
  late TabController _tabController;
  final _defaultIndex = 0;
  DateTime? backButtonPressTime;
  
  @override
  void initState() {
    _tabController = TabController(
      initialIndex: _defaultIndex,
      length: 5,
      vsync: this,
    );
    cseanService.getDownloaded();
    _getTopicsAndMessages();
    _getResourceItems();
    super.initState();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didChangeDependencies) return;
    _didChangeDependencies = true;
    context.read<DataBloc>().add(const DataEvent.initData());
    context.read<HomeBloc>().add(const HomeEvent.init());
    context.read<SettingsBloc>().add(const SettingsEvent.init());
    context.read<ProfileBloc>().add(const ProfileEvent.loadProfile());
    context.read<CommunityEventsBloc>().add(const CommunityEventsEvent.init());
    context.read<BlogsBloc>().add(const BlogsEvent.init());
    context.read<TransactionsBloc>().add(const TransactionsEvent.init());
    context.read<ForumsBloc>().add(const ForumsEvent.init());
    context.read<ProgressTrackerBloc>().add(const ProgressTrackerEvent.init());
    context.read<ResourcesBloc>().add(const ResourcesEvent.init());
    context.read<SupportBloc>().add(const SupportEvent.init());
    context.read<PaymentBloc>().add(const PaymentEvent.loadDetails());
  }

  Future<void> _getTopicsAndMessages() async {
    final forumsData = cseanService.getAllForumsData();
    for (var element in forumsData) {
      final id = element.id;
      await cseanService.getTopicsFromForum(id);
    }
    final topicsData = cseanService.getAllTopicsData();
    for (var element in topicsData) {
      final id = element.id;
      await Future.delayed(const Duration(milliseconds: 1050), () async {
        await cseanService.getDiscussionsFromTopic(id);
      });
    }
  }

  Future<void> _getResourceItems() async {
   final resources = cseanService.getSubCategories();
   for (var element in resources) {
     final categoryId = element.categoryId;
     final subCategoryId = element.id;
     await cseanService.getSubcategoryItemsFromIds(categoryId, subCategoryId);
   }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => handleWillPop(),
      child: ResponsiveBuilder(
        builder: (ctx, size) => size.isDesktop || size.isTablet
            ? MobileScaffold(defaultIndex: _defaultIndex, tabController: _tabController)
            : MobileScaffold(defaultIndex: _defaultIndex, tabController: _tabController),
      ),
    );
  }

  void _goToTab(int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));

  Future<bool> handleWillPop() async {
    if (_tabController.index != _defaultIndex) {
      _goToTab(_defaultIndex);
      return false;
    }

    final settings = context.read<SettingsBloc>();
    if (!settings.doubleBackToClose()) {
      return true;
    }

    final now = DateTime.now();
    final mustWait = backButtonPressTime == null || now.difference(backButtonPressTime!) > ToastUtils.toastDuration;

    if (mustWait) {
      backButtonPressTime = now;
      final fToast = ToastUtils.of(context);
      ToastUtils.showInfoToast(fToast, 'Press once again to exit');
      return false;
    }

    return true;
  }
}
