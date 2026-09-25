import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  // Colors from Tailwind config
  final Color surfaceBase = const Color(0xFF0B0E14);
  final Color surfaceCard = const Color(0xFF1A2232);
  final Color surfaceContainerLow = const Color(0xFF191C22);
  final Color primary = const Color(0xFFD0BCFF);
  final Color primaryContainer = const Color(0xFFA078FF);
  final Color secondaryContainer = const Color(0xFF00F2D1);
  final Color secondaryFixed = const Color(0xFF26FEDC);
  final Color tertiary = const Color(0xFF4CD7F6);
  final Color tertiaryFixed = const Color(0xFFACEDFF);
  final Color textPrimary = const Color(0xFFF9FAFB);
  final Color textSecondary = const Color(0xFF94A3B8);
  final Color accentWarning = const Color(0xFFF59E0B);
  final Color outlineVariant = const Color(0xFF494454);

  // Button States for interactions (mimicking the JS snippet)
  int _fanLaunchState = 0; // 0: default, 1: connecting, 2: warping
  bool _adminDecrypting = false;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleFanLaunch() async {
    if (_fanLaunchState != 0) return;
    setState(() => _fanLaunchState = 1);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _fanLaunchState = 2);
    await Future.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;
    setState(() => _fanLaunchState = 0);
  }

  void _handleAdminAccess() async {
    if (_adminDecrypting) return;
    setState(() => _adminDecrypting = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _adminDecrypting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surfaceBase,
      body: Stack(
        children: [
          // Background ambient glows
          Positioned(
            top: -100,
            left: MediaQuery.of(context).size.width / 2 - 160,
            child: _buildGlowOrb(primaryContainer.withOpacity(0.15), 320),
          ),
          Positioned(
            top: 250,
            right: -80,
            child: _buildGlowOrb(secondaryContainer.withOpacity(0.1), 256),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: -100,
            child: _buildGlowOrb(tertiary.withOpacity(0.1), 240),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildFanCard(),
                  const SizedBox(height: 16),
                  _buildAdminCard(),
                  const SizedBox(height: 32),
                  _buildQuickTeleport(),
                  const SizedBox(height: 48),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowOrb(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 100,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Version Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: surfaceCard,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _pulseController,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: secondaryContainer,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: secondaryContainer.withOpacity(0.8), blurRadius: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'POCKET EDITION v1.0',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Glowing Avatar Container
        SizedBox(
          width: 176,
          height: 176,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow
              FadeTransition(
                opacity: _pulseController,
                child: Container(
                  width: 168,
                  height: 168,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        primaryContainer.withOpacity(0.4),
                        secondaryContainer.withOpacity(0.3),
                        tertiary.withOpacity(0.2),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(color: primaryContainer.withOpacity(0.4), blurRadius: 24)
                    ],
                  ),
                ),
              ),
              // Inner Image frame
              Container(
                width: 160,
                height: 160,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primary, surfaceCard, secondaryContainer],
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 20,
                child: Icon(Icons.arrow_back_ios_new, size: 14, color: secondaryFixed),
              ),
              Positioned(
                bottom: 20,
                left: 15,
                child: Icon(Icons.auto_awesome, size: 16, color: primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Title
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, letterSpacing: -0.5),
            children: [
              TextSpan(text: 'FANDOM ', style: TextStyle(color: textPrimary)),
              TextSpan(text: 'VERSE', style: TextStyle(color: tertiary)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your Gateway to Anime, Gaming, Sci-Fi & Pop-Culture Realms',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: textSecondary, height: 1.4),
        ),
        const SizedBox(height: 24),

        // Status Meter
        Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: surfaceCard,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FadeTransition(
                    opacity: _pulseController,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: secondaryFixed, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('48.2k Fans Online', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textPrimary)),
                ],
              ),
              Container(width: 1, height: 12, color: outlineVariant.withOpacity(0.6)),
              Row(
                children: [
                  Icon(Icons.local_fire_department, size: 16, color: accentWarning),
                  const SizedBox(width: 4),
                  Text('14 Live Con Events', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: accentWarning)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFanCard() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                gradient: LinearGradient(
                  colors: [primary, tertiary, secondaryContainer],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF272A31),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: secondaryContainer.withOpacity(0.25), blurRadius: 14)
                        ],
                      ),
                      child: Icon(Icons.sports_esports, color: secondaryContainer, size: 28),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: secondaryContainer.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'POPULAR CHOICE',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: secondaryContainer, letterSpacing: 1.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Enter as Fan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textPrimary)),
                const SizedBox(height: 4),
                Text(
                  'Explore boundless canon lore, secure rare con badges, raid exclusive merch vaults & consult the VerseBot oracle.',
                  style: TextStyle(fontSize: 12, color: textSecondary, height: 1.4),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _handleFanLaunch,
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [primaryContainer, primary, secondaryContainer],
                      ),
                      boxShadow: [
                        BoxShadow(color: primaryContainer.withOpacity(0.45), blurRadius: 20, offset: const Offset(0, -2))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_fanLaunchState == 1)
                          const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        else if (_fanLaunchState == 2)
                          Icon(Icons.check_circle, size: 18, color: secondaryContainer)
                        else
                          const SizedBox(),
                        const SizedBox(width: 8),
                        Text(
                          _fanLaunchState == 1
                              ? 'CONNECTING REALMS...'
                              : _fanLaunchState == 2
                                  ? 'WARPING TO HUB'
                                  : 'LAUNCH FAN HUB',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF340080)),
                        ),
                        if (_fanLaunchState == 0) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 18, color: Color(0xFF340080)),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCard() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: surfaceCard,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.terminal, color: primary, size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: surfaceCard,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.shield, size: 12, color: accentWarning),
                    const SizedBox(width: 4),
                    const Text(
                      'RESTRICTED',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFCBC3D7)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Admin & Moderator Console', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textPrimary)),
          const SizedBox(height: 4),
          Text(
            'Direct universe canons, supervise live con radar coordinates, manage rare inventory drops, and audit moderation logs.',
            style: TextStyle(fontSize: 12, color: textSecondary, height: 1.4),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _handleAdminAccess,
            borderRadius: BorderRadius.circular(8),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _adminDecrypting ? 0.75 : 1.0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: surfaceCard,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_adminDecrypting)
                      const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Color(0xFF4CD7F6), strokeWidth: 2))
                    else
                      Icon(Icons.key, size: 16, color: tertiaryFixed),
                    const SizedBox(width: 8),
                    Text(
                      _adminDecrypting ? 'Decrypting Credentials...' : 'Access Console Demo',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: tertiaryFixed),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTeleport() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DIRECT TRANSMISSIONS',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: textSecondary),
              ),
              Row(
                children: [
                  Text('Explore Matrix', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: tertiary)),
                  Icon(Icons.chevron_right, size: 14, color: tertiary),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPill(Icons.menu_book, secondaryContainer, 'Lore Wiki'),
              _buildPill(Icons.radar, accentWarning, 'Convention Radar'),
              _buildPill(Icons.shopping_bag, tertiary, 'Merch Vault'),
              _buildPill(Icons.smart_toy, primary, 'AI LoreBot'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPill(IconData icon, Color iconColor, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: surfaceCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textPrimary)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Protocol Terms', style: TextStyle(fontSize: 10, color: textSecondary)),
            const SizedBox(width: 16),
            Container(width: 4, height: 4, decoration: BoxDecoration(color: outlineVariant, shape: BoxShape.circle)),
            const SizedBox(width: 16),
            Text('Quantum Privacy', style: TextStyle(fontSize: 10, color: textSecondary)),
            const SizedBox(width: 16),
            Container(width: 4, height: 4, decoration: BoxDecoration(color: outlineVariant, shape: BoxShape.circle)),
            const SizedBox(width: 16),
            Text('Node Status', style: TextStyle(fontSize: 10, color: textSecondary)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Powered by TechWiz 7 Neural Engine • Neo-Tokyo Server Cluster 09',
          style: TextStyle(fontSize: 11, color: outlineVariant),
        ),
      ],
    );
  }
}