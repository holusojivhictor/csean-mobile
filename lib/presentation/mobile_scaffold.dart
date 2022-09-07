import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/blogs/blogs_page.dart';
import 'package:csean_mobile/presentation/events/events_page.dart';
import 'package:csean_mobile/presentation/forums/forums_page.dart';
import 'package:csean_mobile/presentation/home/home_page.dart';
import 'package:csean_mobile/presentation/settings/settings_page.dart';
import 'package:csean_mobile/presentation/shared/extensions/focus_scope_node_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileScaffold extends StatefulWidget {
  final int defaultIndex;
  final TabController tabController;
  const MobileScaffold({
    Key? key,
    required this.defaultIndex,
    required this.tabController,
  }) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  late int _index;

  @override
  void initState() {
    _index = widget.defaultIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<MainTabBloc, MainTabState>(
          listener: (ctx, state) async {
            state.maybeMap(
              initial: (s) => _changeCurrentTab(s.currentSelectedTab),
              orElse: () => {},
            );
          },
          child: TabBarView(
            controller: widget.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomePage(),
              EventsPage(),
              ForumsPage(),
              BlogsPage(),
              SettingsPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).dividerColor,
        currentIndex: _index,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(label: 'Home',icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(label: 'Events',icon: Icon(Icons.event_available_rounded)),
          BottomNavigationBarItem(label: 'Forums',icon: Icon(Icons.forum_rounded)),
          BottomNavigationBarItem(label: 'Blogs',icon: Icon(Icons.library_books_rounded)),
          BottomNavigationBarItem(label: 'Settings',icon: Icon(Icons.settings_rounded)),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _goToTab(index),
      ),
    );
  }

  void _changeCurrentTab(int index) {
    FocusScope.of(context).removeFocus();
    widget.tabController.index = index;
    setState(() {
      _index = index;
    });
  }

  void _goToTab(int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));
}
