import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sortable_wrap/flutter_sortable_wrap.dart';
import 'package:lime/pages/module.dart';
import 'package:lime/pages/shop.dart';

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

  late List<Offset> _shopPositiones;
  late List<Offset> _cellPositiones;
  late List<Widget> _shops;
  late List<Widget> _cells;
  late List<Color> colors;
  late int test;
  ValueNotifier<bool> _addShow = ValueNotifier(true);
  ValueNotifier<bool> _delateShow = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _isUpdate = true;
    _contentShow.value = true;
    _shopPositiones = [];
    _cellPositiones = [];
    _shops = [
      SizedBox(
        width: double.infinity,
        height: 0.1.h,
      )
    ];
    _cells = [];
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
    for (int i = 0; i < 1; i++) {
      _shops.add(ShopItem(
        onTap: (index) {
          setState(() {
            _shops.removeAt(index);
          });
        },
        text: '其他',
        color: colors[i % colors.length],
        positiones: _shopPositiones,
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
              _shops.insert(t + 1, widget);
              _index = t + 1;
            } else {
              _shops.removeAt(_index);
              if (t == _shopPositiones.length + 1) {
                _shops.insert(t + 1, widget);
                _index = t + 1;
              } else {
                _shops.insert(t, widget);
                _index = t;
              }
            }

            _lastIndex = currentIndex;
          });
        },
      ));
    }

    for (int i = 0; i < 3; i++) {
      _cells.add(TableItem(
        onTap: (index) {
          setState(() {
            _shops.removeAt(index);
          });
        },
        text: i == 0
            ? '名称'
            : i == 1
                ? '数量'
                : '单价',
        color: colors[i % colors.length],
        positiones: _cellPositiones,
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
              _shops.insert(t + 1, widget);
              _index = t + 1;
            } else {
              _shops.removeAt(_index);
              if (t == _shopPositiones.length + 1) {
                _shops.insert(t + 1, widget);
                _index = t + 1;
              } else {
                _shops.insert(t, widget);
                _index = t;
              }
            }

            _lastIndex = currentIndex;
          });
        },
      ));
    }
    _shops.add(_AddButton(
      valueListenable: _addShow,
      onTap: () async {
        var x = await Navigator.of(context)
            .push<ShopItem>(MaterialPageRoute(builder: (context) {
          return ShopModule(
            data: ShopData(true,
                onLongPress: () {
                  setState(() {});
                  _delateShow.value = true;
                  _addShow.value = false;
                  _contentShow.value = false;
                },
                positiones: _shopPositiones,
                index: _shops.length - 2,
                itemBuilder: (currentIndex, t, widget) {
                  setState(() {
                    if (_isUpdate) {
                      _shops.insert(t + 1, widget);
                      _index = t + 1;
                    } else {
                      _shops.removeAt(_index);
                      _shops.insert(t, widget);
                      _index = t;
                    }

                    _lastIndex = currentIndex;
                  });
                },
                valueListenable: _delateShow),
          );
        }));
        setState(() {
          _shops.insert(_shops.length - 1, x!);
        });
      },
    ));
    _cells.add(_AddButton(
      valueListenable: _addShow,
      onTap: () async {
        var x = await Navigator.of(context)
            .push<TableItem>(MaterialPageRoute(builder: (context) {
          return Module(
            data: ModuleData(true,
                onLongPress: () {
                  setState(() {});
                  _delateShow.value = true;
                  _addShow.value = false;
                  _contentShow.value = false;
                },
                positiones: _shopPositiones,
                index: _shops.length - 2,
                itemBuilder: (currentIndex, t, widget) {
                  setState(() {
                    if (_isUpdate) {
                      _shops.insert(t + 1, widget);
                      _index = t + 1;
                    } else {
                      _shops.removeAt(_index);
                      _shops.insert(t, widget);
                      _index = t;
                    }

                    _lastIndex = currentIndex;
                  });
                },
                valueListenable: _delateShow),
          );
        }));
        setState(() {
          _cells.insert(_cells.length - 1, x!);
        });
      },
    ));
  }

  void _initData() {
    print(_shops.length);
    for (int i = 0; i < _shops.length; i++) {
      if (_shops[i] is ShopItem) {
        _shops[i] = ShopItem(
          onTap: (index) {
            setState(() {
              _shops.removeAt(index);
            });
          },
          text: '${(_shops[i] as ShopItem).text}-${i.toString()}',
          color: colors[i % colors.length],
          positiones: _shopPositiones,
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
                _shops.insert(t + 1, widget);
                _index = t + 1;
              } else {
                _shops.removeAt(_index);
                if (t == _shopPositiones.length + 1) {
                  _shops.insert(t + 1, widget);
                  _index = t + 1;
                } else {
                  _shops.insert(t, widget);
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
      _shopPositiones.clear();
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
              constraints: BoxConstraints(maxHeight: 0.3.sh),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              //alignment: Alignment.topCenter,
              color: Colors.white.withAlpha(64),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('选择店家'),
                    Transform.scale(
                      scale: _delateShow.value ? 1.05 : 1,
                      child: SortableWrap(
                        key: Key(Random().nextDouble().toString()),
                        spacing: 0,
                        runSpacing: 15,
                        children: _shops,
                        options: options,
                        onSorted: (int oldIndex, int newIndex) {
                          setState(() {
                            _shops.insert(newIndex, _shops.removeAt(oldIndex));
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
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            Container(
              constraints: BoxConstraints(maxHeight: 0.3.sh),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              //alignment: Alignment.topCenter,
              color: Colors.white.withAlpha(64),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('表头组件:'),
                    Transform.scale(
                      scale: _delateShow.value ? 1.05 : 1,
                      child: SortableWrap(
                        key: Key(Random().nextDouble().toString()),
                        spacing: 0,
                        runSpacing: 15,
                        children: _cells,
                        options: options,
                        onSorted: (int oldIndex, int newIndex) {
                          setState(() {
                            _shops.insert(newIndex, _shops.removeAt(oldIndex));
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
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
// 占位
            Expanded(child: _Module())
          ],
        ),
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  final String text;
  final Color color;
  final List<Offset> positiones;
  final bool isLast;
  final int index;
  final void Function(int currentIndex, int index, Widget content) itemBuilder;
  final ValueListenable<bool> valueListenable;
  final void Function() onLongPress;
  final void Function(int index) onTap;

  const ShopItem({
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
            // itemBuilder.call(
            //     i,
            //     positiones.indexWhere((v) => v.dy > positiones[0].dy),
            //     _Content());
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
                        // itemBuilder.call(index, i, _Content());
                      },
                      onLongPressStart: (d) {
                        onLongPress.call();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
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
                      )),
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

class TableItem extends StatelessWidget {
  final String text;
  final Color color;
  final List<Offset> positiones;
  final bool isLast;
  final int index;
  final void Function(int currentIndex, int index, Widget content) itemBuilder;
  final ValueListenable<bool> valueListenable;
  final void Function() onLongPress;
  final void Function(int index) onTap;

  const TableItem({
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
                    child: Draggable<String>(
                      // 返回一个Draggable
                      // 必须要一个Material，不然拖动时Text会有双下划线
                      data: text,
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
                        margin:
                            EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
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
    _children = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('选择模板:'),
          Container(
            width: 1.sw,
            height: 120.h,
            child: DragTarget<String>(
              // 用来接收数据的 Widget
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50.h,
                      color: Colors.grey.withAlpha(100),
                      child: Icon(Icons.add),
                    ),
                    Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          children: _children,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: () {}, child: Text('添加')),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _children.clear();
                              });
                            },
                            child: Text('取消'))
                      ],
                    ),
                  ],
                );
              },
              // 用来接收数据
              onAcceptWithDetails: (data) {
                setState(() {
                  _children.add(Container(
                    height: 30.h,
                    width: 50.w,
                    color: Colors.red,
                    child: Text(data.data),
                  ));
                });
              },
            ),
          ),
          MyRadioListDemo(),
        ],
      ),
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

class MyRadioListDemo extends StatefulWidget {
  @override
  _MyRadioListDemoState createState() => _MyRadioListDemoState();
}

class _MyRadioListDemoState extends State<MyRadioListDemo> {
  // 用于保存单选按钮的值
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RadioListTile<int>(
            title: Text('选项 1'),
            value: 0,
            groupValue: _selectedIndex,
            onChanged: (value) {
              setState(() {
                _selectedIndex = value!;
              });
            },
          ),
          RadioListTile<int>(
            title: Text('选项 2'),
            value: 1,
            groupValue: _selectedIndex,
            onChanged: (value) {
              setState(() {
                _selectedIndex = value!;
              });
            },
          ),
          RadioListTile<int>(
            title: Text('选项 3'),
            value: 2,
            groupValue: _selectedIndex,
            onChanged: (value) {
              setState(() {
                _selectedIndex = value!;
              });
            },
          ),
          Text(
            '已选项: ${_selectedIndex == 0 ? '选项 1' : _selectedIndex == 1 ? '选项 2' : '选项 3'}',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ));
  }
}
