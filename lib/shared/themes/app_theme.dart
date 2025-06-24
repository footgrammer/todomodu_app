import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const primary900 = Color(0xFF130F7B);
  static const primary800 = Color(0xFF1A14A8);
  static const primary700 = Color(0xFF1E1EC4);
  static const primary600 = Color(0xFF413BE7);
  static const primary500 = Color(0xFF5752EA);
  static const primary400 = Color(0xFF837FF0);
  static const primary300 = Color(0xFF9996F2);
  static const primary200 = Color(0xFFC6C4F8);
  static const primary100 = Color(0xFFE5E3FC);
  static const primary50 = Color(0xFFF2F1FD);

  // Grey Colors
  static const grey900 = Color(0xFF28282F);
  static const grey800 = Color(0xFF403F4B);
  static const grey700 = Color(0xFF585666);
  static const grey600 = Color(0xFF6F6D82);
  static const grey500 = Color(0xFF8C89A0);
  static const grey400 = Color(0xFFA7A5B9);
  static const grey300 = Color(0xFFC6C4D2);
  static const grey200 = Color(0xFFDCDBE4);
  static const grey100 = Color(0xFFE9E9EC);
  static const grey75 = Color(0xFFF0F0F3);
  static const grey50 = Color(0xFFF7F7F8);

  // List Colors
  static const colorList1 = Color(0xFFF1BDD2);
  static const colorList2 = Color(0xFFF3BEBE);
  static const colorList3 = Color(0xFFF7CCC0);
  static const colorList4 = Color(0xFFFFD999);
  static const colorList5 = Color(0xFFFFE9AC);
  static const colorList6 = Color(0xFFFFF0D7);
  static const colorList7 = Color(0xFFDCF0C4);
  static const colorList8 = Color(0xFFC0EBCA);
  static const colorList9 = Color(0xFFCEF6FB);
  static const colorList10 = Color(0xFFB6EBF8);
  static const colorList11 = Color(0xFFADCBFD);
  static const colorList12 = Color(0xFFC0E2FF);
  static const colorList13 = Color(0xFFD6D5FF);
  static const colorList14 = Color(0xFFD7E3FF);
  static const colorList15 = Color(0xFFE0E0E0);
  static const colorList16 = Color(0xFFE6D6C9);
}

class AppTextStyles {
  static const header1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 36 / 28,
  );
  static const header2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
  );
  static const header3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
  );
  static const header4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
  );
  static const subtitle1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
  );
  static const subtitle2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
  );
  static const subtitle3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
  );
  static const subtitle4 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 18 / 12,
  );
  static const body1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 28 / 18,
  );
  static const body2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
  );
  static const body3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
  );
  static const caption1 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 18 / 12,
  );
  static const caption2 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 12 / 10,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary500,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Pretendard', // 사용 중인 폰트 명시
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: AppTextStyles.header3.copyWith(
          color: AppColors.grey900,
        ), // 앱바 텍스트 스타일 지정
        iconTheme: IconThemeData(color: AppColors.grey900),
      ),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.header1,
        displayMedium: AppTextStyles.header2,
        displaySmall: AppTextStyles.header3,
        headlineMedium: AppTextStyles.header4,
        titleLarge: AppTextStyles.subtitle1,
        titleMedium: AppTextStyles.subtitle2,
        titleSmall: AppTextStyles.subtitle3,
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body2,
        bodySmall: AppTextStyles.body3,
        labelLarge: AppTextStyles.caption1,
        labelSmall: AppTextStyles.caption2,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary500,
        primary: AppColors.primary500,
        secondary: AppColors.primary200,
        surface: AppColors.grey100,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: AppColors.grey900,
        onSurface: AppColors.grey900,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white, // ✅ 원하는 색상으로 설정
        selectedItemColor: AppColors.primary500,
        unselectedItemColor: AppColors.grey400,
      ),
    );
  }
}
