import 'dart:convert';
import 'package:consultz/core/utils/share_preference/key_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallPreference {
  static Future<void> savePendingCall(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KeyConstant.pendingCall, jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getPendingCall() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(KeyConstant.pendingCall);
    if (data != null && data.isNotEmpty) {
      try {
        return jsonDecode(data) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<void> clearPendingCall() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(KeyConstant.pendingCall);
  }
}
