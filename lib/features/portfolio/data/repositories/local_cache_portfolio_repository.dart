import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/portfolio_content.dart';

/// Guarda/recupera o último conteúdo conhecido localmente (localStorage no web),
/// permitindo que o site abra instantâneo mesmo antes da resposta do Firestore.
class LocalCachePortfolioRepository {
  static const _cacheKey = 'portfolio_content_cache';

  Future<PortfolioContent?> getCachedContent() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_cacheKey);
    if (raw == null) return null;

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return PortfolioContent.fromJson(json);
    } catch (_) {
      // Cache corrompido ou de uma versão antiga incompatível — ignora.
      return null;
    }
  }

  Future<void> saveContent(PortfolioContent content) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, jsonEncode(content.toJson()));
  }
}
