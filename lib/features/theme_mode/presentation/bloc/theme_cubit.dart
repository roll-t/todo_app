
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

   void updateTheme(ThemeMode themeMode) => emit(themeMode);

  
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    // Bạn có thể tùy chỉnh theo cách lưu trữ bạn muốn
    try {
      final themeMode = json['themeMode'] as String;
      return ThemeMode.values.firstWhere((e) => e.toString() == themeMode, orElse: () => ThemeMode.system);
    } catch (_) {
      return ThemeMode.system; // Default value nếu gặp lỗi
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    // Lưu trữ themeMode dưới dạng chuỗi
    return {'themeMode': state.toString()};
  }
}
