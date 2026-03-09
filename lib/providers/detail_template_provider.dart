import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/sample_estimates.dart';
import '../models/detail_item.dart';

/// 내역서에 입력했던 항목들을 저장하고, 검색어로 불러와 선택할 수 있게 합니다.
class DetailTemplateProvider with ChangeNotifier {
  static const _key = 'detail_item_templates';
  static const _maxCount = 80;

  List<DetailItem> _templates = [];
  bool _loaded = false;

  List<DetailItem> get templates => List.unmodifiable(_templates);

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_key);
      if (jsonList != null && jsonList.isNotEmpty) {
        _templates = jsonList
            .map((s) {
              try {
                return DetailItem.fromJson(
                    Map<String, dynamic>.from(jsonDecode(s) as Map));
              } catch (_) {
                return null;
              }
            })
            .whereType<DetailItem>()
            .toList();
      }
      if (_templates.isEmpty) {
        _templates = List.from(SampleEstimates.urimJongroDetailItems);
        await _save();
      }
    } catch (_) {
      _templates = [];
    }
    _loaded = true;
  }

  Future<void> addTemplate(DetailItem item) async {
    await _ensureLoaded();
    final key =
        '${item.productName}|${item.specification}|${item.unit}'.trim();
    _templates.removeWhere((t) =>
        '${t.productName}|${t.specification}|${t.unit}'.trim() == key);
    _templates.insert(
      0,
      DetailItem(
        productName: item.productName,
        specification: item.specification,
        unit: item.unit,
        quantity: item.quantity,
        materialUnitPrice: item.materialUnitPrice,
        laborUnitPrice: item.laborUnitPrice,
        note: item.note,
      ),
    );
    if (_templates.length > _maxCount) {
      _templates = _templates.take(_maxCount).toList();
    }
    await _save();
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _templates
        .map((t) => jsonEncode(t.toJson()))
        .toList();
    await prefs.setStringList(_key, list);
  }

  /// 검색어로 저장된 항목을 필터링합니다. 품명·규격 기준으로 검색합니다.
  Future<List<DetailItem>> searchTemplates(String query) async {
    await _ensureLoaded();
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return _templates.take(20).toList();
    return _templates
        .where((t) =>
            t.productName.toLowerCase().contains(q) ||
            t.specification.toLowerCase().contains(q) ||
            (t.note.isNotEmpty && t.note.toLowerCase().contains(q)))
        .take(20)
        .toList();
  }

  /// 품명·규격 각각 입력값으로 필터링 (콤보용).
  Future<List<DetailItem>> searchByProductNameAndSpec(
      String productNameQuery, String specQuery) async {
    try {
      await _ensureLoaded();
      final p = productNameQuery.trim().toLowerCase();
      final s = specQuery.trim().toLowerCase();
      return _templates
          .where((t) {
            final matchP = p.isEmpty || t.productName.toLowerCase().contains(p);
            final matchS =
                s.isEmpty || t.specification.toLowerCase().contains(s);
            return matchP && matchS;
          })
          .take(20)
          .toList();
    } catch (_) {
      return [];
    }
  }
}
