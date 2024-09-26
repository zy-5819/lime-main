import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sortable_wrap/flutter_sortable_wrap.dart';
import 'package:lime/pages/module.dart';

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
  ValueNotifier<bool> _addShow = ValueNotifier(true);
  ValueNotifier<bool> _delateShow = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _isUpdate = true;
    _contentShow.value = true;
    _positiones = [];
    _children = [
      SizedBox(
        width: double.infinity,
        height: 0.1.h,
      )
    ];
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
        onTap: (index) {
          setState(() {
            _children.removeAt(index);
          });
        },
        text: i.toString(),
        color: colors[i % colors.length],
        positiones: _positiones,
        isLast: i == 20,
        index: i,
        valueListenable: _delateShow,
        onLongPress: () {
          setState(() {});
          _delateShow.value = true;
          _addShow.value = false;
          _contentShow.value = false;
        },
        itemBuilder: (currentIndex, t, widget) {
          setState(() {
            if (_isUpdate) {
              _children.insert(t + 1, widget);
              _index = t + 1;
            } else {
              _children.removeAt(_index);
              if (t == _positiones.length + 1) {
                _children.insert(t + 1, widget);
                _index = t + 1;
              } else {
                _children.insert(t, widget);
                _index = t;
              }
            }

            _lastIndex = currentIndex;
          });
        },
      ));
    }
    _children.add(_AddButton(
      valueListenable: _addShow,
      onTap: () async {
        var x = await Navigator.of(context)
            .push<Item>(MaterialPageRoute(builder: (context) {
          return Module(
            data: ModuleData(true,
                onLongPress: () {
                  setState(() {});
                  _delateShow.value = true;
                  _addShow.value = false;
                  _contentShow.value = false;
                },
                positiones: _positiones,
                index: _children.length - 2,
                itemBuilder: (currentIndex, t, widget) {
                  setState(() {
                    if (_isUpdate) {
                      _children.insert(t + 1, widget);
                      _index = t + 1;
                    } else {
                      _children.removeAt(_index);
                      _children.insert(t, widget);
                      _index = t;
                    }

                    _lastIndex = currentIndex;
                  });
                },
                valueListenable: _delateShow),
          );
        }));
        setState(() {
          _children.insert(_children.length - 1, x!);
        });
      },
    ));
  }

  void _initData() {
    print(_children.length);
    for (int i = 0; i < _children.length; i++) {
      if (_children[i] is Item) {
        _children[i] = Item(
          onTap: (index) {
            setState(() {
              _children.removeAt(index);
            });
          },
          text: '${(_children[i] as Item).text}-${i.toString()}',
          color: colors[i % colors.length],
          positiones: _positiones,
          isLast: i == 20,
          index: i,
          valueListenable: _delateShow,
          onLongPress: () {
            setState(() {});
            _delateShow.value = true;
            _addShow.value = false;
            _contentShow.value = false;
          },
          itemBuilder: (currentIndex, t, widget) {
            setState(() {
              if (_isUpdate) {
                _children.insert(t + 1, widget);
                _index = t + 1;
              } else {
                _children.removeAt(_index);
                if (t == _positiones.length + 1) {
                  _children.insert(t + 1, widget);
                  _index = t + 1;
                } else {
                  _children.insert(t, widget);
                  _index = t;
                }
              }

              _lastIndex = currentIndex;
            });
          },
        );
      } else {
        continue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SortableWrapOptions options = SortableWrapOptions();
    options.isLongPressDraggable = false;
    options.draggableFeedbackBuilder = (Widget child) {
      return Material(
        //elevation: 18.0,
        // shadowColor: Colors.grey,
        color: Colors.transparent,
        //borderRadius: BorderRadius.zero,
        child: child,
      );
    };
    if (_isUpdate) {
      _positiones.clear();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {});
        _delateShow.value = false;
        _addShow.value = true;
      }),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              //alignment: Alignment.topCenter,
              color: Colors.white.withAlpha(64),
              child: Transform.scale(
                scale: _delateShow.value ? 1.05 : 1,
                child: SortableWrap(
                  key: Key(Random().nextDouble().toString()),
                  spacing: 0,
                  runSpacing: 15,
                  children: _children,
                  options: options,
                  onSorted: (int oldIndex, int newIndex) {
                    setState(() {
                      _children.insert(newIndex, _children.removeAt(oldIndex));
                      _initData();
                    });
                    // _addShow.value = true;
                    // _delateShow.value = false;
                  },
                  onSortCancel: (index) {
                    // _addShow.value = true;
                    // _delateShow.value = false;
                  },
                  onSortStart: (index) {
                    _contentShow.value = false;
                    _addShow.value = false;
                    //_delateShow.value = false;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
// 占位
            Expanded(child: _Module())
          ],
        ),
      ),
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
  final ValueListenable<bool> valueListenable;
  final void Function() onLongPress;
  final void Function(int index) onTap;

  const Item({
    super.key,
    required this.text,
    required this.color,
    required this.positiones,
    required this.isLast,
    required this.index,
    required this.itemBuilder,
    required this.valueListenable,
    required this.onLongPress,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    if (_isUpdate) {
      WidgetsBinding.instance.addPostFrameCallback((d) {
        positiones.add((context.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero));
        if (isLast) {
          if (positiones.isNotEmpty) {
            var i = positiones.indexWhere((v) => v.dy > positiones[0].dy);
            if (i < 0) {
              i = positiones.length;
            }
            i = i + 1;
            itemBuilder.call(
                i,
                positiones.indexWhere((v) => v.dy > positiones[0].dy),
                _Content());
          }

          _isUpdate = false;
        }
      });
    }

    return ValueListenableBuilder<bool>(
        valueListenable: valueListenable,
        builder: (context, value, child) {
          return Transform.scale(
              scale: value ? 1.05 : 1,
              child: Stack(clipBehavior: Clip.none, children: [
                AbsorbPointer(
                  absorbing: value,
                  child: GestureDetector(
                    onTap: () {
                      if (index == _lastIndex) {
                        _contentShow.value = !_contentShow.value;
                      } else {
                        _contentShow.value = true;
                      }
                      var i = positiones
                          .indexWhere((v) => v.dy > positiones[index].dy);
                      if (i < 0) {
                        i = positiones.length;
                      }
                      i = i + 1;
                      print(i);
                      itemBuilder.call(index, i, _Content());
                    },
                    onLongPressStart: (d) {
                      onLongPress.call();
                    },
                    child: Draggable<int>(
                      // 返回一个Draggable
                      // 必须要一个Material，不然拖动时Text会有双下划线
                      data: index,
                      feedback: Material(
                        child: Transform.scale(
                          scale: 1.5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            constraints: BoxConstraints(minWidth: 50.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              color: color,
                            ),
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        constraints: BoxConstraints(minWidth: 50.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          color: index == _lastIndex ? color : null,
                        ),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                value
                    ? Positioned(
                        top: -8,
                        child: InkWell(
                          onTap: () {
                            onTap.call(index);
                          },
                          child: Icon(Icons.highlight_remove_outlined),
                        ))
                    : const SizedBox.shrink()
              ]));
        });
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
        child: Card(child: child),
      );
    };
    return ValueListenableBuilder<bool>(
        valueListenable: _contentShow,
        builder: (context, value, child) {
          return value
              ? GestureDetector(
                  onLongPress: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(128),
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    width: double.infinity,
                    child: SortableWrap(
                      key: Key(Random().nextDouble().toString()),
                      onSorted: (int oldIndex, int newIndex) {},
                      spacing: 10,
                      runSpacing: 15,
                      options: options,
                      children: [
                        LongPressDraggable(
                            child: Container(
                              padding: EdgeInsets.all(5.sp),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text('data1'),
                            ),
                            feedback: Material(
                              child: Transform.scale(
                                scale: 1.5,
                                child: Container(
                                  padding: EdgeInsets.all(5.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Text('data1'),
                                ),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.all(5.sp),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text('data2'),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.sp),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text('data3'),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.sp),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text('data4'),
                        ),
                      ],
                      onSortStart: (index) {
                        print(index);
                      },
                    ),
                  ),
                )
              : const SizedBox(
                  width: 0.1,
                  height: 0.1,
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
            height: 30.h,
            width: 50.w,
            color: Colors.red,
            child: Text(data.data.toString()),
          ));
        });
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  final ValueListenable<bool> valueListenable;
  final void Function()? onTap;

  const _AddButton({required this.valueListenable, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: valueListenable,
        builder: (context, value, child) {
          return value
              ? GestureDetector(
                  onLongPress: () {},
                  onTap: onTap,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                    constraints: BoxConstraints(minWidth: 50.w),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.grey),
                    //   borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    // ),
                    child: const Icon(Icons.add_circle_outline_outlined),
                  ))
              : const SizedBox(
                  width: 0.1,
                  height: 0.1,
                );
        });
  }
}
