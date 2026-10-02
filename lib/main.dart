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

// ==============================================================================
// 1. شاشة تسجيل الدخول المدمجة بالخلفية السيبرانية والشعار 3D والخط العربي
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
          // الخلفية السيبرانية المتدرجة
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
                      // الشعار السيبراني المضيء
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

                      // صندوق تسجيل الدخول الزجاجي
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
        // بطاقة الراوتر المتصل
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

        // شبكة المقاييس والمؤشرات اللحظية
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

        // العمليات الميدانية السريعة
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

// ==============================================================================
// 3. شاشة إدارة الكروت والطباعة (Vouchers Tab)
// ==============================================================================
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

// ==============================================================================
// 4. شاشة المشتركين النشطين (Active Users Tab)
// ==============================================================================
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

// ==============================================================================
// 5. شاشة إعدادات العتاد و MikroTik (Hardware Tab)
// ==============================================================================
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
