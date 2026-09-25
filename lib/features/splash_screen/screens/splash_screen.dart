import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  String _statusText = 'Syncing multiverses...';
  bool _isReady = false;

  final List<Map<String, dynamic>> _checkpoints = [
    {'progress': 0.28, 'label': 'Indexing lore vaults...'},
    {'progress': 0.64, 'label': 'Calibrating trivia matrix...'},
    {'progress': 0.92, 'label': 'Establishing community link...'},
    {'progress': 1.0, 'label': 'Omniverse Ready'},
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {
          for (var i = _checkpoints.length - 1; i >= 0; i--) {
            if (_progressAnimation.value >= _checkpoints[i]['progress']) {
              _statusText = _checkpoints[i]['label'];
              if (i == _checkpoints.length - 1) {
                _isReady = true;
              }
              break;
            }
          }
        });
      });

    _progressController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: MediaQuery.of(context).size.width / 2 - 240,
            child: Container(
              width: 480,
              height: 480,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(0, 245, 212, 0.12),
                    Colors.transparent
                  ],
                  stops: [0.0, 0.7],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: MediaQuery.of(context).size.width / 2 - 260,
            child: Container(
              width: 520,
              height: 520,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(109, 17, 173, 0.18),
                    Colors.transparent
                  ],
                  stops: [0.0, 0.7],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _StarfieldPainter(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 232,
                        height: 232,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 220,
                              height: 220,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(109, 17, 173, 0.3),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 245, 212, 0.2),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            RotationTransition(
                              turns: _rotationController,
                              child: CustomPaint(
                                size: const Size(232, 232),
                                painter: _OrbitRingPainter(),
                              ),
                            ),
                            Container(
                              width: 176,
                              height: 176,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF191C22).withOpacity(0.7),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 245, 212, 0.35),
                                    blurRadius: 35,
                                    spreadRadius: -5,
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF0B0E14),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      'assets/images/logo.png',
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Color.fromRGBO(11, 14, 20, 0.4),
                                            Colors.transparent,
                                            Color.fromRGBO(0, 245, 212, 0.1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 1,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Color(0xFF00F5D4)],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'POCKET EDITION',
                              style: TextStyle(
                                color: Color(0xFF26FEDC),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 1,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF00F5D4), Colors.transparent],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'FANDOM',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE1E2EB),
                              letterSpacing: -0.02 * 38,
                            ),
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF00F5D4), Color(0xFFE0B6FF)],
                            ).createShader(bounds),
                            child: const Text(
                              'VERSE',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.02 * 38,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Fandom Trivia & Media on the Go',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFB9CAC4),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: 4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF32353C).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: _progressAnimation.value,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6D11AD),
                                    Color(0xFF00F5D4),
                                    Color(0xFF26FEDC),
                                  ],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFF00F5D4),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF26FEDC),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _statusText,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFE1E2EB),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'v1.0.0-POCKET',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: Color(0xFFB9CAC4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _isReady
                              ? const Color(0xFF00F5D4)
                              : const Color(0xFF272A31).withOpacity(0.8),
                          boxShadow: _isReady
                              ? [
                                  const BoxShadow(
                                    color: Color.fromRGBO(0, 245, 212, 0.5),
                                    blurRadius: 20,
                                  )
                                ]
                              : [],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: _isReady ? () {} : null,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isReady ? 'ENTER OMNIVERSE' : 'INITIALIZING HUB',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      color: _isReady
                                          ? const Color(0xFF00201A)
                                          : const Color(0xFFE1E2EB),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color: _isReady
                                        ? const Color(0xFF00201A)
                                        : const Color(0xFF00F5D4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  final Random _random = Random(42);
  final int _starCount = 48;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _starCount; i++) {
      final x = _random.nextDouble() * size.width;
      final y = _random.nextDouble() * size.height;
      final radius = _random.nextDouble() * 1.4 + 0.3;
      final isCyan = _random.nextDouble() > 0.4;
      final alpha = _random.nextDouble() * 0.5 + 0.2;

      final paint = Paint()
        ..color = (isCyan ? const Color(0xFF00F5D4) : const Color(0xFFE0B6FF))
            .withOpacity(alpha)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OrbitRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final Paint outerPaint = Paint()
      ..color = const Color(0xFF00F5D4).withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint innerPaint = Paint()
      ..color = const Color(0xFFE0B6FF).withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    _drawDashedCircle(canvas, center, 100, outerPaint, [14, 22, 4, 18]);
    _drawDashedCircle(canvas, center, 90, innerPaint, [6, 14]);
  }

  void _drawDashedCircle(
      Canvas canvas, Offset center, double radius, Paint paint, List<double> dashArray) {
    double circumference = 2 * pi * radius;
    double dashTotal = dashArray.reduce((a, b) => a + b);
    int dashCount = (circumference / dashTotal).ceil();

    canvas.save();
    canvas.translate(center.dx, center.dy);

    double currentAngle = 0;
    for (int i = 0; i < dashCount; i++) {
      for (int j = 0; j < dashArray.length; j++) {
        double sweepAngle = (dashArray[j] / circumference) * 2 * pi;
        if (j % 2 == 0) {
          canvas.drawArc(
            Rect.fromCircle(center: Offset.zero, radius: radius),
            currentAngle,
            sweepAngle,
            false,
            paint,
          );
        }
        currentAngle += sweepAngle;
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}