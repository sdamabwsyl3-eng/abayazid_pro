import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

/// الخط المحلي (يعمل بدون إنترنت) — بديل لحزمة google_fonts
class GoogleFonts {
  static TextStyle ibmPlexSansArabic({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
  }) =>
      TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextTheme ibmPlexSansArabicTextTheme([TextTheme? base]) =>
      (base ?? ThemeData.dark().textTheme)
          .apply(fontFamily: 'IBMPlexSansArabic');
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

// ==============================================================================
// 1. شاشة تسجيل الدخول
// ==============================================================================
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

// ==============================================================================
// 2. لوحة التحكم المركزية (Dashboard Tab)
// ==============================================================================
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
              const Divider(color: Colors.black87, thickness: 1.2),
              Text('باقة 24 ساعة توربو — 2,500 د.ع', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Icon(Icons.qr_code_2, size: 74, color: Colors.black),
              const SizedBox(height: 6),
              Text('كود المستخدم: AY-8840-2911', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
              Text('رمز الـ PIN: 491028', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
              const Divider(color: Colors.black54