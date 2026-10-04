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
  static const Color purple = Color(0xFFB388FF);
  static const Color amber = Color(0xFFFFD600);
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
  bool _isLoggedIn = true;
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return LoginCyberScreen(
        onLogin: () => setState(() => _isLoggedIn = true),
      );
    }

    final pages = [
      DashboardTab(
        onOpenVouchers: () => setState(() => _tabIndex = 1),
        onOpenUsers: () => setState(() => _tabIndex = 2),
      ),
      const VouchersTab(),
      const StoreTab(),
      const SolutionsTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      backgroundColor: CyberColors.bgDark,
      appBar: AppBar(
        backgroundColor: CyberColors.surface.withOpacity(0.92),
        elevation: 0,
        titleSpacing: 16,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white70, size: 20),
          tooltip: 'تسجيل الخروج',
          onPressed: () => setState(() => _isLoggedIn = false),
        ),
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
                  'شبكة: أبو يزيد نت (MikroTik CCR2004)',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 9,
                    color: CyberColors.cyan,
                    letterSpacing: 0.8,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white70),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: CyberColors.cyan),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تم تحديث البيانات الحية لميكروتك بنجاح 🔄',
                    style: GoogleFonts.ibmPlexSansArabic(),
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
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
            selectedLabelStyle: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 11),
            unselectedLabelStyle: GoogleFonts.ibmPlexSansArabic(fontSize: 10),
            onTap: (idx) => setState(() => _tabIndex = idx),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'الرئيسية'),
              BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), activeIcon: Icon(Icons.confirmation_number), label: 'الكروت'),
              BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), activeIcon: Icon(Icons.storefront), label: 'المتجر'),
              BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), activeIcon: Icon(Icons.menu_book), label: 'حلول'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'حسابي'),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
// 1. لوحة التحكم المدمجة الشاملة (البطاقة العلوية + استهلاك الإنترنت + إجراءات سريعة + الكروت + مقالات)
// ==============================================================================
class DashboardTab extends StatelessWidget {
  final VoidCallback onOpenVouchers;
  final VoidCallback onOpenUsers;

  const DashboardTab({
    super.key,
    required this.onOpenVouchers,
    required this.onOpenUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          children: [
            // 1. بطاقة استهلاك الإنترنت (Internet Consumption Card) - من الشاشة الجديدة
            _buildTrafficConsumptionCard(context),

            const SizedBox(height: 16),

            // 2. بطاقة المشرف والرصيد المتدرجة (مرحباً، صَدام أبوسيل + الرصيد 110)
            _buildUserWelcomeCard(),

            const SizedBox(height: 16),

            // 3. شبكة البطاقات المربعة الأربعة (إجمالي الكروت 521، متصلين الآن 5، السرعة الحية، والشبكات 1)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
              children: [
                _buildStatCard(
                  title: 'إجمالي الكروت',
                  value: '521',
                  icon: Icons.confirmation_number_outlined,
                  iconColor: CyberColors.cyan,
                  iconBgColor: CyberColors.cyan.withOpacity(0.15),
                  onTap: onOpenVouchers,
                ),
                _buildStatCard(
                  title: 'متصلين الآن',
                  value: '5',
                  icon: Icons.people_outline,
                  iconColor: CyberColors.green,
                  iconBgColor: CyberColors.green.withOpacity(0.15),
                  trailingIcon: Icons.chevron_left,
                  onTap: onOpenUsers,
                ),
                _buildSpeedCard(
                  title: 'السرعة الحية',
                  subtitle: 'أبو يزيد نت',
                  downSpeed: '9.5M ↓',
                  upSpeed: '420K ↑',
                ),
                _buildStatCard(
                  title: 'الشبكات',
                  value: '1',
                  subtitle: 'MikroTik CCR2004',
                  icon: Icons.router_outlined,
                  iconColor: CyberColors.orange,
                  iconBgColor: CyberColors.orange.withOpacity(0.15),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 4. قسم "إجراءات سريعة" (Quick Actions Grid) - 8 أزرار كما في لقطة الشاشة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'إجراءات سريعة',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'التحكم الفوري',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 11,
                    color: CyberColors.cyan,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildQuickActionsGrid(context),

            const SizedBox(height: 18),

            // 5. قسم إحصائيات ونسبة استهلاك الكروت (2,232 الإجمالي / 521 مستخدمة)
            _buildVoucherStatsCard(context),

            const SizedBox(height: 18),

            // 6. بطاقة "حلول وتجارب • موضوع مميز" (Knowledge Base Banner)
            _buildArticleCard(context),

            const SizedBox(height: 90), // مساحة للأزرار العائمة
          ],
        ),

        // أزرار الإجراءات السريعة العائمة في الأسفل (فحص كرت + تواصل معنا)
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CyberColors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 6,
                      shadowColor: CyberColors.blue.withOpacity(0.5),
                    ),
                    icon: const Icon(Icons.search, size: 20),
                    label: Text(
                      'فحص كرت',
                      style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    onPressed: () => _showCardInspectDialog(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CyberColors.green,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 6,
                      shadowColor: CyberColors.green.withOpacity(0.5),
                    ),
                    icon: const Icon(Icons.headset_mic_outlined, size: 20),
                    label: Text(
                      'تواصل معنا',
                      style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'جاري فتح خط الدعم الفني المباشر لشبكة أبو يزيد نت...',
                            style: GoogleFonts.ibmPlexSansArabic(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 1. بطاقة استهلاك الإنترنت (اليوم، هذا الشهر، الإجمالي مع الرفع والتنزيل)
  static Widget _buildTrafficConsumptionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CyberColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CyberColors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CyberColors.blue.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.cloud_outlined, color: CyberColors.cyan, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'استهلاك الإنترنت',
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: CyberColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'تحديث لحظي',
                  style: GoogleFonts.ibmPlexSansArabic(color: CyberColors.cyan, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // اليوم
              _buildConsumptionColumn(
                period: 'اليوم',
                value: 'GB 14.2',
                valueColor: CyberColors.green,
                downSpeed: 'GB 13.5 ↓',
                upSpeed: 'MB 708 ↑',
              ),
              Container(width: 1, height: 48, color: CyberColors.border),
              // هذا الشهر
              _buildConsumptionColumn(
                period: 'هذا الشهر',
                value: 'GB 214',
                valueColor: CyberColors.blue,
                downSpeed: 'GB 200 ↓',
                upSpeed: 'GB 13.5 ↑',
              ),
              Container(width: 1, height: 48, color: CyberColors.border),
              // الإجمالي
              _buildConsumptionColumn(
                period: 'الإجمالي',
                value: 'TB 1.39',
                valueColor: CyberColors.orange,
                downSpeed: 'TB 1.28 ↓',
                upSpeed: 'GB 112 ↑',
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildConsumptionColumn({
    required String period,
    required String value,
    required Color valueColor,
    required String downSpeed,
    required String upSpeed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          period,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 11,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          downSpeed,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 10,
            color: CyberColors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          upSpeed,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 10,
            color: CyberColors.orange,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // 2. بطاقة المشرف والرصيد
  static Widget _buildUserWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0052D4), Color(0xFF0F1E36), Color(0xFF0A111E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CyberColors.cyan.withOpacity(0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: CyberColors.cyan.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحباً،',
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'صَدام أبوسيل',
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CyberColors.cyan.withOpacity(0.2),
                  border: Border.all(color: CyberColors.cyan, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: CyberColors.cyan.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: CyberColors.cyan,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CyberColors.cyan.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.account_balance_wallet, color: CyberColors.cyan, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'رصيدك من الكروت',
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Text(
                  '110',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CyberColors.cyan,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. شبكة الإجراءات السريعة (8 بطاقات ملونة بنعومة كما في لقطة الشاشة)
  static Widget _buildQuickActionsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: [
        // 1. توليد كروت
        _buildActionTile(
          title: 'توليد كروت',
          icon: Icons.add_circle_outline,
          iconColor: CyberColors.cyan,
          iconBg: CyberColors.cyan.withOpacity(0.15),
          cardBg: const Color(0xFF14202B),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('فتح شاشة توليد الدفعات...', style: GoogleFonts.ibmPlexSansArabic())),
            );
          },
        ),
        // 2. قائمة الكروت
        _buildActionTile(
          title: 'قائمة الكروت',
          icon: Icons.view_list_outlined,
          iconColor: CyberColors.green,
          iconBg: CyberColors.green.withOpacity(0.15),
          cardBg: const Color(0xFF14241D),
          onTap: () {},
        ),
        // 3. المراقبة
        _buildActionTile(
          title: 'المراقبة',
          icon: Icons.show_chart,
          iconColor: CyberColors.amber,
          iconBg: CyberColors.amber.withOpacity(0.15),
          cardBg: const Color(0xFF262012),
          onTap: () {},
        ),
        // 4. التقارير والتحليل
        _buildActionTile(
          title: 'التقارير والتحليل',
          icon: Icons.bar_chart,
          iconColor: CyberColors.purple,
          iconBg: CyberColors.purple.withOpacity(0.15),
          cardBg: const Color(0xFF20172B),
          onTap: () {},
        ),
        // 5. مراقبة الانتينات
        _buildActionTile(
          title: 'مراقبة الانتينات',
          icon: Icons.cell_tower,
          iconColor: CyberColors.cyan,
          iconBg: CyberColors.cyan.withOpacity(0.15),
          cardBg: const Color(0xFF131D28),
          onTap: () {},
        ),
        // 6. سرعة الباقات
        _buildActionTile(
          title: 'سرعة الباقات',
          icon: Icons.speed,
          iconColor: CyberColors.orange,
          iconBg: CyberColors.orange.withOpacity(0.15),
          cardBg: const Color(0xFF241C15),
          onTap: () {},
        ),
        // 7. شحن الرصيد
        _buildActionTile(
          title: 'شحن الرصيد',
          icon: Icons.account_balance_wallet_outlined,
          iconColor: CyberColors.green,
          iconBg: CyberColors.green.withOpacity(0.15),
          cardBg: const Color(0xFF14241D),
          onTap: () {},
        ),
        // 8. عجلة الحظ
        _buildActionTile(
          title: 'عجلة الحظ',
          icon: Icons.grid_view_rounded,
          iconColor: CyberColors.amber,
          iconBg: CyberColors.amber.withOpacity(0.15),
          cardBg: const Color(0xFF262012),
          onTap: () {},
        ),
      ],
    );
  }

  static Widget _buildActionTile({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required Color cardBg,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: iconColor.withOpacity(0.25), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // 5. بطاقة إحصائيات الكروت ونسبة الاستخدام
  static Widget _buildVoucherStatsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CyberColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: CyberColors.cyan.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.analytics_outlined, color: CyberColors.cyan, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'إحصائيات الكروت',
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                'نسبة الاستخدام: 23%',
                style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 12,
                  color: CyberColors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 521 / 2232,
              minHeight: 8,
              backgroundColor: CyberColors.surfaceHigh,
              valueColor: const AlwaysStoppedAnimation<Color>(CyberColors.cyan),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statItem('الإجمالي', '2,232', Colors.white70),
              Container(width: 1, height: 26, color: CyberColors.border),
              _statItem('مستخدمة', '521', CyberColors.cyan),
              Container(width: 1, height: 26, color: CyberColors.border),
              _statItem('المتبقي', '1,711', CyberColors.green),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: CyberColors.surfaceHigh,
              foregroundColor: CyberColors.cyan,
              side: const BorderSide(color: CyberColors.cyan, width: 1),
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.print_outlined, size: 16),
            label: Text(
              'طباعة كرت تجريبي فوري (Sunmi / محاكي)',
              style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            onPressed: () => _showThermalVoucherModal(context),
          ),
        ],
      ),
    );
  }

  // 6. بطاقة "حلول وتجارب" التعليمية أسفل الشاشة
  static Widget _buildArticleCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CyberColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CyberColors.blue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.menu_book, color: CyberColors.cyan, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bookmark_border, color: CyberColors.cyan, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'حلول وتجارب • موضوع مميز',
                      style: GoogleFonts.ibmPlexSansArabic(fontSize: 10, color: CyberColors.cyan),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'الاستهلاك العادل في شبكات ميكروتك — كيف تقلل الاستهلاك؟',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: CyberColors.green, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '16 مشاركة • معتمدة ✅',
                      style: GoogleFonts.ibmPlexSansArabic(fontSize: 11, color: Colors.white54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // بطاقات الإحصائيات العامة
  Widget _buildStatCard({
    required String title,
    required String value,
    String? subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    IconData? trailingIcon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CyberColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CyberColors.border),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                if (trailingIcon != null)
                  Icon(trailingIcon, color: Colors.white38, size: 18),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 9,
                      color: CyberColors.cyan,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedCard({
    required String title,
    required String subtitle,
    required String downSpeed,
    required String upSpeed,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CyberColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: CyberColors.blue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.speed, color: CyberColors.cyan, size: 20),
              ),
              Text(
                subtitle,
                style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 10,
                  color: CyberColors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 11,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    downSpeed,
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: CyberColors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    upSpeed,
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: CyberColors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _statItem(String label, String val, Color color) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 11,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }

  static void _showCardInspectDialog(BuildContext context) {
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
            const Icon(Icons.search, color: CyberColors.cyan),
            const SizedBox(width: 8),
            Text(
              'فحص كرت هوتسبوت',
              style: GoogleFonts.ibmPlexSansArabic(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: GoogleFonts.ibmPlexSansArabic(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'أدخل كود الكرت (مثال: AY-8840)',
                hintStyle: GoogleFonts.ibmPlexSansArabic(color: Colors.white30, fontSize: 13),
                filled: true,
                fillColor: CyberColors.surfaceHigh,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('إلغاء', style: GoogleFonts.ibmPlexSansArabic(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: CyberColors.cyan, foregroundColor: Colors.black),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'الكرت AY-8840 فعال وصالح — باقة 24 ساعة توربو ✅',
                    style: GoogleFonts.ibmPlexSansArabic(),
                  ),
                ),
              );
            },
            child: Text('فحص فوري', style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold)),
          ),
        ],
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
              Text('شبكة أبو يزيد نت — MIKROTIK HOTSPOT', style: GoogleFonts.ibmPlexSansArabic(color: Colors.black54, fontSize: 10)),
              const Divider(color: Colors.black87, thickness: 1.2),
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
// 2. شاشة تسجيل الدخول المدمجة
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
        Text(label, style: GoogleFonts.ibmPlexSansArabic(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w600)),
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
// 3. تبويب الكروت
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

  static Widget _voucherItem(BuildContext ctx, String title, String price, String quota, String count) {
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
// 4. تبويب المتجر (Store Tab)
// ==============================================================================
class StoreTab extends StatelessWidget {
  const StoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'متجر باقات الإنترنت ورصيد الكروت',
          style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        _storeCard('باقة توربو 100 كرت', '220,000 د.ع', 'خصم 12% للوكلاء المعتمدين'),
        _storeCard('باقة الأعمال 500 كرت', '950,000 د.ع', 'خصم 20% + دعم فني مخصص'),
        _storeCard('رول ورق حراري Sunmi 80mm', '15,000 د.ع', 'كرتون 24 رول جودة عالية'),
      ],
    );
  }

  static Widget _storeCard(String title, String price, String desc) {
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
            child: const Icon(Icons.shopping_bag_outlined, color: CyberColors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(desc, style: GoogleFonts.ibmPlexSansArabic(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
          Text(price, style: GoogleFonts.ibmPlexSansArabic(color: CyberColors.cyan, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==============================================================================
// 5. تبويب الحلول والمقالات (Solutions Tab)
// ==============================================================================
class SolutionsTab extends StatelessWidget {
  const SolutionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'حلول وتجارب شبكات ميكروتك',
          style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 14),
        _solutionTile(
          'الاستهلاك العادل في ميكروتك — كيف تقلل استهلاك الباندويث؟',
          'دليل شامل لضبط Simple Queues وتحديد سرعات تيك توك ويوتيوب.',
          '16 مشاركة',
        ),
        _solutionTile(
          'حل مشكلة خروج الكروت المتكرر في هوتسبوت MikroTik',
          'شرح ضبط Idle Timeout و Keepalive Timeout لاستقرار الجلسات.',
          '28 مشاركة',
        ),
        _solutionTile(
          'طريقة تفعيل القص الآلي لطابعات Sunmi الحرارية',
          'أوامر AIDL المباشرة لطباعة كروت الهوتسبوت بدون تقطيع.',
          '9 مشاركات',
        ),
      ],
    );
  }

  static Widget _solutionTile(String title, String desc, String badge) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CyberColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.article_outlined, color: CyberColors.cyan, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(desc, style: GoogleFonts.ibmPlexSansArabic(color: Colors.white60, fontSize: 11)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: CyberColors.surfaceHigh, borderRadius: BorderRadius.circular(6)),
            child: Text(badge, style: GoogleFonts.ibmPlexSansArabic(color: CyberColors.green, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 6. تبويب حسابي (Profile Tab)
// ==============================================================================
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Column(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CyberColors.surfaceHigh,
                  border: Border.all(color: CyberColors.cyan, width: 2),
                ),
                child: const Center(
                  child: Text('A', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: CyberColors.cyan)),
                ),
              ),
              const SizedBox(height: 10),
              Text('صَدام أبوسيل', style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 18)),
              Text('مدير شبكة أبو يزيد نت (NOC Admin)', style: GoogleFonts.ibmPlexSansArabic(color: CyberColors.cyan, fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _profileItem(Icons.router_outlined, 'إعدادات راوتر MikroTik', '192.168.88.1'),
        _profileItem(Icons.security, 'صلاحيات الحساب والجدار الناري', 'Admin Level (Full Access)'),
        _profileItem(Icons.print_outlined, 'طابعات الكروت المعرفة', 'Sunmi V2 Built-in / ESC/POS'),
        _profileItem(Icons.help_outline, 'الدعم الفني المباشر', 'متاح 24/7'),
      ],
    );
  }

  static Widget _profileItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CyberColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: CyberColors.cyan, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.ibmPlexSansArabic(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(subtitle, style: GoogleFonts.ibmPlexSansArabic(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 14),
        ],
      ),
    );
  }
}

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
