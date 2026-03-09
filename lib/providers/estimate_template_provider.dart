import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/estimate_item.dart';

/// 견적서에 입력했던 항목들을 저장하고, 품명/규격으로 검색해 선택할 수 있게 합니다.
class EstimateTemplateProvider with ChangeNotifier {
  static const _key = 'estimate_item_templates';
  static const _maxCount = 80;

  List<EstimateItem> _templates = [];
  bool _loaded = false;

  List<EstimateItem> get templates => List.unmodifiable(_templates);

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_key);
      if (jsonList != null && jsonList.isNotEmpty) {
        _templates = jsonList
            .map((s) {
              try {
                return EstimateItem.fromJson(
                    Map<String, dynamic>.from(jsonDecode(s) as Map));
              } catch (_) {
                return null;
              }
            })
            .whereType<EstimateItem>()
            .toList();
      }
    } catch (_) {
      _templates = [];
    }
    _loaded = true;
  }

  Future<void> addTemplate(EstimateItem item) async {
    await _ensureLoaded();
    final key =
        '${item.productName}|${item.specification}|${item.unit}'.trim();
    _templates.removeWhere((t) =>
        '${t.productName}|${t.specification}|${t.unit}'.trim() == key);
    _templates.insert(
      0,
      EstimateItem(
        productName: item.productName,
        specification: item.specification,
        unit: item.unit,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
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
    final list = _templates.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(_key, list);
  }

  /// 품명·규격 각각 입력값으로 필터링 (콤보용).
  Future<List<EstimateItem>> searchByProductNameAndSpec(
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
