import 'package:hooks_riverpod/hooks_riverpod.dart';

class PagingInfo {
  final int page;
  final int pageSize;
  PagingInfo({required this.page, required this.pageSize});
}

class Any {}

///用来记录分页请求provider的状态
class PaginationNotifier<T> extends StateNotifier<AsyncValue<List<T>>> {
  PaginationNotifier(this.itemsCount, this.fetchNextItems)
      : super(const AsyncValue.loading());

  final int itemsCount;
  final Future<List<T>> Function(
      PagingInfo pageinfo, String? keyWord, Any? filter) fetchNextItems;

  final List<T> _items = [];
  int _page = 1;
  bool _hasMore = true;

  void init(String? keyWord, Any? filter) {
    _items.clear();
    _page = 1;
    _items.clear();
    _hasMore = true;
    if (_items.isEmpty) {
      fetchFirstPage(keyWord, filter);
    }
  }

  void _updata(List<T> result) {
    if (result.isNotEmpty) {
      _items.addAll(result);
    }
    state = AsyncValue.data(_items);

    if (result.length < itemsCount) {
      _hasMore = false;
    } else {
      _hasMore = true;
    }
  }

  Future<void> fetchFirstPage(String? keyWord, Any? filter) async {
    state = const AsyncValue.loading();
    try {
      if (_hasMore) {
        var result = await fetchNextItems(
            PagingInfo(page: _page, pageSize: itemsCount), keyWord, filter);
        _updata(result);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> fetchNextPage(String? keyWord, Any? filter) async {
    try {
      if (_hasMore) {
        _page++;
        var result = await fetchNextItems(
            PagingInfo(page: _page, pageSize: itemsCount), keyWord, filter);
        _updata(result);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  bool hasMoreData() {
    return _hasMore;
  }
}
