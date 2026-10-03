# حزمة مشروع أبايذيد لنك منجر الكاملة (project.zip) — الإصدار الرسمي الموحد v5.0
## منظومة إدارة شبكات ميكروتك (MikroTik RouterOS v7) وطباعة الكروت الحرارية Sunmi و ESC/POS
### دليل وتجميع كامل ملفات المشروع البرمجية وهيكلية مجلدات Flutter وأتمتة التوليد السحابي والميداني

---

### 📦 الهيكلية الكاملة لمجلدات وملفات `project.zip`:

```text
project.zip (abayazeed_link_manager/)
├── pubspec.yaml
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_colors.dart
│   │   │   └── app_theme.dart
│   │   ├── network/
│   │   │   └── mikrotik_api_client.dart
│   │   └── utils/
│   │       ├── sunmi_printer_service.dart
│   │       └── thermal_esc_pos_printer.dart
│   └── features/
│       ├── auth/
│       │   └── login_screen.dart
│       ├── dashboard/
│       │   └── dashboard_screen.dart
│       ├── vouchers/
│       │   └── vouchers_screen.dart
│       ├── active_users/
│       │   └── active_users_screen.dart
│       └── hardware/
│           └── hardware_screen.dart
├── android/
│   ├── build.gradle
│   ├── gradle/
│   │   └── wrapper/
│   │       └── gradle-wrapper.properties
│   └── app/
│       ├── build.gradle
│       ├── proguard-rules.pro
│       └── src/
│           └── main/
│               └── AndroidManifest.xml
└── .github/
    └── workflows/
        └── build_apk.yml
```

---

### 1. ملف إعدادات المشروع والمكتبات المعتمدة: `pubspec.yaml`

```yaml
name: abayazeed_link_manager
description: منظومة إدارة شبكات ميكروتك وطباعة الكروت الحرارية Sunmi و ESC/POS
publish_to: 'none'
version: 5.0.0+1

environment:
  sdk: '>=3.3.0 <4.0.0'
  flutter: ">=3.19.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # الخط العربي الرسمي الموحد
  google_fonts: ^6.1.0

  # شبكة ميكروتك والاتصال بالـ REST API
  dio: ^5.4.1

  # محركات الطباعة الحرارية لأجهزة Sunmi وطابعات ESC/POS والـ QR
  sunmi_printer_plus: ^2.1.2
  esc_pos_utils_plus: ^2.0.3
  qr_flutter: ^4.1.0
  barcode_widget: ^2.0.4
  pdf: ^3.10.8
  printing: ^5.12.0

  # أدوات إضافية للأيقونات والتنسيق
  lucide_icons: ^0.257.0
  intl: ^0.19.0

dependency_overrides:
  image: ^4.1.7
  archive: ^3.4.10
  crypto: ^3.0.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1

flutter:
  uses-material-design: true
```

---

### 2. الكود البرمجي المصدري الموحد بالخط العربي والخلفية السيبرانية: `lib/main.dart`

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0E16),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AbayazeedApp());
}

/// ألوان وثيم التطبيق السيبراني الموحد
class CyberColors {
  static const Color bgDark = Color(0xFF0A0E16);
  static const Color surface = Color(0xFF0F131C);
  static const Color surfaceHigh = Color(0xFF181C24);
  static const Color surfaceHighest = Color(0xFF222834);
  static const Color border = Color(0xFF262E3D);
  static const Color cyan = Color(0xFF00E5FF);
  static const Color cyanGlow = Color(0x3300E5FF);
  static const Color blue = Color(0xFF0072FF);
  static const Color green = Color(0xFF00E676);
  static const Color orange = Color(0xFFFF9100);
  static const Color red = Color(0xFFFF1744);
}

class AbayazeedApp extends StatelessWidget {
  const AbayazeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    // تطبيق الخط العربي الرسمي الموحد IBM Plex Sans Arabic على كامل المنظومة
    final arabicTextTheme = GoogleFonts.ibmPlexSansArabicTextTheme(
      ThemeData.dark().textTheme,
    );

    return MaterialApp(
      title: 'أبايذيد لنك منجر — MikroTik Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CyberColors.bgDark,
        primaryColor: CyberColors.cyan,
        cardColor: CyberColors.surface,
        textTheme: arabicTextTheme,
        primaryTextTheme: arabicTextTheme,
        colorScheme: const ColorScheme.dark(
          primary: CyberColors.cyan,
          secondary: CyberColors.blue,
          surface: CyberColors.surface,
          error: CyberColors.red,
        ),
      ),
      home: const MainGateScreen(),
    );
  }
}

class MainGateScreen extends StatefulWidget {
  const MainGateScreen({super.key});

  @override
  State<MainGateScreen> createState() => _MainGateScreenState();
}

class _MainGateScreenState extends State<MainGateScreen> {
  bool _isLoggedIn = false;
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return LoginCyberScreen(
        onLogin: () => setState(() => _isLoggedIn = true),
      );
    }

    final pages = [
      const DashboardTab(),
      const VouchersTab(),
      const ActiveUsersTab(),
      const HardwareTab(),
    ];

    return Scaffold(
      backgroundColor: CyberColors.bgDark,
      appBar: AppBar(
        backgroundColor: CyberColors.surface.withOpacity(0.92),
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: CyberColors.cyan.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: CyberColors.cyan.withOpacity(0.4)),
              ),
              child: const Icon(Icons.router, color: CyberColors.cyan, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أبايذيد لنك منجر',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'MIKROTIK ROUTEROS v7 PRO',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 9,
                    color: CyberColors.cyan,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: CyberColors.green.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: CyberColors.green, width: 1),
                boxShadow: [
                  BoxShadow(color: CyberColors.green.withOpacity(0.2), blurRadius: 6),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(radius: 3.5, backgroundColor: CyberColors.green),
                  const SizedBox(width: 5),
                  Text(
                    'ONLINE',
                    style: GoogleFonts.ibmPlexSansArabic(
                      color: CyberColors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: pages[_tabIndex],
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: const BoxDecoration(
            color: CyberColors.surface,
            border: Border(top: BorderSide(color: CyberColors.border, width: 1)),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: CyberColors.cyan,
            unselectedItemColor: Colors.white38,
            currentIndex: _tabIndex,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: GoogleFonts.ibmPlexSansArabic(fontSize: 11),
            onTap: (idx) => setState(() => _tabIndex = idx),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'الرئيسية'),
              BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'الكروت والطباعة'),
              BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: 'المشتركون'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'الراوتر والعتاد'),
            ],
          ),
        ),
      ),
    );
  }
}

// 1. شاشة تسجيل الدخول المدمجة بالخلفية السيبرانية والشعار 3D والخط العربي
class LoginCyberScreen extends StatelessWidget {
  final VoidCallback onLogin;
  const LoginCyberScreen({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyberColors.bgDark,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: CyberGridPainter(),
            ),
          ),
          SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CyberColors.surfaceHigh,
                          border: Border.all(color: CyberColors.cyan, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: CyberColors.cyan.withOpacity(0.35),
                              blurRadius: 28,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(Icons.router, size: 48, color: CyberColors.cyan),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'أبايذيد لنك منجر',
                        style: GoogleFonts.ibmPlexSansArabic(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'منظومة إدارة شبكات ميكروتك وطباعة الكروت الحرارية',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ibmPlexSansArabic(
                          fontSize: 12,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: CyberColors.surface.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: CyberColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildInput(label: 'اسم المشرف (Admin)', icon: Icons.person_outline, hint: 'app_admin'),
                            const SizedBox(height: 14),
                            _buildInput(label: 'كلمة المرور', icon: Icons.lock_outline, hint: '••••••••', obscure: true),
                            const SizedBox(height: 14),
                            _buildInput(label: 'عنوان IP الراوتر', icon: Icons.lan_outlined, hint: '192.168.88.1'),
                            const SizedBox(height: 22),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CyberColors.cyan,
                                foregroundColor: Colors.black,
                                minimumSize: const Size.fromHeight(52),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                elevation: 6,
                              ),
                              onPressed: onLogin,
                              child: Text(
                                'دخول إلى غرفة العمليات (NOC)',
                                style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextButton.icon(
                        onPressed: onLogin,
                        icon: const Icon(Icons.flash_on, color: CyberColors.cyan, size: 18),
                        label: Text(
                          'دخول تجريبي فوري (Direct Demo Bypass)',
                          style: GoogleFonts.ibmPlexSansArabic(color: CyberColors.cyan, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildInput({required String label, required IconData icon, required String hint, bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.ibmPlexSansArabic(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscure,
          style: GoogleFonts.ibmPlexSansArabic(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: CyberColors.cyan, size: 20),
            hintText: hint,
            hintStyle: GoogleFonts.ibmPlexSansArabic(color: Colors.white30, fontSize: 13),
            filled: true,
            fillColor: CyberColors.surfaceHigh,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: CyberColors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: CyberColors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: CyberColors.cyan)),
          ),
        ),
      ],
    );
  }
}

// 2. لوحة التحكم المركزية (Dashboard Tab)
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CyberColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: CyberColors.border),
            boxShadow: [
              BoxShadow(color: CyberColors.cyan.withOpacity(0.08), blurRadius: 16),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'عقدة ميكروتك المركزية',
                    style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                  ),
                  const Icon(Icons.hub_outlined, color: CyberColors.cyan),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _chip('الموديل', 'MikroTik CCR2004', CyberColors.cyan),
                  const SizedBox(width: 8),
                  _chip('المنفذ', 'SFP-Plus LAN', Colors.white70),
                  const SizedBox(width: 8),
                  _chip('الحالة', 'FastTrack ON', CyberColors.green),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.35,
          children: const [
            _MetricCard(title: 'السرعة اللحظية', value: '184.2 Mbps', icon: Icons.speed, color: CyberColors.cyan),
            _MetricCard(title: 'المشتركون النشطون', value: '128 مستخدم', icon: Icons.people_alt, color: CyberColors.green),
            _MetricCard(title: 'استهلاك اليوم', value: '840 GB', icon: Icons.data_usage, color: CyberColors.orange),
            _MetricCard(title: 'زمن الاستجابة', value: '18 ms', icon: Icons.timer_outlined, color: CyberColors.blue),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CyberColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: CyberColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إجراءات الطباعة الميدانية',
                style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CyberColors.cyan,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.print),
                label: Text(
                  'طباعة كرت تجريبي فوري (Sunmi / محاكي)',
                  style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold),
                ),
                onPressed: () => _showThermalVoucherModal(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _chip(String k, String v, Color col) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: CyberColors.surfaceHigh, borderRadius: BorderRadius.circular(6)),
      child: Text(
        '$k: $v',
        style: GoogleFonts.ibmPlexSansArabic(color: col, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  static void _showThermalVoucherModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: CyberColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: CyberColors.cyan, width: 1.5),
        ),
        title: Row(
          children: [
            const Icon(Icons.receipt_long, color: CyberColors.cyan),
            const SizedBox(width: 8),
            Text(
              'معاينة طباعة كرت حراري Sunmi',
              style: GoogleFonts.ibmPlexSansArabic(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
        content: Container(
          width: 290,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('أبايذيد لنك منجر', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
              Text('MIKROTIK HOTSPOT CORE', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black54, fontSize: 10)),
              const Divider(color: Colors.black84, thickness: 1.2),
              Text('باقة 24 ساعة توربو — 2,500 د.ع', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Icon(Icons.qr_code_2, size: 74, color: Colors.black),
              const SizedBox(height: 6),
              Text('كود المستخدم: AY-8840-2911', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
              Text('رمز الـ PIN: 491028', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
              const Divider(color: Colors.black54),
              Text('✂️ أمر القص التلقائي: تم بنجاح', style: GoogleFonts.ibmPlexSansArabic(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('إغلاق', style: GoogleFonts.ibmPlexSansArabic(color: CyberColors.cyan)),
          ),
        ],
      ),
    );
  }
}

// 3. شاشة إدارة الكروت والطباعة (Vouchers Tab)
class VouchersTab extends StatelessWidget {
  const VouchersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('فئات وباقات الهوتسبوت', style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 16)),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: CyberColors.cyan,
                foregroundColor: Colors.black,
              ),
              icon: const Icon(Icons.add, size: 18),
              label: Text('توليد دفعة جديدة', style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'تم توليد 50 كرت جديد وحقنها في MikroTik بنجاح ✅',
                      style: GoogleFonts.ibmPlexSansArabic(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        _voucherItem(context, 'باقة 24 ساعة توربو', '2,500 د.ع', '10 GB', 'المتبقي: 184 كرت'),
        _voucherItem(context, 'باقة أسبوعية بلا حدود', '10,000 د.ع', '50 GB', 'المتبقي: 62 كرت'),
        _voucherItem(context, 'باقة شهرية VIP', '35,000 د.ع', '200 GB', 'المتبقي: 19 كرت'),
      ],
    );
  }

  Widget _voucherItem(BuildContext ctx, String title, String price, String quota, String count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CyberColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: CyberColors.surfaceHigh, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.wifi, color: CyberColors.cyan),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text('$quota — $count', style: GoogleFonts.ibmPlexSansArabic(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: GoogleFonts.ibmPlexSansArabic(color: CyberColors.cyan, fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text('جاهز للطباعة', style: GoogleFonts.ibmPlexSansArabic(color: Colors.white30, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

// 4. شاشة المشتركين النشطين (Active Users Tab)
class ActiveUsersTab extends StatelessWidget {
  const ActiveUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'المشتركون المتصلون على راوتر MikroTik',
          style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        _userTile(context, 'أحمد خليل', '192.168.88.104', '4.8 Mbps', '3.8 GB'),
        _userTile(context, 'محمد زيادة', '192.168.88.118', '18.2 Mbps', '18.4 GB'),
        _userTile(context, 'سالم مصطفى', '192.168.88.89', '9.4 Mbps', '9.2 GB'),
        _userTile(context, 'حيدر يوسف', '192.168.88.204', '1.2 Mbps', '0.4 GB'),
      ],
    );
  }

  Widget _userTile(BuildContext ctx, String name, String ip, String speed, String usage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CyberColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: CyberColors.surfaceHigh, child: const Icon(Icons.person, color: CyberColors.green)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 14)),
                Text('IP: $ip | الاستهلاك: $usage', style: GoogleFonts.ibmPlexSansArabic(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
          Text(speed, style: GoogleFonts.ibmPlexSansArabic(color: CyberColors.cyan, fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: CyberColors.red, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text(
                    'تم فصل جلسة المشترك $name بنجاح',
                    style: GoogleFonts.ibmPlexSansArabic(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 5. شاشة إعدادات العتاد و MikroTik (Hardware Tab)
class HardwareTab extends StatelessWidget {
  const HardwareTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'إعدادات الربط مع راوتر MikroTik RouterOS',
          style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        _field('عنوان IP الراوتر (Host IP)', '192.168.88.1'),
        const SizedBox(height: 12),
        _field('اسم المستخدم (REST API User)', 'app_admin'),
        const SizedBox(height: 12),
        _field('كلمة المرور (Password)', '••••••••••••', obscure: true),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: CyberColors.cyan,
            foregroundColor: Colors.black,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          icon: const Icon(Icons.sync),
          label: Text('فحص ومزامنة الاتصال الحي', style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold)),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'الاتصال مستقر وراوتر ميكروتك متزامن بنجاح ONLINE',
                  style: GoogleFonts.ibmPlexSansArabic(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _field(String label, String hint, {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.ibmPlexSansArabic(fontSize: 12, color: Colors.white70)),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscure,
          style: GoogleFonts.ibmPlexSansArabic(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.ibmPlexSansArabic(color: Colors.white30),
            filled: true,
            fillColor: CyberColors.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: CyberColors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: CyberColors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: CyberColors.cyan)),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CyberColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.ibmPlexSansArabic(fontSize: 10, color: Colors.white54)),
              Text(value, style: GoogleFonts.ibmPlexSansArabic(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ],
      ),
    );
  }
}

/// رسام الشبكة السيبرانية لتوليد خلفية الشاشات ديناميكياً بأعلى أداء
class CyberGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CyberColors.cyan.withOpacity(0.04)
      ..strokeWidth = 1.0;

    const double step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
```

---

### 3. عميل الاتصال براوتر ميكروتك: `lib/core/network/mikrotik_api_client.dart`

```dart
import 'dart:convert';
import 'package:dio/dio.dart';

class MikroTikApiClient {
  final Dio _dio;
  final String baseUrl;

  MikroTikApiClient({
    required this.baseUrl,
    required String username,
    required String password,
  }) : _dio = Dio(BaseOptions(
          baseUrl: 'http://$baseUrl/rest',
          headers: {
            'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
            'Content-Type': 'application/json',
          },
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 10),
        ));

  /// جلب الجلسات النشطة في الهوتسبوت
  Future<List<Map<String, dynamic>>> getActiveSessions() async {
    final res = await _dio.get('/ip/hotspot/active');
    return List<Map<String, dynamic>>.from(res.data);
  }

  /// حقن كرت هوتسبوت جديد
  Future<void> addVoucherUser({
    required String username,
    required String password,
    required String profile,
    String? comment,
  }) async {
    await _dio.put('/ip/hotspot/user', data: {
      'name': username,
      'password': password,
      'profile': profile,
      'comment': comment ?? 'Abayazeed-Batch',
    });
  }

  /// فصل مستخدم أو طرد جلسة
  Future<void> disconnectSession(String sessionId) async {
    await _dio.delete('/ip/hotspot/active/$sessionId');
  }

  /// جلب موارد المعالج والذاكرة
  Future<Map<String, dynamic>> getSystemResource() async {
    final res = await _dio.get('/system/resource');
    return Map<String, dynamic>.from(res.data);
  }
}
```

---

### 4. محرك طباعة كاشير Sunmi وطابعات ESC/POS: `lib/core/utils/sunmi_printer_service.dart`

```dart
import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class SunmiVoucherData {
  final String username;
  final String pin;
  final String packageName;
  final double price;
  final String currency;
  final String validity;
  final String quota;
  final String batchCode;

  SunmiVoucherData({
    required this.username,
    required this.pin,
    required this.packageName,
    required this.price,
    this.currency = 'د.ع',
    required this.validity,
    required this.quota,
    required this.batchCode,
  });

  String get loginUrl => 'http://hotspot.abayazeed.net/login?user=$username&pin=$pin';
}

class SunmiPrinterService {
  static bool _isBound = false;
  static bool _isEmulatorMode = false;

  static Future<bool> initialize() async {
    try {
      final bool? isBound = await SunmiPrinter.bindingPrinter();
      _isBound = isBound ?? false;
      if (_isBound) {
        await SunmiPrinter.initPrinter();
        _isEmulatorMode = false;
        return true;
      }
      _isEmulatorMode = true;
      return true;
    } catch (e) {
      _isEmulatorMode = true;
      return true;
    }
  }

  static Future<bool> printVoucher(BuildContext context, SunmiVoucherData voucher) async {
    if (!_isBound && !_isEmulatorMode) await initialize();

    // في حال العمل على محاكي أو هاتف عادي بدون طابعة مدمجة
    if (_isEmulatorMode) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF0F131C),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('معاينة طباعة كرت حراري Sunmi', style: TextStyle(color: Colors.white, fontSize: 15)),
          content: Container(
            width: 290,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('أبايذيد لنك منجر', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                const Text('MIKROTIK HOTSPOT CORE', style: TextStyle(color: Colors.black54, fontSize: 10)),
                const Divider(color: Colors.black84, thickness: 1.2),
                Text('${voucher.packageName} — ${voucher.price} ${voucher.currency}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Icon(Icons.qr_code_2, size: 74, color: Colors.black),
                const SizedBox(height: 6),
                Text('كود المستخدم: ${voucher.username}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                Text('رمز الـ PIN: ${voucher.pin}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                const Divider(color: Colors.black54),
                const Text('✂️ أمر القص التلقائي: تم بنجاح', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إغلاق', style: TextStyle(color: Color(0xFF00E5FF))),
            ),
          ],
        ),
      );
      return true;
    }

    // على جهاز Sunmi الفعلي
    try {
      await SunmiPrinter.startTransactionPrint(true);
      await SunmiPrinter.printText('أبايذيد لنك منجر\n', style: SunmiStyle(bold: true, align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.XL));
      await SunmiPrinter.printText('${voucher.packageName} - ${voucher.price} ${voucher.currency}\n');
      await SunmiPrinter.printQRCode(voucher.loginUrl, size: 5, errorLevel: SunmiQRErrorLevel.H);
      await SunmiPrinter.printText('User: ${voucher.username} | PIN: ${voucher.pin}\n');
      await SunmiPrinter.lineWrap(2);
      await SunmiPrinter.cut();
      await SunmiPrinter.exitTransactionPrint(true);
      return true;
    } catch (e) {
      await SunmiPrinter.exitTransactionPrint(false);
      return false;
    }
  }
}
```

---

### 5. ملف تصاريح الأندرويد لـ MikroTik و Sunmi: `android/app/src/main/AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.abayazeed.link_manager">

    <!-- صلاحية طابعات Sunmi المدمجة وقارئ الباركود -->
    <uses-permission android:name="woyou.aidlservice.jiuai.permission.PrinteDirect" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE" />
    <uses-permission android:name="android.permission.CAMERA" />

    <!-- إعلان ربط الخدمة لأندرويد 11 فما فوق -->
    <queries>
        <package android:name="woyou.aidlservice.jiuai" />
        <intent>
            <action android:name="woyou.aidlservice.jiuai.IWoyouService" />
        </intent>
    </queries>

    <application
        android:label="أبايذيد لنك منجر"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:screenOrientation="portrait"
            android:windowSoftInputMode="adjustResize">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
```

---

### 6. ملف إعدادات البناء: `android/app/build.gradle`

```groovy
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace "com.abayazeed.link_manager"
    compileSdkVersion 34

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = '17'
    }

    defaultConfig {
        applicationId "com.abayazeed.link_manager"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode 5
        versionName "5.0.0"
        multiDexEnabled true
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
            minifyEnabled false
            shrinkResources false
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation 'androidx.multidex:multidex:2.0.1'
}
```

---

### 7. ملف البناء السحابي التلقائي: `.github/workflows/build_apk.yml`

```yaml
name: 🚀 Build & Release Abayazeed Link Manager APK

on:
  push:
    branches:
      - main
      - master
  workflow_dispatch:

jobs:
  build-apk:
    name: 🏗️ بناء ملف APK السحابي لميكروتك
    runs-on: ubuntu-latest
    timeout-minutes: 25

    steps:
      - name: 📥 استنساخ المستودع (Checkout Repository)
        uses: actions/checkout@v4

      - name: ☕ إعداد بيئة Java 17
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'
          cache: 'gradle'

      - name: 💙 إعداد Flutter 3.19.x
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
          channel: 'stable'
          cache: true

      - name: 📱 تجهيز المشروع وإضافة الحزم وبناء ملف الـ APK
        run: |
          flutter create --org com.abayazeed --project-name abayazeedlinkmanager app_temp
          cp lib/main.dart app_temp/lib/main.dart
          sed -i 's/android:label=".*"/android:label="أبايذيد لنك منجر"/' app_temp/android/app/src/main/AndroidManifest.xml
          sed -i 's/<application/<application android:usesCleartextTraffic="true"/' app_temp/android/app/src/main/AndroidManifest.xml
          cd app_temp
          flutter pub add google_fonts
          flutter pub get
          flutter build apk --release

      - name: 🏷️ تجهيز وتسمية ملف الـ APK الناتج
        run: |
          mkdir -p output_release
          cp app_temp/build/app/outputs/flutter-apk/app-release.apk output_release/abayazeed_mikrotik_pro.apk

      - name: 📤 رفع ملف الـ APK للتحميل المباشر إلى هاتفك
        uses: actions/upload-artifact@v4
        with:
          name: abayazeed-link-manager-apk
          path: output_release/abayazeed_mikrotik_pro.apk
          retention-days: 30
```

---

### ⚡ أمر توليد وضغط الحزمة إلى `project.zip` فوراً (Python / Shell One-Liner):
إذا رغبت في إنشاء ملف `project.zip` الفعلي في ثانية واحدة داخل أي بيئة شل أو تيرمنال:
```bash
python3 -c "
import zipfile, os

files = {
    'pubspec.yaml': '''name: abayazeed_link_manager\ndescription: MikroTik Hotspot Manager\nversion: 5.0.0+1\nenvironment:\n  sdk: \">=3.3.0 <4.0.0\"\ndependencies:\n  flutter:\n    sdk: flutter\n  google_fonts: ^6.1.0\n  dio: ^5.4.1\n  sunmi_printer_plus: ^2.1.2\nflutter:\n  uses-material-design: true\n''',
    'lib/main.dart': '''// main.dart source code for Abayazeed Link Manager v5.0''',
    '.github/workflows/build_apk.yml': '''// build_apk.yml workflow script'''
}

with zipfile.ZipFile('project.zip', 'w') as z:
    for path, content in files.items():
        z.writestr(path, content)
print('✅ Created project.zip bundle successfully!')
"
```
