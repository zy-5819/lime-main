import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sortable_wrap/flutter_sortable_wrap.dart';
import 'package:lime/pages/module.dart';
import 'package:lime/pages/shop.dart';
import 'package:lime/pages/tables.dart';

enum CellType {
  text,
  number,
  DateTime,
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

bool _isUpdate = true;
ValueNotifier<bool> _contentShow = ValueNotifier(false);
ValueNotifier<String> currentShopItem = ValueNotifier('test');
String _currentTableItem = '';
late SubModuleData subModuleData;

class AppState extends State<App> {
  int _index = 0;

  late List<Offset> _shopPositiones;
  late List<Offset> _cellPositiones;
  late List<Widget> _shops;
  late List<TableItemData> _tableDatas;
  late List<Widget> _tableItems;
  late List<Color> colors;
  late int test;
  ValueNotifier<bool> _addShow = ValueNotifier(true);
  ValueNotifier<bool> _delateShow = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _isUpdate = true;
    _contentShow.value = false;
    _currentTableItem = '';
    _shopPositiones = [];
    _cellPositiones = [];
    _shops = [
      SizedBox(
        width: double.infinity,
        height: 0.1.h,
      ),
      ShopItem(
          text: 'test',
          color: Colors.black,
          positiones: _shopPositiones,
          isLast: true,
          index: 1,
          valueListenable: _delateShow,
          onLongPress: () {},
          onTap: (v) {},
          currentShopItemLisener: currentShopItem)
    ];
    _tableDatas = [
      TableItemData('1', name: '名称', type: CellType.text, data: []),
      TableItemData('2', name: '数量', type: CellType.text, data: []),
      TableItemData('3', name: '单价', type: CellType.text, data: []),
    ];
    _tableItems = [
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

    for (int i = 0; i < _tableDatas.length; i++) {
      _tableItems.add(TableItem(
        data: _tableDatas[i],
        onTap: (index) {
          setState(() {
            _shops.removeAt(index);
          });
        },
        text: _tableDatas[i].name,
        color: colors[i % colors.length],
        positiones: _cellPositiones,
        isLast: i == _tableDatas.length - 1,
        index: i,
        valueListenable: _delateShow,
        onLongPress: () {
          setState(() {});
          // _delateShow.value = true;
          // _addShow.value = false;
          // _contentShow.value = false;
        },
        itemBuilder: (currentIndex, t, widget) {
          _currentTableItem = _tableDatas[i].id;
          // setState(() {
          //   if (_isUpdate) {
          //     _tableItems.insert(t + 1, widget);
          //     _index = t + 1;
          //   } else {
          //     _tableItems.removeAt(_index);
          //     if (t == _shopPositiones.length + 1) {
          //       _tableItems.insert(t + 1, widget);
          //       _index = t + 1;
          //     } else {
          //       _tableItems.insert(t, widget);
          //       _index = t;
          //     }
          //   }

          //   //_lastIndex = currentIndex;
          // });
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
                  // setState(() {});
                  // _delateShow.value = true;
                  // _addShow.value = false;
                  // _contentShow.value = false;
                },
                positiones: _shopPositiones,
                index: _shops.length - 2,
                itemBuilder: (currentIndex, t, widget) {
                  // setState(() {
                  //   if (_isUpdate) {
                  //     _shops.insert(t + 1, widget);
                  //     _index = t + 1;
                  //   } else {
                  //     _shops.removeAt(_index);
                  //     _shops.insert(t, widget);
                  //     _index = t;
                  //   }

                  //   //_lastIndex = currentIndex;
                  // });
                },
                valueListenable: _delateShow),
          );
        }));
        setState(() {
          _shops.insert(_shops.length - 1, x!);
        });
      },
    ));
    _tableItems.add(_AddButton(
      valueListenable: _addShow,
      onTap: () async {
        var v = await Navigator.of(context)
            .push<TableItemData>(MaterialPageRoute(builder: (context) {
          return TableItmeModule(
            data: TableItmeModuleData(true),
          );
        }));
        setState(() {
          _tableDatas.insert(_tableDatas.length - 1, v!);
          _tableItems.insert(
              _tableItems.length - 1,
              TableItem(
                data: v,
                onTap: (index) {
                  setState(() {
                    _shops.removeAt(index);
                  });
                },
                text: v.name,
                color: Colors.white,
                positiones: _cellPositiones,
                isLast: true,
                index: _tableDatas.length - 1,
                valueListenable: _delateShow,
                onLongPress: () {
                  // setState(() {});
                  // _delateShow.value = true;
                  // _addShow.value = false;
                  // _contentShow.value = false;
                },
                itemBuilder: (currentIndex, t, widget) {
                  _currentTableItem = v.id;
                  // setState(() {
                  //   if (_isUpdate) {
                  //     _tableItems.insert(t + 1, widget);
                  //     _index = t + 1;
                  //   } else {
                  //     _tableItems.removeAt(_index);
                  //     if (t == _shopPositiones.length + 1) {
                  //       _tableItems.insert(t + 1, widget);
                  //       _index = t + 1;
                  //     } else {
                  //       _tableItems.insert(t, widget);
                  //       _index = t;
                  //     }
                  //   }

                  //   //_lastIndex = currentIndex;
                  // });
                },
              ));
        });
      },
    ));
  }

  void _initData() {
    print(_shops.length);
    for (int i = 0; i < _shops.length; i++) {
      if (_shops[i] is ShopItem) {
        _shops[i] = ShopItem(
          currentShopItemLisener: currentShopItem,
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
            // setState(() {});
            // _delateShow.value = true;
            // _addShow.value = false;
            // _contentShow.value = false;
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

              //_lastIndex = currentIndex;
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
        // setState(() {});
        // _delateShow.value = false;
        // _addShow.value = true;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DataTable2SimpleDemo(
                  shopName: currentShopItem.value,
                  data: subModuleData,
                )));
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
                            //_initData();
                          });
                          // _addShow.value = true;
                          // _delateShow.value = false;
                        },
                        onSortCancel: (index) {
                          // _addShow.value = true;
                          // _delateShow.value = false;
                        },
                        onSortStart: (index) {
                          //_contentShow.value = false;
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
                        children: _tableItems,
                        options: options,
                        onSorted: (int oldIndex, int newIndex) {
                          setState(() {
                            _shops.insert(newIndex, _shops.removeAt(oldIndex));
                            // _initData();
                          });
                          // _addShow.value = true;
                          // _delateShow.value = false;
                        },
                        onSortCancel: (index) {
                          // _addShow.value = true;
                          // _delateShow.value = false;
                        },
                        onSortStart: (index) {
                          //_contentShow.value = false;
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
  final void Function(int currentIndex, int index, Widget content)? itemBuilder;
  final ValueListenable<bool> valueListenable;
  final ValueListenable<String> currentShopItemLisener;
  final void Function() onLongPress;
  final void Function(int index) onTap;

  const ShopItem({
    super.key,
    required this.text,
    required this.color,
    required this.positiones,
    required this.isLast,
    required this.index,
    this.itemBuilder,
    required this.valueListenable,
    required this.onLongPress,
    required this.onTap,
    required this.currentShopItemLisener,
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

    return ValueListenableBuilder(
        valueListenable: currentShopItemLisener,
        builder: (context, currentShopItemText, child) {
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
                              currentShopItem.value = text;
                              // if (index == _lastIndex) {
                              //   _contentShow.value = !_contentShow.value;
                              // } else {
                              //   _contentShow.value = true;
                              // }
                              // var i = positiones
                              //     .indexWhere((v) => v.dy > positiones[index].dy);
                              // if (i < 0) {
                              //   i = positiones.length;
                              // }
                              // i = i + 1;
                              // itemBuilder.call(index, i, _Content());
                            },
                            onLongPressStart: (d) {
                              onLongPress.call();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10.w, top: 5.h, bottom: 5.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              constraints: BoxConstraints(minWidth: 50.w),
                              decoration: BoxDecoration(
                                color: currentShopItemText == text
                                    ? Colors.green
                                    : null,
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                //color:  == _lastIndex ? color : null,
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
        });
  }
}

class TableItemData {
  final String id;
  final String name;
  final CellType type;
  final List<dynamic> data;

  TableItemData(this.id,
      {required this.name, required this.type, required this.data});
}

class TableItem extends StatelessWidget {
  final TableItemData data;
  final String text;
  final Color? color;
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
    this.color,
    required this.positiones,
    required this.isLast,
    required this.index,
    required this.itemBuilder,
    required this.valueListenable,
    required this.onLongPress,
    required this.onTap,
    required this.data,
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
                      _contentShow.value = true;
                      if (data.id == _currentTableItem) {
                        _contentShow.value = !_contentShow.value;
                      }

                      var i = positiones
                          .indexWhere((v) => v.dy > positiones[index].dy);
                      if (i < 0) {
                        i = positiones.length;
                      }
                      i = i + 1;
                      itemBuilder.call(index, i, _Content());
                    },
                    onLongPressStart: (d) {
                      onLongPress.call();
                    },
                    child: Draggable<TableItemData>(
                      data: data,
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
                              //color: color,
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
                          //color: index == _lastIndex ? color : null,
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
  late List<TableItemData> _children;
  late List<SubModuleData> datas;
  @override
  void initState() {
    super.initState();
    _children = [];
    datas = [
      SubModuleData('1', datas: [
        TableItemData('1', name: '名称', type: CellType.text, data: []),
        TableItemData('2', name: '数量', type: CellType.text, data: []),
        TableItemData('3', name: '单价', type: CellType.text, data: []),
      ]),
    ];
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
          const Text('选择模板:'),
          Container(
            width: 1.sw,
            height: 80.h,
            color: Colors.grey.withAlpha(100),
            child: DragTarget<TableItemData>(
              // 用来接收数据的 Widget
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          children: _children.map((e) {
                            return Container(
                              child: Text(e.name),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                datas.add(SubModuleData(
                                    Random().nextDouble().toString(),
                                    datas: [..._children]));
                                _children.clear();
                              });
                            },
                            child: Text('添加')),
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
                  _children.add(data.data);
                });
              },
            ),
          ),
          SubModuleListDemo(
            datas: datas,
          ),
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

class SubModuleListDemo extends StatefulWidget {
  final List<SubModuleData> datas;

  const SubModuleListDemo({super.key, required this.datas});
  @override
  _SubModuleListDemoState createState() => _SubModuleListDemoState();
}

class _SubModuleListDemoState extends State<SubModuleListDemo> {
  // 用于保存单选按钮的值
  String _selectedIndex = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subModuleData = widget.datas.first;
    _selectedIndex = widget.datas.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
          children: widget.datas.map<Widget>((e) {
        return RadioListTile<String>(
          title: SubModule(
            children: e.datas.map<Widget>((v) {
              return Text(v.name);
            }).toList(),
          ),
          value: e.id,
          groupValue: _selectedIndex,
          onChanged: (value) {
            setState(() {
              _selectedIndex = value!;
              subModuleData =
                  widget.datas.firstWhere((element) => element.id == value);
            });
          },
        );
      }).toList()),
    ));
  }
}

class SubModuleData {
  final String id;
  final List<TableItemData> datas;

  SubModuleData(this.id, {required this.datas});
}

class SubModule extends StatelessWidget {
  final List<Widget> children;

  const SubModule({super.key, required this.children});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        children: children,
      ),
    );
  }
}
