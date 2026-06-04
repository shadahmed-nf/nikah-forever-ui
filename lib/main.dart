import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const NikahForeverApp());
}

const kPink = Color(0xFFE91E8C);
const kDark = Color(0xFF1A1A2E);
const kBg = Color(0xFFF5F5F5);

class NikahForeverApp extends StatelessWidget {
  const NikahForeverApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nikah Forever',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: kPink),
      ),
      home: const BismillahSplash(),
    );
  }
}

// ════════════════════════════════════════
// BISMILLAH SPLASH
// ════════════════════════════════════════
class BismillahSplash extends StatefulWidget {
  const BismillahSplash({super.key});
  @override
  State<BismillahSplash> createState() => _BismillahSplashState();
}

class _BismillahSplashState extends State<BismillahSplash>
    with TickerProviderStateMixin {
  late AnimationController _scrollCtrl;
  late AnimationController _centerCtrl;
  late Animation<double> _scrollAnim;
  late Animation<double> _centerAnim;

  @override
  void initState() {
    super.initState();
    _scrollCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    _centerCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _scrollAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _scrollCtrl, curve: Curves.easeOut));
    _centerAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _centerCtrl, curve: Curves.easeIn));
    _start();
  }

  void _start() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _scrollCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    _centerCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 2200));
    if (mounted) {
      Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const ProfileCountSplash(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ));
    }
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    _centerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: kPink,
        child: AnimatedBuilder(
          animation: Listenable.merge([_scrollAnim, _centerAnim]),
          builder: (_, __) {
            return Stack(
              children: [
                ...List.generate(9, (i) {
                  final center = 4;
                  final dist = (i - center).abs();
                  final opacity = dist == 0 ? 0.0
                      : (1.0 - dist * 0.15).clamp(0.12, 0.45);
                  final baseY = (i / 9) * h * 1.1 - h * 0.05;
                  final offset = _scrollAnim.value * 25.0 * (i % 2 == 0 ? 1 : -1);
                  return Positioned(
                    top: baseY + offset,
                    left: 0, right: 0,
                    child: Center(
                      child: Text('BISMILLAH',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w900,
                              color: Colors.white.withOpacity(opacity),
                              letterSpacing: 3)),
                    ),
                  );
                }),
                Center(
                  child: FadeTransition(
                    opacity: _centerAnim,
                    child: const Text('BISMILLAH',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w900,
                            color: Colors.white, letterSpacing: 3)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ════════════════════════════════════════
// 6000+ PROFILES SPLASH
// ════════════════════════════════════════
class ProfileCountSplash extends StatefulWidget {
  const ProfileCountSplash({super.key});
  @override
  State<ProfileCountSplash> createState() => _ProfileCountSplashState();
}

class _ProfileCountSplashState extends State<ProfileCountSplash>
    with TickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late AnimationController _scaleCtrl;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _scaleCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _scaleCtrl, curve: Curves.elasticOut));
    _fadeCtrl.forward();
    Future.delayed(const Duration(milliseconds: 200),
            () => _scaleCtrl.forward());
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MainShell(),
              transitionsBuilder: (_, anim, __, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: const Duration(milliseconds: 600),
            ));
      }
    });
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPink,
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('السلام عليكم',
                  style: TextStyle(fontSize: 32, color: Colors.white,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 30),
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 18),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20)]),
                  child: const Text('6000+ Profiles',
                      style: TextStyle(fontSize: 32,
                          fontWeight: FontWeight.w900, color: kPink)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Daily',
                  style: TextStyle(fontSize: 28,
                      fontWeight: FontWeight.w800, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════
// MAIN SHELL
// ════════════════════════════════════════
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with TickerProviderStateMixin {
  int _idx = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }

  final _pages = const [HomeTab(), ActivityTab(), ChatPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) =>
            FadeTransition(opacity: anim, child: child),
        child: KeyedSubtree(key: ValueKey(_idx), child: _pages[_idx]),
      ),
      bottomNavigationBar: _buildNav(),
    );
  }

  Widget _buildNav() {
    final items = [
      {'icon': Icons.favorite_border, 'active': Icons.favorite, 'label': 'For You'},
      {'icon': Icons.access_time_outlined, 'active': Icons.access_time, 'label': 'Activity', 'dot': true},
      {'icon': Icons.chat_bubble_outline, 'active': Icons.chat_bubble, 'label': 'Chats', 'dot': true},
      {'icon': Icons.person_outline, 'active': Icons.person, 'label': 'Profile'},
    ];
    return Container(
      decoration: BoxDecoration(color: Colors.white,
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.07), blurRadius: 20,
              offset: const Offset(0, -4))]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: List.generate(items.length, (i) {
              final isActive = _idx == i;
              final item = items[i];
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _idx = i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Stack(clipBehavior: Clip.none, children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: isActive
                                ? kPink.withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12)),
                        child: Icon(
                            isActive
                                ? item['active'] as IconData
                                : item['icon'] as IconData,
                            color: isActive ? kPink : Colors.grey.shade400,
                            size: 24),
                      ),
                      if (item['dot'] == true)
                        Positioned(top: 0, right: 0,
                            child: Container(width: 8, height: 8,
                                decoration: const BoxDecoration(
                                    color: kPink, shape: BoxShape.circle))),
                    ]),
                    const SizedBox(height: 2),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(fontSize: 11,
                          fontWeight: isActive
                              ? FontWeight.w700 : FontWeight.normal,
                          color: isActive ? kPink : Colors.grey.shade400),
                      child: Text(item['label'] as String),
                    ),
                  ]),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════
// HOME TAB
// ════════════════════════════════════════
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  int _tab = 0;
  final Map<int, bool> _sent = {};
  final Map<int, bool> _saved = {};
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  final List<Map<String, dynamic>> _profiles = [
    {'name': 'Sahil', 'age': 27, 'isPremium': true, 'isOnline': true,
      'occupation': 'Interior Designer', 'location': 'New Delhi, India',
      'caste': 'Sunni/Khan or Pathan', 'earnings': 'Earns Rs. 7 - 10 Lakh',
      'photoCount': 4, 'badge': 'High Match Chances',
      'imageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=600&fit=crop',
      'maritalStatus': 'Never Married', 'height': '5ft 10in',
      'motherTongue': 'Hindi / Urdu', 'sect': 'Sunni, Khan',
      'bio': 'A passionate interior designer with an eye for detail. Looking for a life partner who values both tradition and modern living.'},
    {'name': 'Tahrim', 'age': 20, 'isPremium': false, 'isOnline': false,
      'occupation': 'Student', 'location': 'Delhi, India',
      'caste': 'Sunni/Khan or Pathan', 'photoCount': 3,
      'imageUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&h=600&fit=crop',
      'maritalStatus': 'Never Married', 'height': '5ft 4in',
      'motherTongue': 'Hindi / Urdu', 'sect': 'Sunni, Khan',
      'bio': 'Currently pursuing my degree. Looking for someone who shares Islamic values and a love for learning.'},
    {'name': 'Sayed Iqra', 'age': 22, 'isPremium': false, 'isOnline': true,
      'occupation': 'Medical/Healthcare Professional', 'location': 'New Delhi, India',
      'caste': 'Sunni/Syed', 'earnings': 'Earns Rs. 2 - 3 Lakh',
      'photoCount': 4, 'badge': 'Same Hometown',
      'imageUrl': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&h=600&fit=crop',
      'maritalStatus': 'Never Married', 'height': '5ft 2in',
      'motherTongue': 'Urdu', 'sect': 'Sunni, Syed',
      'bio': 'Working in healthcare with a passion for helping others. Family-oriented and looking for a like-minded partner.'},
    {'name': 'Nisha Malik', 'age': 24, 'isPremium': true, 'isOnline': false,
      'occupation': 'Software Engineer', 'location': 'Bangalore, India',
      'caste': 'Sunni/Malik', 'earnings': 'Earns Rs. 8 - 12 Lakh',
      'photoCount': 5, 'badge': 'High Match Chances',
      'imageUrl': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&h=600&fit=crop',
      'maritalStatus': 'Never Married', 'height': '5ft 5in',
      'motherTongue': 'Hindi', 'sect': 'Sunni, Malik',
      'bio': 'Tech professional who loves coding and travelling. Looking for a partner who respects both career and faith.'},
    {'name': 'Zara Ahmed', 'age': 23, 'isPremium': false, 'isOnline': true,
      'occupation': 'Fashion Designer', 'location': 'Mumbai, India',
      'caste': 'Sunni/Sheikh', 'earnings': 'Earns Rs. 4 - 6 Lakh',
      'photoCount': 6,
      'imageUrl': 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400&h=600&fit=crop',
      'maritalStatus': 'Never Married', 'height': '5ft 6in',
      'motherTongue': 'Urdu', 'sect': 'Sunni, Sheikh',
      'bio': 'Creative fashion designer based in Mumbai. Strong in faith and family values.'},
    {'name': 'Fatima Khan', 'age': 25, 'isPremium': true, 'isOnline': false,
      'occupation': 'Doctor', 'location': 'Hyderabad, India',
      'caste': 'Sunni/Khan', 'earnings': 'Earns Rs. 10 - 15 Lakh',
      'photoCount': 3, 'badge': 'Same Hometown',
      'imageUrl': 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=400&h=600&fit=crop',
      'maritalStatus': 'Never Married', 'height': '5ft 3in',
      'motherTongue': 'Telugu / Urdu', 'sect': 'Sunni, Khan',
      'bio': 'MBBS doctor committed to service and spirituality. Seeking a life partner with similar values.'},
    {'name': 'Aisha Siddiqui', 'age': 21, 'isPremium': false, 'isOnline': true,
      'occupation': 'Architect', 'location': 'Pune, India',
      'caste': 'Sunni/Siddiqui', 'photoCount': 4,
      'imageUrl': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400&h=600&fit=crop',
      'maritalStatus': 'Never Married', 'height': '5ft 7in',
      'motherTongue': 'Urdu', 'sect': 'Sunni, Siddiqui',
      'bio': 'Architecture student with a passion for design and Islamic art. Family comes first.'},
    {'name': 'Mariam Raza', 'age': 26, 'isPremium': true, 'isOnline': false,
      'occupation': 'Business Owner', 'location': 'Lucknow, India',
      'caste': 'Sunni/Raza', 'earnings': 'Earns Rs. 15 - 20 Lakh',
      'photoCount': 5, 'badge': 'High Match Chances',
      'imageUrl': 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=400&h=600&fit=crop',
      'maritalStatus': 'Never Married', 'height': '5ft 5in',
      'motherTongue': 'Hindi / Urdu', 'sect': 'Sunni, Raza',
      'bio': 'Entrepreneur running a successful business. Looking for a supportive and understanding life partner.'},
  ];

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered =>
      _tab == 1
          ? _profiles.where((p) => p['isOnline'] == true).toList()
          : _profiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Column(children: [
          _tabBar(),
          Expanded(child: _list()),
        ]),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: Row(children: [
        Container(width: 30, height: 30,
            decoration: BoxDecoration(color: kPink,
                borderRadius: BorderRadius.circular(8)),
            child: const Center(
                child: Text('nf', style: TextStyle(
                    color: Colors.white, fontSize: 12,
                    fontWeight: FontWeight.bold)))),
        const SizedBox(width: 8),
        const Text('nikahforever', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600,
            color: kDark, letterSpacing: -0.5)),
      ]),
      actions: [
        Container(margin: const EdgeInsets.only(right: 6),
            width: 34, height: 34,
            decoration: const BoxDecoration(color: kPink, shape: BoxShape.circle),
            child: const Icon(Icons.rocket_launch, color: Colors.white, size: 16)),
        Stack(children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: kDark, size: 24),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const NotificationsPage())),
          ),
          Positioned(right: 6, top: 6,
              child: Container(width: 16, height: 16,
                  decoration: const BoxDecoration(color: kPink, shape: BoxShape.circle),
                  child: const Center(child: Text('1',
                      style: TextStyle(color: Colors.white,
                          fontSize: 9, fontWeight: FontWeight.bold))))),
        ]),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _tabBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(children: [
        _tabBtn(0, 'Matches'),
        const SizedBox(width: 10),
        _tabBtn(1, 'Online'),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SearchProfilesPage())),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: kPink, width: 1.5),
                borderRadius: BorderRadius.circular(25)),
            child: const Row(children: [
              Icon(Icons.search, color: kPink, size: 16),
              SizedBox(width: 4),
              Text('Search', style: TextStyle(
                  color: kPink, fontSize: 13, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _tabBtn(int index, String label) {
    final isSel = _tab == index;
    return GestureDetector(
      onTap: () {
        setState(() => _tab = index);
        _fadeCtrl.reset();
        _fadeCtrl.forward();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
            color: isSel ? kDark : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: isSel ? null : Border.all(color: Colors.grey.shade300)),
        child: Text(label, style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600,
            color: isSel ? Colors.white : Colors.black87)),
      ),
    );
  }

  Widget _list() {
    final profiles = _filtered;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      itemCount: profiles.length,
      itemBuilder: (context, i) {
        return _SlideCard(
          delay: Duration(milliseconds: i * 80),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _card(profiles[i], i),
          ),
        );
      },
    );
  }

  Widget _card(Map<String, dynamic> p, int index) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => ProfileDetailPage(profile: p))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 500,
          child: Stack(fit: StackFit.expand, children: [
            Image.network(p['imageUrl'], fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(color: kDark,
                      child: Center(child: CircularProgressIndicator(
                          color: kPink,
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!
                              : null)));
                },
                errorBuilder: (_, __, ___) => Container(
                    color: kDark, child: const Icon(Icons.person,
                    size: 80, color: Colors.white24))),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    stops: [0.3, 0.7, 1.0],
                    colors: [Colors.transparent, Color(0x88000000), Colors.black]),
              ),
            ),
            Positioned(top: 14, left: 14, right: 14,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (p['badge'] != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.black54,
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(p['badge'] == 'High Match Chances'
                                ? Icons.trending_up : Icons.home_outlined,
                                color: Colors.white, size: 13),
                            const SizedBox(width: 4),
                            Text(p['badge'], style: const TextStyle(
                                color: Colors.white, fontSize: 12,
                                fontWeight: FontWeight.w500)),
                          ]),
                        )
                      else const SizedBox(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.black54,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(children: [
                          const Icon(Icons.photo_library_outlined,
                              color: Colors.white, size: 13),
                          const SizedBox(width: 4),
                          Text('${p['photoCount']}', style: const TextStyle(
                              color: Colors.white, fontSize: 12)),
                        ]),
                      ),
                    ])),
            Positioned(bottom: 0, left: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (p['isOnline'] == true)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(children: [
                              _PulsingDot(),
                              const SizedBox(width: 5),
                              const Text('Online', style: TextStyle(
                                  color: Colors.white, fontSize: 13)),
                            ]),
                          ),
                        Row(children: [
                          Text('${p['name']}, ${p['age']}',
                              style: const TextStyle(color: Colors.white,
                                  fontSize: 26, fontWeight: FontWeight.bold,
                                  letterSpacing: -0.3)),
                          if (p['isPremium'] == true) ...[
                            const SizedBox(width: 8),
                            const Text('👑', style: TextStyle(fontSize: 18)),
                          ],
                        ]),
                        const SizedBox(height: 4),
                        Text(
                          [p['occupation'], p['location'], p['caste'],
                            if (p['earnings'] != null) p['earnings']].join(' • '),
                          style: const TextStyle(color: Colors.white70,
                              fontSize: 13, height: 1.4),
                        ),
                        const SizedBox(height: 14),
                        _btns(p, index),
                      ]),
                )),
          ]),
        ),
      ),
    );
  }

  Widget _btns(Map<String, dynamic> p, int index) {
    final sent = _sent[index] ?? false;
    final saved = _saved[index] ?? false;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _TapButton(
        icon: saved ? Icons.bookmark : Icons.bookmark_border,
        label: saved ? 'Saved!' : 'Shortlist',
        color: saved ? Colors.amber.shade700 : Colors.black87,
        onTap: () => setState(() => _saved[index] = !saved),
      ),
      _TapButton(
        icon: Icons.chat_bubble,
        label: 'Message',
        color: const Color(0xFF5B6EE8),
        onTap: () {},
      ),
      _InterestBtn(
        name: p['name'],
        sent: sent,
        onToggle: () => setState(() => _sent[index] = !sent),
      ),
    ]);
  }
}

// ════════════════════════════════════════
// PROFILE DETAIL PAGE
// ════════════════════════════════════════
class ProfileDetailPage extends StatefulWidget {
  final Map<String, dynamic> profile;
  const ProfileDetailPage({super.key, required this.profile});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage>
    with TickerProviderStateMixin {
  int _tabIndex = 0;
  bool _interestSent = false;
  bool _shortlisted = false;
  bool _bioExpanded = false;
  late TabController _tabCtrl;

  final _tabs = ['Basic', 'Contact', 'Education & Career', 'Family'];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _tabs.length, vsync: this);
    _tabCtrl.addListener(() {
      setState(() => _tabIndex = _tabCtrl.index);
    });
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> get p => widget.profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Column(children: [
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (_, __) => [
              SliverToBoxAdapter(child: _buildPhoto()),
              SliverToBoxAdapter(child: _buildTabBar()),
            ],
            body: TabBarView(
              controller: _tabCtrl,
              children: [
                _BasicTab(profile: p, bioExpanded: _bioExpanded,
                    onBioToggle: () => setState(() => _bioExpanded = !_bioExpanded)),
                _ContactTab(profile: p),
                _EducationTab(profile: p),
                _FamilyTab(profile: p),
              ],
            ),
          ),
        ),
        _bottomBar(),
      ]),
    );
  }

  Widget _buildPhoto() {
    return Stack(children: [
      // Photo
      Container(
        height: 360,
        color: kDark,
        child: Stack(fit: StackFit.expand, children: [
          Image.network(p['imageUrl'] ?? '', fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF2A2A3A),
                  child: const Center(
                      child: Icon(Icons.person, size: 80, color: Colors.white24)))),
          // Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  stops: [0.5, 1.0],
                  colors: [Colors.transparent, Colors.black87]),
            ),
          ),
          // Request Photo button
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25)),
              child: const Text('Request Photo',
                  style: TextStyle(color: kPink, fontWeight: FontWeight.w600,
                      fontSize: 14)),
            ),
          ),
          // Name at bottom
          Positioned(bottom: 16, left: 16, right: 60,
              child: Text('${p['name']}, ${p['age']}',
                  style: const TextStyle(color: Colors.white, fontSize: 22,
                      fontWeight: FontWeight.bold))),
          // Arrow right
          Positioned(bottom: 16, right: 16,
              child: Container(width: 32, height: 32,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white, size: 16))),
        ]),
      ),
      // Back + more buttons
      Positioned(top: MediaQuery.of(context).padding.top + 8, left: 8,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(width: 36, height: 36,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 18)),
          )),
      Positioned(top: MediaQuery.of(context).padding.top + 8, right: 8,
          child: Container(width: 36, height: 36,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle),
              child: PopupMenuButton(
                icon: const Icon(Icons.more_horiz, color: Colors.white, size: 20),
                itemBuilder: (_) => [
                  const PopupMenuItem(child: Row(children: [
                    Icon(Icons.share_outlined), SizedBox(width: 8), Text('Share')])),
                  const PopupMenuItem(child: Row(children: [
                    Icon(Icons.flag_outlined), SizedBox(width: 8), Text('Report')])),
                  const PopupMenuItem(child: Row(children: [
                    Icon(Icons.block_outlined, color: Colors.red),
                    SizedBox(width: 8), Text('Block', style: TextStyle(color: Colors.red))])),
                ],
              ))),
    ]);
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabCtrl,
        isScrollable: true,
        labelColor: kPink,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: kPink, width: 2.5)),
        tabs: _tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12, offset: const Offset(0, -3))]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _DetailActionBtn(
          icon: _shortlisted ? Icons.bookmark : Icons.bookmark_border,
          label: 'Shortlist',
          color: _shortlisted ? Colors.amber.shade700 : Colors.black87,
          onTap: () => setState(() => _shortlisted = !_shortlisted),
        ),
        _DetailActionBtn(
          icon: Icons.chat_bubble,
          label: 'Message',
          color: const Color(0xFF5B6EE8),
          onTap: () {},
        ),
        _InterestBtn(
          name: p['name'],
          sent: _interestSent,
          onToggle: () => setState(() => _interestSent = !_interestSent),
        ),
      ]),
    );
  }
}

class _DetailActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _DetailActionBtn({required this.icon, required this.label,
    required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(width: 54, height: 54,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                    color: color.withOpacity(0.3), blurRadius: 8)]),
            child: Icon(icon, color: Colors.white, size: 24)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, color: kDark)),
      ]),
    );
  }
}

// ── Basic Tab
class _BasicTab extends StatelessWidget {
  final Map<String, dynamic> profile;
  final bool bioExpanded;
  final VoidCallback onBioToggle;
  const _BasicTab({required this.profile, required this.bioExpanded,
    required this.onBioToggle});

  @override
  Widget build(BuildContext context) {
    final p = profile;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('Basic Details'),
        _detailCard([
          _detailRow(Icons.favorite_border, p['maritalStatus'] ?? 'Never Married'),
          _divider(),
          _detailRow(Icons.straighten, p['height'] ?? '5ft 5in'),
          _divider(),
          _detailRow(Icons.location_on_outlined, p['location'] ?? ''),
          _divider(),
          _detailRow(Icons.language, p['motherTongue'] ?? 'Hindi / Urdu'),
          _divider(),
          _detailRow(Icons.nights_stay_outlined, p['sect'] ?? 'Sunni'),
          _divider(),
          _detailRow(Icons.person_outline, 'Profile created for Self'),
        ]),
        const SizedBox(height: 16),
        Text(p['name'] ?? '',
            style: const TextStyle(fontSize: 16,
                fontWeight: FontWeight.bold, color: kDark)),
        const SizedBox(height: 8),
        _bioCard(p['bio'] ?? ''),
      ],
    );
  }

  Widget _bioCard(String bio) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
              blurRadius: 8)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          bioExpanded ? bio : bio.length > 120 ? '${bio.substring(0, 120)}...' : bio,
          style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.6),
        ),
        if (bio.length > 120)
          GestureDetector(
            onTap: onBioToggle,
            child: Text(bioExpanded ? 'View Less' : 'View More',
                style: const TextStyle(
                    color: kPink, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
      ]),
    );
  }
}

// ── Contact Tab
class _ContactTab extends StatelessWidget {
  final Map<String, dynamic> profile;
  const _ContactTab({required this.profile});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Things in common
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
                  blurRadius: 8)]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CircleAvatar(radius: 18, backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.person, size: 18)),
              const SizedBox(width: 4),
              CircleAvatar(radius: 18, backgroundColor: kPink,
                  child: const Icon(Icons.person, size: 18, color: Colors.white)),
              const SizedBox(width: 10),
              const Text('Things you both share in common',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ]),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: [
              _chip('🌐 ${profile['motherTongue'] ?? 'Hindi / Urdu'}'),
              _chip('🎓 B.A.'),
              _chip('🌙 ${(profile['sect'] ?? 'Sunni').toString().split(',').first.trim()}'),
            ]),
          ]),
        ),
        const SizedBox(height: 16),
        _sectionTitle('Contact Details'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.amber.shade200),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
                  blurRadius: 8)]),
          child: Column(children: [
            _maskedContact(Icons.phone_outlined, '+91-96XXXXXX07'),
            const Divider(),
            _maskedContact(Icons.email_outlined, 't2XXXXXXXXX@XXXXX.com'),
            const Divider(height: 24),
            const Text('Upgrade to view contact details',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFFDAA520), Color(0xFFFFA500)]),
                  borderRadius: BorderRadius.circular(24)),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.workspace_premium, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('Upgrade Now', style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold,
                    fontSize: 16)),
              ]),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }

  Widget _maskedContact(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Container(width: 36, height: 36,
            decoration: BoxDecoration(shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200)),
            child: Icon(icon, size: 18, color: Colors.grey)),
        const SizedBox(width: 12),
        Text(value, style: const TextStyle(fontSize: 15, color: kDark)),
      ]),
    );
  }
}

// ── Education Tab
class _EducationTab extends StatelessWidget {
  final Map<String, dynamic> profile;
  const _EducationTab({required this.profile});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('Education & Career'),
        _detailCard([
          _detailRowWithSub(Icons.school_outlined, 'B.A.', null),
          _divider(),
          _detailRowWithSub(Icons.work_outline, profile['occupation'] ?? 'Professional', 'Defence'),
          _divider(),
          _detailRowWithSub(Icons.account_balance_wallet_outlined,
              profile['earnings'] ?? 'No Income', 'Annual Income'),
        ]),
        const SizedBox(height: 16),
        _sectionTitle('Family Details'),
        _detailCard([
          _detailRowWithSub(Icons.location_on_outlined,
              'Family lives in', profile['location'] ?? ''),
        ]),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('Member Profile ID: ', style: TextStyle(
                  fontSize: 13, color: Colors.grey)),
              Text('ECA5C2304877', style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: kDark)),
              const SizedBox(width: 6),
              const Icon(Icons.copy, size: 16, color: Colors.grey),
            ]),
          ),
        ),
      ],
    );
  }
}

// ── Family Tab
class _FamilyTab extends StatelessWidget {
  final Map<String, dynamic> profile;
  const _FamilyTab({required this.profile});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('Family Details'),
        _detailCard([
          _detailRowWithSub(Icons.location_on_outlined,
              'Family lives in', profile['location'] ?? 'India'),
          _divider(),
          _detailRowWithSub(Icons.people_outline, 'Family Type', 'Nuclear Family'),
          _divider(),
          _detailRowWithSub(Icons.home_outlined, 'Family Values', 'Traditional'),
        ]),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8)),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Text('Member Profile ID: ', style: TextStyle(
                  fontSize: 13, color: Colors.grey)),
              Text('ECA5C2304877', style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: kDark)),
              SizedBox(width: 6),
              Icon(Icons.copy, size: 16, color: Colors.grey),
            ]),
          ),
        ),
      ],
    );
  }
}

// Shared tab helpers
Widget _sectionTitle(String title) => Padding(
  padding: const EdgeInsets.only(bottom: 10),
  child: Text(title, style: const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: kDark)),
);

Widget _detailCard(List<Widget> children) => Container(
  decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
          blurRadius: 8)]),
  child: Column(children: children),
);

Widget _detailRow(IconData icon, String value) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  child: Row(children: [
    Container(width: 36, height: 36,
        decoration: BoxDecoration(shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200)),
        child: Icon(icon, size: 18, color: Colors.grey.shade600)),
    const SizedBox(width: 14),
    Expanded(child: Text(value, style: const TextStyle(
        fontSize: 15, color: kDark))),
  ]),
);

Widget _detailRowWithSub(IconData icon, String title, String? sub) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  child: Row(children: [
    Container(width: 36, height: 36,
        decoration: BoxDecoration(shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200)),
        child: Icon(icon, size: 18, color: Colors.grey.shade600)),
    const SizedBox(width: 14),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: kDark)),
          if (sub != null && sub.isNotEmpty)
            Text(sub, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        ])),
  ]),
);

Widget _divider() =>
    Divider(height: 1, indent: 66, color: Colors.grey.shade100);

// ════════════════════════════════════════
// NOTIFICATIONS PAGE
// ════════════════════════════════════════
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;

  final _items = [
    {'label': 'Interest Requests', 'badge': null},
    {'label': 'Interests Accepted', 'badge': 1},
    {'label': 'Photo Requests', 'badge': null},
    {'label': 'Others', 'badge': null},
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kDark)),
      ),
      body: FadeTransition(
        opacity: _fade,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.04), blurRadius: 12)]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_items.length, (i) {
                final item = _items[i];
                final isLast = i == _items.length - 1;
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + i * 80),
                  curve: Curves.easeOut,
                  builder: (_, val, child) => Opacity(opacity: val,
                      child: Transform.translate(
                          offset: Offset(0, 20 * (1 - val)), child: child)),
                  child: Column(children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        child: Row(children: [
                          Text(item['label'] as String,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500,
                                  color: kDark)),
                          const Spacer(),
                          if (item['badge'] != null)
                            Container(width: 28, height: 28,
                                decoration: const BoxDecoration(
                                    color: kPink, shape: BoxShape.circle),
                                child: Center(child: Text('${item['badge']}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13,
                                        fontWeight: FontWeight.bold))))
                          else
                            const Icon(Icons.arrow_forward_ios,
                                size: 15, color: Colors.grey),
                        ]),
                      ),
                    ),
                    if (!isLast) Divider(height: 1,
                        color: Colors.grey.shade100,
                        indent: 20, endIndent: 20),
                  ]),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════
// SEARCH PROFILES PAGE
// ════════════════════════════════════════
class SearchProfilesPage extends StatefulWidget {
  const SearchProfilesPage({super.key});
  @override
  State<SearchProfilesPage> createState() => _SearchProfilesPageState();
}

class _SearchProfilesPageState extends State<SearchProfilesPage> {
  RangeValues _ageRange = const RangeValues(18, 24);
  RangeValues _heightRange = const RangeValues(0, 10);
  RangeValues _incomeRange = const RangeValues(0, 100);
  String _maritalStatus = 'Never Married';
  String _motherTongue = 'Open to all';
  String _sect = 'Sunni';
  String _caste = 'Open to all';
  String _country = 'India';
  String _state = 'Open to all';
  String _city = 'Open to all';
  String _education = 'Open to all';
  String _employedIn = 'Open to all';

  final _maritalStatuses = ['Never Married', 'Divorced', 'Widowed',
    'Awaiting Divorce', 'Annulled', 'Open to all'];
  final _languages = ['Open to all', 'Arabic', 'Bengali', 'English',
    'Gujarati', 'Hindi', 'Kannada', 'Malayalam', 'Marathi', 'Punjabi',
    'Tamil', 'Telugu', 'Urdu', 'Persian', 'Turkish', 'Other'];
  final _sects = ['Sunni', 'Shia', 'Ahmadiyya', 'Ismaili', 'Sufi', 'Open to all'];
  final _castes = ['Open to all', 'Arab', 'Ansari', 'Bohri', 'Khan / Pathan',
    'Malik', 'Memon', 'Mirza', 'Mughal', 'Qureshi', 'Rajput',
    'Sayyid / Syed', 'Shamsi', 'Sheikh', 'Siddiqui', 'Turk', 'Other'];
  final _countries = ['India', 'Pakistan', 'Bangladesh', 'UAE', 'Saudi Arabia',
    'USA', 'UK', 'Canada', 'Australia', 'Qatar', 'Kuwait',
    'Bahrain', 'Oman', 'Malaysia', 'Indonesia', 'Other'];
  final _educations = ['Open to all', 'High School', 'Diploma',
    "Bachelor's Degree", "Master's Degree", 'MBA', 'MBBS / MD',
    'PhD / Doctorate', 'Engineering', 'CA / Finance', 'Law', 'Other'];
  final _employments = ['Open to all', 'Private Sector', 'Government Sector',
    'Public Sector', 'Private & Public Sector', 'Self Employed',
    'Business Owner', 'Defence / Military', 'Not Working', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0.5,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: kDark, size: 20),
            onPressed: () => Navigator.pop(context)),
        title: const Text('Search Profiles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDark)),
        actions: [
          TextButton(onPressed: () {},
              child: const Text('Search Member ID',
                  style: TextStyle(color: kPink, fontWeight: FontWeight.w600))),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          _sec('Basic Details'),
          _card([
            _ageSlider(), _div(),
            _heightSlider(), _div(),
            _drop('Marital Status', Icons.favorite_border,
                _maritalStatus, _maritalStatuses,
                    (v) => setState(() => _maritalStatus = v)), _div(),
            _drop('Mother Tongue', Icons.translate,
                _motherTongue, _languages,
                    (v) => setState(() => _motherTongue = v)),
          ]),
          _sec('Community'),
          _card([
            _drop('Sect', Icons.nights_stay_outlined, _sect, _sects,
                    (v) => setState(() => _sect = v)), _div(),
            _drop('Caste', Icons.people_outline, _caste, _castes,
                    (v) => setState(() => _caste = v)),
          ]),
          _sec('Location'),
          _card([
            _drop('Country', Icons.public, _country, _countries,
                    (v) => setState(() => _country = v)), _div(),
            _drop('State', Icons.location_on_outlined, _state,
                ['Open to all', 'Delhi', 'Maharashtra', 'Karnataka',
                  'Tamil Nadu', 'Uttar Pradesh', 'West Bengal', 'Other'],
                    (v) => setState(() => _state = v)), _div(),
            _drop('City', Icons.location_city_outlined, _city,
                ['Open to all', 'New Delhi', 'Mumbai', 'Bangalore',
                  'Hyderabad', 'Chennai', 'Kolkata', 'Pune', 'Other'],
                    (v) => setState(() => _city = v)),
          ]),
          _sec('Education & Income'),
          _card([
            _drop('Education', Icons.school_outlined, _education,
                _educations, (v) => setState(() => _education = v)), _div(),
            _incomeSlider(), _div(),
            _drop('Employed In', Icons.work_outline, _employedIn,
                _employments, (v) => setState(() => _employedIn = v)),
          ]),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                  color: kPink, borderRadius: BorderRadius.circular(28),
                  boxShadow: [BoxShadow(
                      color: kPink.withOpacity(0.4), blurRadius: 16,
                      offset: const Offset(0, 6))]),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('Search Profiles', style: TextStyle(
                        color: Colors.white, fontSize: 17,
                        fontWeight: FontWeight.w700)),
                  ]),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _sec(String t) => Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Text(t, style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: kDark)));

  Widget _card(List<Widget> ch) => Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
              blurRadius: 10, offset: const Offset(0, 2))]),
      child: Column(children: ch));

  Widget _div() => Divider(height: 1, color: Colors.grey.shade100,
      indent: 16, endIndent: 16);

  Widget _drop(String label, IconData icon, String value,
      List<String> opts, Function(String) onChange) {
    return InkWell(
      onTap: () => _picker(label, opts, value, onChange),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Icon(icon, size: 20, color: Colors.grey.shade500),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(
                    fontSize: 12, color: Colors.grey.shade500)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600, color: kDark)),
              ])),
          Icon(Icons.keyboard_arrow_down,
              color: Colors.grey.shade400, size: 22),
        ]),
      ),
    );
  }

  void _picker(String title, List<String> opts, String cur,
      Function(String) onChange) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 12),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(title, style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold))),
        const SizedBox(height: 8),
        Flexible(child: ListView(shrinkWrap: true,
            children: opts.map((o) {
              final isSel = o == cur;
              return ListTile(
                title: Text(o, style: TextStyle(
                    fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                    color: isSel ? kPink : kDark)),
                trailing: isSel
                    ? const Icon(Icons.check, color: kPink) : null,
                onTap: () { onChange(o); Navigator.pop(ctx); },
              );
            }).toList())),
        const SizedBox(height: 16),
      ]),
    );
  }

  Widget _ageSlider() => Padding(padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Age', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Min ${_ageRange.start.round()} yrs',
              style: const TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w600, color: kDark)),
          Text('Max ${_ageRange.end.round()} yrs',
              style: const TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w600, color: kDark)),
        ]),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
              activeTrackColor: kPink, inactiveTrackColor: Colors.grey.shade200,
              thumbColor: kPink, overlayColor: kPink.withOpacity(0.1),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              trackHeight: 3),
          child: RangeSlider(
              values: _ageRange, min: 18, max: 60, divisions: 42,
              onChanged: (v) => setState(() => _ageRange = v)),
        ),
      ]));

  Widget _heightSlider() {
    final heights = ['Below 4ft 6in', '4ft 7in', '4ft 8in', '4ft 9in',
      '4ft 10in', '4ft 11in', '5ft', '5ft 1in', '5ft 2in', '5ft 3in',
      '5ft 4in', '5ft 5in', '5ft 6in', '5ft 7in', '5ft 8in', '5ft 9in',
      '5ft 10in', '5ft 11in', '6ft', '6ft 1in', 'Above 6ft 2in'];
    return Padding(padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Height',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Min ${heights[_heightRange.start.round()]}',
                style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w600, color: kDark)),
            Text('Max ${heights[_heightRange.end.round()]}',
                style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w600, color: kDark)),
          ]),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: kPink,
                inactiveTrackColor: Colors.grey.shade200,
                thumbColor: kPink, overlayColor: kPink.withOpacity(0.1),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                trackHeight: 3),
            child: RangeSlider(
                values: _heightRange, min: 0, max: 20, divisions: 20,
                onChanged: (v) => setState(() => _heightRange = v)),
          ),
        ]));
  }

  Widget _incomeSlider() {
    String fmt(double v) {
      if (v == 0) return 'No income';
      if (v >= 100) return '₹1 Crore+';
      return '₹${v.round()} Lakh';
    }

    return Padding(padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Annual Income',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Min ${fmt(_incomeRange.start)}',
                style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w600, color: kDark)),
            Text('Max ${fmt(_incomeRange.end)}',
                style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w600, color: kDark)),
          ]),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: kPink,
                inactiveTrackColor: Colors.grey.shade200,
                thumbColor: kPink, overlayColor: kPink.withOpacity(0.1),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                trackHeight: 3),
            child: RangeSlider(
                values: _incomeRange, min: 0, max: 100,
                onChanged: (v) => setState(() => _incomeRange = v)),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('🇮🇳  INR (₹)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            const Text('Change Currency',
                style: TextStyle(color: kPink, fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ]),
        ]));
  }
}

// ════════════════════════════════════════
// ACTIVITY + CHAT + PROFILE TABS
// ════════════════════════════════════════
class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0.5,
          title: const Text('Activity', style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: kDark))),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text('No recent activity',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade400)),
          ])),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  int _fi = 0;
  late AnimationController _ctrl;
  late Animation<double> _fade;
  final _filters = ['All', 'Unread', 'Requests'];

  final _interests = [
    {'name': 'Sahil', 'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop', 'accepted': false},
    {'name': 'Aryan', 'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&h=100&fit=crop', 'accepted': true},
    {'name': 'Zaid', 'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&h=100&fit=crop', 'accepted': false},
  ];

  final _chats = [
    {'name': 'Admin', 'message': '@testing xyz', 'time': 'Saturday', 'unread': 0, 'online': false, 'image': '', 'verified': false, 'isAdmin': true, 'pinned': true},
    {'name': 'Fatima Khan', 'message': 'AssalamuAlaikum! Would love to know more.', 'time': '2:45 PM', 'unread': 3, 'online': true, 'image': 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=100&h=100&fit=crop', 'verified': true, 'pinned': false},
    {'name': 'Zara Ahmed', 'message': 'JazakAllah khair 😊', 'time': '1:20 PM', 'unread': 0, 'online': true, 'image': 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=100&h=100&fit=crop', 'verified': false, 'pinned': false},
    {'name': 'Aisha Siddiqui', 'message': 'InshAllah, lets talk more.', 'time': 'Yesterday', 'unread': 1, 'online': false, 'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=100&h=100&fit=crop', 'verified': true, 'pinned': false},
    {'name': 'Mariam Raza', 'message': 'Thank you for your message!', 'time': 'Yesterday', 'unread': 0, 'online': false, 'image': 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=100&h=100&fit=crop', 'verified': false, 'pinned': false},
    {'name': 'Nisha Malik', 'message': 'Looking forward to hearing from you.', 'time': 'Mon', 'unread': 0, 'online': false, 'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop', 'verified': true, 'pinned': false},
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  List<Map<String, dynamic>> get _filtered {
    List<Map<String, dynamic>> r;
    switch (_fi) {
      case 1: r = _chats.where((c) => (c['unread'] as int) > 0).toList(); break;
      case 2: r = _chats.where((c) => c['isAdmin'] == true).toList(); break;
      default: r = List.from(_chats);
    }
    r.sort((a, b) {
      if (a['pinned'] == true && b['pinned'] != true) return -1;
      if (b['pinned'] == true && a['pinned'] != true) return 1;
      return 0;
    });
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: FadeTransition(opacity: _fade, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              color: Colors.white,
              child: const Text('Chats', style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: kDark))),
          Container(color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Text('Sent & Accepted Interests',
                          style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      const Text('See all', style: TextStyle(
                          fontSize: 13, color: kPink,
                          fontWeight: FontWeight.w600)),
                    ]),
                    const SizedBox(height: 12),
                    SizedBox(height: 78, child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _interests.length + 1,
                      itemBuilder: (_, i) {
                        if (i == 0) {
                          return Container(margin: const EdgeInsets.only(right: 14),
                              child: Column(children: [
                                Container(width: 52, height: 52,
                                    decoration: BoxDecoration(shape: BoxShape.circle,
                                        border: Border.all(color: kPink, width: 1.5)),
                                    child: const Icon(Icons.add, color: kPink, size: 22)),
                                const SizedBox(height: 4),
                                const Text('Explore', style: TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                              ]));
                        }
                        final item = _interests[i - 1];
                        return Container(margin: const EdgeInsets.only(right: 14),
                            child: Column(children: [
                              Stack(children: [
                                Container(width: 52, height: 52,
                                    decoration: BoxDecoration(shape: BoxShape.circle,
                                        border: Border.all(
                                            color: item['accepted'] as bool
                                                ? Colors.green : kPink,
                                            width: 2)),
                                    child: ClipOval(child: Image.network(
                                        item['image'] as String, fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            Container(color: Colors.grey.shade200,
                                                child: const Icon(Icons.person,
                                                    color: Colors.grey))))),
                                if (item['accepted'] as bool)
                                  Positioned(bottom: 0, right: 0,
                                      child: Container(width: 16, height: 16,
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle),
                                          child: const Icon(Icons.check,
                                              color: Colors.white, size: 10))),
                              ]),
                              const SizedBox(height: 4),
                              Text(item['name'] as String,
                                  style: const TextStyle(fontSize: 11)),
                            ]));
                      },
                    )),
                  ])),
          Container(color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: List.generate(_filters.length, (i) {
                    final isSel = _fi == i;
                    return GestureDetector(
                      onTap: () => setState(() => _fi = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                            color: isSel ? kDark : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(_filters[i], style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600,
                            color: isSel ? Colors.white : Colors.black87)),
                      ),
                    );
                  })))),
          Expanded(child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _filtered.length,
            itemBuilder: (_, i) => _ChatTile(
                chat: _filtered[i],
                delay: Duration(milliseconds: i * 50)),
          )),
        ])),
      ),
    );
  }
}

class _ChatTile extends StatefulWidget {
  final Map<String, dynamic> chat;
  final Duration delay;
  const _ChatTile({required this.chat, required this.delay});
  @override
  State<_ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<_ChatTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 350));
    _slide = Tween<Offset>(
        begin: const Offset(0.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut));
    _fade = Tween<double>(begin: 0, end: 1).animate(_c);
    Future.delayed(widget.delay, () { if (mounted) _c.forward(); });
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final chat = widget.chat;
    final isAdmin = chat['isAdmin'] == true;
    final isPinned = chat['pinned'] == true;
    final unread = chat['unread'] as int;
    return FadeTransition(opacity: _fade, child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: isPinned
                  ? Border.all(color: kPink.withOpacity(0.2)) : null,
              boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.03), blurRadius: 8,
                  offset: const Offset(0, 2))]),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 6),
            leading: Stack(children: [
              Container(width: 52, height: 52,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                      gradient: isAdmin
                          ? const LinearGradient(
                          colors: [kPink, Color(0xFFFF6BAD)])
                          : null,
                      color: isAdmin ? null : Colors.grey.shade100),
                  child: isAdmin
                      ? const Icon(Icons.favorite, color: Colors.white, size: 24)
                      : ClipOval(child: Image.network(chat['image'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.person, color: Colors.grey))))),
              if (chat['online'] == true)
                Positioned(bottom: 1, right: 1,
                    child: Container(width: 11, height: 11,
                        decoration: BoxDecoration(color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)))),
              if (isPinned)
                Positioned(top: 0, right: 0,
                    child: Container(width: 14, height: 14,
                        decoration: const BoxDecoration(
                            color: kPink, shape: BoxShape.circle),
                        child: const Icon(Icons.push_pin,
                            color: Colors.white, size: 8))),
            ]),
            title: Row(children: [
              Expanded(child: Text(chat['name'] as String,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15,
                      fontWeight: unread > 0
                          ? FontWeight.bold : FontWeight.w600,
                      color: kDark))),
              if (chat['verified'] == true)
                const Padding(padding: EdgeInsets.only(left: 3),
                    child: Icon(Icons.verified,
                        color: Color(0xFF4FC3F7), size: 14)),
            ]),
            subtitle: Padding(padding: const EdgeInsets.only(top: 3),
                child: Text(chat['message'] as String, maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13,
                        color: unread > 0
                            ? kDark.withOpacity(0.7)
                            : Colors.grey.shade400,
                        fontWeight: unread > 0
                            ? FontWeight.w500 : FontWeight.normal))),
            trailing: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(chat['time'] as String, style: TextStyle(
                  fontSize: 12,
                  color: unread > 0 ? kPink : Colors.grey.shade400,
                  fontWeight: unread > 0
                      ? FontWeight.w600 : FontWeight.normal)),
              const SizedBox(height: 5),
              if (unread > 0)
                Container(width: 20, height: 20,
                    decoration: const BoxDecoration(
                        color: kPink, shape: BoxShape.circle),
                    child: Center(child: Text('$unread',
                        style: const TextStyle(color: Colors.white,
                            fontSize: 11, fontWeight: FontWeight.bold)))),
            ]),
          ),
        )));
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _hCtrl, _mCtrl;
  late Animation<double> _hAnim, _mAnim;

  final _menu = [
    {'icon': Icons.edit_rounded, 'label': 'Edit Profile', 'sub': 'Update your photos and details', 'color': const Color(0xFF5B6EE8), 'bg': const Color(0xFFEEF0FD)},
    {'icon': Icons.shield_rounded, 'label': 'Profile Privacy', 'sub': 'Control who sees your profile', 'color': const Color(0xFF4CAF50), 'bg': const Color(0xFFE8F5E9)},
    {'icon': Icons.credit_card_rounded, 'label': 'Payment Info', 'sub': 'Manage your billing details', 'color': const Color(0xFFFF9800), 'bg': const Color(0xFFFFF3E0)},
    {'icon': Icons.workspace_premium_rounded, 'label': 'Explore Plans', 'sub': 'Upgrade for more features', 'color': kPink, 'bg': const Color(0xFFFFF0F7), 'hl': true},
    {'icon': Icons.block_rounded, 'label': 'Blocked Users', 'sub': 'Manage blocked profiles', 'color': const Color(0xFF9E9E9E), 'bg': const Color(0xFFF5F5F5)},
    {'icon': Icons.help_rounded, 'label': 'Help & Support', 'sub': 'Get help from our team', 'color': const Color(0xFF00BCD4), 'bg': const Color(0xFFE0F7FA)},
    {'icon': Icons.share_rounded, 'label': 'Share Nikah Forever App', 'sub': 'Invite friends & family', 'color': const Color(0xFF9C27B0), 'bg': const Color(0xFFF3E5F5)},
    {'icon': Icons.settings_rounded, 'label': 'Settings', 'sub': 'App preferences & account', 'color': const Color(0xFF607D8B), 'bg': const Color(0xFFECEFF1)},
  ];

  @override
  void initState() {
    super.initState();
    _hCtrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 700));
    _mCtrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 900));
    _hAnim = CurvedAnimation(parent: _hCtrl, curve: Curves.easeOutCubic);
    _mAnim = CurvedAnimation(parent: _mCtrl, curve: Curves.easeOutCubic);
    _hCtrl.forward();
    Future.delayed(const Duration(milliseconds: 250),
            () { if (mounted) _mCtrl.forward(); });
  }

  @override
  void dispose() { _hCtrl.dispose(); _mCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(floating: true, backgroundColor: Colors.white,
              elevation: 0.5,
              title: const Text('Profile', style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: kDark)),
              actions: [
                Container(margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: kPink.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Row(children: [
                      Icon(Icons.badge_outlined, color: kPink, size: 13),
                      SizedBox(width: 4),
                      Text('F1D232758518', style: TextStyle(
                          fontSize: 11, color: kPink,
                          fontWeight: FontWeight.w600)),
                    ])),
              ]),
          SliverToBoxAdapter(child: _profileCard()),
          SliverToBoxAdapter(child: _verifyBanner()),
          SliverToBoxAdapter(child: _menuSection()),
          SliverToBoxAdapter(child: _logoutBtn()),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  Widget _profileCard() => FadeTransition(opacity: _hAnim,
      child: SlideTransition(
          position: Tween<Offset>(
              begin: const Offset(0, -0.15), end: Offset.zero)
              .animate(_hAnim),
          child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16, offset: const Offset(0, 4))]),
              child: Column(children: [
                Stack(alignment: Alignment.center, children: [
                  Container(width: 88, height: 88,
                      decoration: const BoxDecoration(shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [kPink, Color(0xFFFF6BAD)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                      child: const Icon(Icons.person,
                          color: Colors.white, size: 44)),
                  Positioned(bottom: 0, right: 0,
                      child: Container(width: 26, height: 26,
                          decoration: BoxDecoration(color: kPink,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2)),
                          child: const Icon(Icons.camera_alt,
                              color: Colors.white, size: 13))),
                ]),
                const SizedBox(height: 14),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Rehan', style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: kDark)),
                  const SizedBox(width: 6),
                  const Icon(Icons.verified,
                      color: Color(0xFF4FC3F7), size: 21),
                  const SizedBox(width: 4),
                  Container(width: 21, height: 21,
                      decoration: const BoxDecoration(
                          color: kDark, shape: BoxShape.circle),
                      child: const Icon(Icons.star,
                          color: Colors.white, size: 12)),
                ]),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFFFFD700), Color(0xFFFFA000)]),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.workspace_premium,
                          color: Colors.white, size: 13),
                      SizedBox(width: 5),
                      Text('Assisted Service  •  Valid till May, 2060',
                          style: TextStyle(color: Colors.white,
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ])),
                const SizedBox(height: 16),
                _completion(),
              ]))));

  Widget _completion() => Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text('Profile Completion', style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
      const Text('78%', style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: kPink)),
    ]),
    const SizedBox(height: 8),
    ClipRRect(borderRadius: BorderRadius.circular(10),
        child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 0.78),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (_, val, __) => LinearProgressIndicator(
                value: val, minHeight: 8,
                backgroundColor: Colors.grey.shade100,
                valueColor: const AlwaysStoppedAnimation(kPink)))),
    const SizedBox(height: 5),
    const Text('Add a bio to reach 100%',
        style: TextStyle(fontSize: 11, color: Colors.grey)),
  ]);

  Widget _verifyBanner() => FadeTransition(opacity: _hAnim,
      child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)]),
              borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            Container(width: 42, height: 42,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: const Icon(Icons.verified_user,
                    color: Colors.white, size: 22)),
            const SizedBox(width: 12),
            const Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Build trust on your profile',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text('Complete selfie verification now',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ])),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 7),
                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('Verify', style: TextStyle(
                    color: Color(0xFF1565C0), fontWeight: FontWeight.bold,
                    fontSize: 13))),
          ])));

  Widget _menuSection() => Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.04), blurRadius: 12,
              offset: const Offset(0, 2))]),
      child: Column(children: List.generate(_menu.length, (i) {
        final item = _menu[i];
        final isLast = i == _menu.length - 1;
        final isHL = item['hl'] == true;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 350 + i * 55),
          curve: Curves.easeOutCubic,
          builder: (_, val, child) => Opacity(opacity: val,
              child: Transform.translate(
                  offset: Offset(20 * (1 - val), 0), child: child)),
          child: Column(children: [
            InkWell(onTap: () {}, borderRadius: BorderRadius.vertical(
                top: i == 0 ? const Radius.circular(24) : Radius.zero,
                bottom: isLast ? const Radius.circular(24) : Radius.zero),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 13),
                    color: isHL ? kPink.withOpacity(0.03) : Colors.transparent,
                    child: Row(children: [
                      Container(width: 42, height: 42,
                          decoration: BoxDecoration(
                              color: item['bg'] as Color,
                              borderRadius: BorderRadius.circular(13)),
                          child: Icon(item['icon'] as IconData,
                              color: item['color'] as Color, size: 22)),
                      const SizedBox(width: 14),
                      Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['label'] as String, style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600,
                                color: isHL ? kPink : kDark)),
                            Text(item['sub'] as String, style: const TextStyle(
                                fontSize: 12, color: Colors.grey, height: 1.3)),
                          ])),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 13, color: Colors.grey.shade300),
                    ]))),
            if (!isLast) Divider(height: 1, indent: 72,
                color: Colors.grey.shade100),
          ]),
        );
      })));

  Widget _logoutBtn() => Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              side: const BorderSide(color: Colors.red, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 20),
          label: const Text('Log Out', style: TextStyle(
              color: Colors.red, fontSize: 15,
              fontWeight: FontWeight.w600))));
}

// ════════════════════════════════════════
// SHARED WIDGETS
// ════════════════════════════════════════

// Interest button — same button toggles Send/Unsend with animation
class _InterestBtn extends StatefulWidget {
  final String name;
  final bool sent;
  final VoidCallback onToggle;
  const _InterestBtn({required this.name, required this.sent,
    required this.onToggle});

  @override
  State<_InterestBtn> createState() => _InterestBtnState();
}

class _InterestBtnState extends State<_InterestBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 500));
    _bounce = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7)
          .chain(CurveTween(curve: Curves.easeIn)), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.3)
          .chain(CurveTween(curve: Curves.easeOut)), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0)
          .chain(CurveTween(curve: Curves.elasticOut)), weight: 40),
    ]).animate(_c);
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  void _onTap() async {
    await _c.forward(from: 0);
    widget.onToggle();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(children: [
          Icon(widget.sent ? Icons.heart_broken : Icons.favorite,
              color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(widget.sent
              ? 'Interest unsent for ${widget.name}'
              : 'Interest sent to ${widget.name}! 💕'),
        ]),
        backgroundColor: widget.sent ? Colors.grey.shade700 : kPink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Column(children: [
        AnimatedBuilder(
          animation: _c,
          builder: (_, child) => Transform.scale(
              scale: _c.isAnimating ? _bounce.value : 1.0, child: child),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            width: 56, height: 56,
            decoration: BoxDecoration(
                color: widget.sent ? Colors.green : kPink,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                    color: (widget.sent ? Colors.green : kPink)
                        .withOpacity(0.45),
                    blurRadius: 12, spreadRadius: 2)]),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                  widget.sent ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(widget.sent),
                  color: Colors.white, size: 25),
            ),
          ),
        ),
        const SizedBox(height: 5),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
              color: widget.sent ? Colors.greenAccent : Colors.white,
              fontSize: 12, fontWeight: FontWeight.w500),
          child: Text(widget.sent ? 'Sent ✓' : 'Send Interest'),
        ),
      ]),
    );
  }
}

class _TapButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _TapButton({required this.icon, required this.label,
    required this.color, required this.onTap});

  @override
  State<_TapButton> createState() => _TapButtonState();
}

class _TapButtonState extends State<_TapButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 120),
        lowerBound: 0.88, upperBound: 1.0, value: 1.0);
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _c.reverse();
        await _c.forward();
        widget.onTap();
      },
      child: ScaleTransition(scale: _c, child: Column(children: [
        Container(width: 56, height: 56,
            decoration: BoxDecoration(color: widget.color,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                    color: widget.color.withOpacity(0.35), blurRadius: 10)]),
            child: Icon(widget.icon, color: Colors.white, size: 25)),
        const SizedBox(height: 5),
        Text(widget.label, style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
      ])),
    );
  }
}

class _SlideCard extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const _SlideCard({required this.child, required this.delay});

  @override
  State<_SlideCard> createState() => _SlideCardState();
}

class _SlideCardState extends State<_SlideCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 450));
    _slide = Tween<Offset>(
        begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));
    _fade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeIn));
    Future.delayed(widget.delay, () { if (mounted) _c.forward(); });
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child));
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 900))..repeat(reverse: true);
    _a = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) => Container(
          width: 9, height: 9,
          decoration: BoxDecoration(
              color: Colors.green.withOpacity(_a.value),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                  color: Colors.green.withOpacity(_a.value * 0.5),
                  blurRadius: 5, spreadRadius: 2)])),
    );
  }
}