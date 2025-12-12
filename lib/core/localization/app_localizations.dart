import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Gose City Tours',
      'splash_title': 'GOSE CITY',
      'splash_tagline': 'Birthplace of Legends',

      // Auth
      'welcome_back': 'Welcome Back',
      'sign_in_subtitle': 'Please sign in to continue your journey.',
      'email': 'Email',
      'password': 'Password',
      'login_btn': 'Login',
      'register_link': 'Don\'t have an account? Register',
      'join_title': 'Join Gose City',
      'join_subtitle': 'Create an account to start exploring.',
      'full_name': 'Full Name',
      'register_btn': 'Register',
      'login_link': 'Already have an account? Login',
      'forgot_password': 'Forgot Password?',
      'or_text': 'OR',
      'continue_with_google': 'Continue with Google',
      'no_account_prompt': "Don't have an account?",

      // Dashboard
      'hero_badge': 'Welcome to Gose City',
      'hero_title': 'Discover the \nBirthplace of Japan',
      'hero_subtitle':
          'Explore ancient trails, majestic mountains, and the serene shrines of Gose.',
      'nav_title': 'Gose City Guide',
      'nav_subtitle': 'Your official guide to local myths and legends.',
      'hero_title_1': 'Discover the \nBirthplace of Japan',
      'hero_subtitle_1':
          'Explore ancient trails, majestic mountains, and the serene shrines of Gose.',
      'hero_title_2': 'Walk Through \nLiving History',
      'hero_subtitle_2':
          'Experience the timeless atmosphere of traditional streets and temples.',
      'hero_title_3': 'Taste the \nFlavors of Gose',
      'hero_subtitle_3':
          'Savor authentic local cuisine and traditional sake breweries.',
      'categories_title': 'Explore Categories',
      'other_options': 'Other Options',
      'popular_title': 'Popular Tours & Trails',
      'view_all': 'View All',
      'no_tours': 'No tours found available.',
      'loading_error': 'Unable to load tours at the moment.',

      // Categories
      'cat_shrines': 'Shrines',
      'cat_hiking': 'Hiking',
      'cat_history': 'History',
      'cat_food': 'Local Food',

      // Tour Details
      'guided_tag': 'GUIDED',
      'duration_label': '2-3 Hrs', // Placeholder
      'tour_label': 'TOUR',
      'verified_reviews': '(Verified User Reviews)',
      'about_dest': 'About Destination',
      'location': 'Location',
      'open_maps': 'Open in Maps',
      'price_person': 'Price per person',
      'book_now': 'Book Now',

      // Sidebar
      'menu_home': 'Home',
      'menu_tours': 'My Tours',
      'menu_tour_list': 'Tour List',
      'menu_bookmarks': 'Bookmarks',
      'menu_info': 'Info',
      'menu_map': 'Map',
      'menu_profile': 'Profile',
      'menu_settings': 'Settings',
      'logout': 'Logout',

      // Footer
      'footer_desc':
          'Your ultimate companion for exploring the ancient capital of Japan. Discover serenity, history, and nature.',
      'footer_company': 'Company',
      'footer_about': 'About Us',
      'footer_careers': 'Careers',
      'footer_contact': 'Contact',
      'footer_legal': 'Legal',
      'footer_terms': 'Terms',
      'footer_privacy': 'Privacy',
      'footer_cookies': 'Cookies',
      'footer_copyright': '© 2024 Gose City Guide. All rights reserved.',

      // Not Found
      'not_found_message': 'Page Not Found',
      'go_home': 'Go Home',
      'details_btn': 'Details',
    },
    'ja': {
      'app_title': '御所市観光ツアー',
      'splash_title': '御所市',
      'splash_tagline': '神話と伝説の里',

      // Auth
      'welcome_back': 'お帰りなさい',
      'sign_in_subtitle': 'ログインして旅を続けましょう。',
      'email': 'メールアドレス',
      'password': 'パスワード',
      'login_btn': 'ログイン',
      'register_link': 'アカウントをお持ちでないですか？ 登録',
      'join_title': '御所市へようこそ',
      'join_subtitle': 'アカウントを作成して探検を始めましょう。',
      'full_name': '氏名',
      'register_btn': '登録',
      'login_link': 'すでにアカウントをお持ちですか？ログイン',
      'forgot_password': 'パスワードをお忘れですか？',
      'or_text': 'または',
      'continue_with_google': 'Googleで続ける',
      'no_account_prompt': 'アカウントをお持ちでないですか？',

      // Dashboard
      'hero_badge': '御所市へようこそ',
      'hero_title': '日本発祥の地を\n発見する',
      'hero_subtitle': '古代の道、雄大な山々、そして静寂な神社を探索しましょう。',
      'nav_title': '御所市観光ナビ',
      'nav_subtitle': '神話と伝説の公式ガイド',
      'hero_title_1': '日本発祥の地を\n発見する',
      'hero_subtitle_1': '古代の道、雄大な山々、そして静寂な神社を探索しましょう。',
      'hero_title_2': '生きた歴史を\n歩く',
      'hero_subtitle_2': '伝統的な町並みと寺院の時代を超えた雰囲気を感じてください。',
      'hero_title_3': '御所の味を\n堪能する',
      'hero_subtitle_3': '本格的な郷土料理と伝統的な酒蔵を味わってください。',
      'categories_title': 'カテゴリーを探す',
      'other_options': 'その他のオプション',
      'popular_title': '人気のツアーとコース',
      'view_all': 'すべて見る',
      'no_tours': '利用可能なツアーが見つかりません。',
      'loading_error': '現在ツアーを読み込めません。',

      // Categories
      'cat_shrines': '神社・仏閣',
      'cat_hiking': 'ハイキング',
      'cat_history': '歴史',
      'cat_food': '郷土料理',

      // Tour Details
      'guided_tag': 'ガイド付き',
      'duration_label': '2-3 時間',
      'tour_label': 'ツアー',
      'verified_reviews': '(認証済みレビュー)',
      'about_dest': '目的地について',
      'location': '場所',
      'open_maps': '地図で開く',
      'price_person': '一人あたり',
      'book_now': '予約する',

      // Sidebar
      'menu_home': 'ホーム',
      'menu_tours': 'マイツアー',
      'menu_tour_list': 'ツアー一覧',
      'menu_bookmarks': 'ブックマーク',
      'menu_info': '案内',
      'menu_map': '地図',
      'menu_profile': 'プロフィール',
      'menu_settings': '設定',
      'logout': 'ログアウト',

      // Footer
      'footer_desc': '日本発祥の地を探索するための究極のガイド。静寂、歴史、自然を発見してください。',
      'footer_company': '会社情報',
      'footer_about': '私たちについて',
      'footer_careers': '採用情報',
      'footer_contact': 'お問い合わせ',
      'footer_legal': '法的情報',
      'footer_terms': '利用規約',
      'footer_privacy': 'プライバシーポリシー',
      'footer_cookies': 'クッキー',
      'footer_copyright': '© 2024 御所市観光ナビ. All rights reserved.',

      // Not Found
      'not_found_message': 'ページが見つかりません',
      'go_home': 'ホームへ戻る',
      'details_btn': '詳細',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }

  // Convenient getters
  String get splashTitle => get('splash_title');
  String get splashTagline => get('splash_tagline');
  // ... and so on, or just use get('key') directly in widgets
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
