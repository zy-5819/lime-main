import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sortable_wrap/flutter_sortable_wrap.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

bool _isUpdate = true;
ValueNotifier<bool> _contentShow = ValueNotifier(true);
int _lastIndex = 0;

class AppState extends State<App> {
  int _index = 0;

  late List<Offset> _positiones;
  late List<Widget> _children;
  late List<Color> colors;
  late int test;

  @override
  void initState() {
    super.initState();
    _isUpdate = true;
    _contentShow.value = true;
    _positiones = [];
    _children = [];
    test = 0;

    Color alphaColor(Color color, {int alpha = 128}) => color.withAlpha(alpha);
    colors = [
      Colors.redAccent,
      Colors.blueAccent,
      Colors.pinkAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.purpleAccent,
    ];
    colors = colors.map((e) => alphaColor(e)).toList();
    for (int i = 0; i < 21; i++) {
      _children.add(Item(
        text: i.toString(),
        color: colors[i % colors.length],
        positiones: _positiones,
        isLast: i == 20,
        index: i,
        itemBuilder: (currentIndex, t, widget) {
          setState(() {
            if (_isUpdate) {
              _children.insert(t, widget);
            } else {
              _children.removeAt(_index);
              _children.insert(t, widget);
            }
            _index = t;
            _lastIndex = currentIndex;
          });
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SortableWrapOptions options = SortableWrapOptions();
    options.draggableFeedbackBuilder = (Widget child) {
      return Material(
        elevation: 18.0,
        shadowColor: Colors.grey,
        color: Colors.transparent,
        borderRadius: BorderRadius.zero,
        child: Card(child: child),
      );
    };
    if (_isUpdate) {
      _positiones.clear();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isUpdate = true;
          });
        },
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            //alignment: Alignment.topCenter,
            color: Colors.white.withAlpha(64),
            child: SortableWrap(
              key: Key(Random().nextDouble().toString()),
              onSorted: (int oldIndex, int newIndex) {},
              spacing: 10,
              runSpacing: 15,
              options: options,
              children: _children,
              onSortStart: (index) {
                _contentShow.value = false;
              },
            ),
          ),
          SizedBox(
            height: 100,
          ),
// 占位
          Expanded(child: _Module())
        ],
      )),
    );
  }
}

class Item extends StatelessWidget {
  final String text;
  final Color color;
  final List<Offset> positiones;
  final bool isLast;
  final int index;
  final void Function(int currentIndex, int index, Widget content) itemBuilder;

  const Item({
    super.key,
    required this.text,
    required this.color,
    required this.positiones,
    required this.isLast,
    required this.index,
    required this.itemBuilder,
  });
  @override
  Widget build(BuildContext context) {
    if (_isUpdate) {
      WidgetsBinding.instance.addPostFrameCallback((d) {
        positiones.add((context.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero));
        if (isLast) {
          itemBuilder.call(
              index,
              positiones.indexWhere((v) => v.dy > positiones[0].dy),
              _Content());
          _isUpdate = false;
        }
      });
    }

    return GestureDetector(
        onTap: () {
          if (index == _lastIndex) {
            _contentShow.value = !_contentShow.value;
          } else {
            _contentShow.value = true;
          }
          var i = positiones.indexWhere((v) => v.dy > positiones[index].dy);
          if (i < 0) {
            i = positiones.length;
          }
          itemBuilder.call(index, i, _Content());
        },
        child: LongPressDraggable<int>(
          // 返回一个Draggable
          // 必须要一个Material，不然拖动时Text会有双下划线
          data: index,
          feedback: Material(
            child: Container(
              height: 100,
              width: 100,
              color: Colors.blueAccent,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          child: ColoredBox(
            color: color,
            child: SizedBox(
                width: 30, height: 30, child: Center(child: Text(text))),
          ),
        ));
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SortableWrapOptions options = SortableWrapOptions();
    options.draggableFeedbackBuilder = (Widget child) {
      return Material(
        elevation: 18.0,
        shadowColor: Colors.grey,
        color: Colors.transparent,
        borderRadius: BorderRadius.zero,
        child: Card(child: child),
      );
    };
    return ValueListenableBuilder<bool>(
        valueListenable: _contentShow,
        builder: (context, value, child) {
          return value
              ? Container(
                  color: Colors.red,
                  width: double.infinity,
                  height: 50,
                  child: SortableWrap(
                    key: Key(Random().nextDouble().toString()),
                    onSorted: (int oldIndex, int newIndex) {},
                    spacing: 10,
                    runSpacing: 15,
                    options: options,
                    children: [Text('data1'), Text('data2'), Text('data3')],
                    onSortStart: (index) {},
                  ),
                )
              : const SizedBox(
                  width: 0.0000000001,
                );
        });
  }
}

class _Module extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModuleState();
}

class _ModuleState extends State<_Module> {
  late List<Widget> _children;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _children = [Text('data')];
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      // 用来接收数据的 Widget
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.green,
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              runSpacing: 15,
              children: _children,
            ),
          ),
        );
      },
      // 用来接收数据
      onAcceptWithDetails: (data) {
        setState(() {
          _children.add(Container(
            height: 200.h,
            width: double.infinity,
            color: Colors.red,
            child: Text(data.data.toString()),
          ));
        });
      },
    );
  }
}
