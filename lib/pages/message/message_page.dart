import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/extensions/datetime_extension.dart';
import 'package:lime/nav/routes.dart';
import 'package:lime/widgets/empty_screen.dart';
import 'package:lime/widgets/tab_bar_item.dart';

part 'src/exception_message.dart';
part 'src/system_advisoty.dart';
part 'src/reminder_message.dart';

class MessagePage extends StatefulHookConsumerWidget {
  const MessagePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.messageSettings),
            icon: const Icon(Icons.settings_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: cs.primary,
            indicatorColor: cs.primary,
            unselectedLabelColor: cs.onSurfaceVariant.withOpacity(0.5),
            tabs: const [
              TabBarItem(label: '异常消息'),
              TabBarItem(label: '提醒消息'),
              TabBarItem(label: '系统公告'),
            ],
          ),
          SizedBox(height: 8.h),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: const [
              _ExceptionMessage(),
              _ReminderMessage(),
              _SystemAdvisory(),
            ],
          ))
        ],
      ),
    );
  }
}
