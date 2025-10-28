import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:simple_animations/simple_animations.dart';
import 'package:testapp/presentation/screens/home/home_screen.dart';
import 'package:testapp/presentation/screens/login/registrer_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos el nuevo tema
    final newTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Negro profundo
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00FF00), // Verde neón
        primary: const Color(0xFF00FF00),
        background: const Color(0xFF1A1A1A),
        brightness: Brightness.dark,
      ),
      // Usamos Google Fonts para una tipografía más profesional
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2D2D2D), // Gris oscuro
        labelStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: newTheme,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _documentController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showDocumentError = false;
  bool _showPasswordError = false;
  bool _showInvalidCredentialsError = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _documentController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() async {
    setState(() {
      _showDocumentError = _documentController.text.isEmpty;
      _showPasswordError = _passwordController.text.isEmpty;
      _showInvalidCredentialsError = false;
    });

    if (_showDocumentError || _showPasswordError) return;

    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '[]';
    final List<dynamic> users = jsonDecode(usersJson);

    var userFound = users.firstWhere(
      (user) =>
          user['document'] == _documentController.text &&
          user['password'] == _passwordController.text,
      orElse: () => null,
    );

    if (userFound != null) {
      // Inicio de sesión exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Bienvenido de vuelta, ${userFound['name']}!'),
          backgroundColor: Colors.green[600],
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Credenciales inválidas
      setState(() {
        _showInvalidCredentialsError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo animado de la aplicación
          const BankingAnimationBackground(),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- Nuevo Logo de Dallet Digital ---
                      Column(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 60,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.headlineLarge,
                              children: [
                                TextSpan(
                                  text: 'Wallet',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Digital',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tu cartera, a tu manera.',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // --- Mensaje de error de credenciales ---
                      if (_showInvalidCredentialsError)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.red.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            'Documento o contraseña incorrectos. Inténtalo de nuevo.',
                            style: TextStyle(color: Colors.red[200]),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // --- Campo de Documento ---
                      TextField(
                        controller: _documentController,
                        decoration: InputDecoration(
                          labelText: 'Documento de Identificación',
                          prefixIcon: const Icon(
                            Icons.badge_outlined,
                            color: Color(0xFF00FF00),
                          ),
                          errorText:
                              _showDocumentError
                                  ? 'Este campo es obligatorio'
                                  : null,
                          labelStyle: TextStyle(color: Colors.grey[300]),
                          filled: true,
                          fillColor: const Color(0xFF2A1C3E),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 20),

                      // --- Campo de Contraseña ---
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(
                            Icons.vpn_key_outlined,
                            color: Color(0xFF00FF00),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xFF00FF00),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          errorText:
                              _showPasswordError
                                  ? 'Este campo es obligatorio'
                                  : null,
                          labelStyle: TextStyle(color: Colors.grey[300]),
                          filled: true,
                          fillColor: const Color(0xFF2A1C3E),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),

                      // --- Botón de Olvidé mi contraseña ---
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // --- Botón de Iniciar Sesión con degradado ---
                      InkWell(
                        onTap: _validateAndSubmit,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00FF00),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Text(
                            'Iniciar Sesión',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D0B2E),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // --- Enlace de Registro ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '¿No tienes una cuenta?',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Regístrate ahora',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
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
}

class BankingAnimationBackground extends StatelessWidget {
  const BankingAnimationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
          ),
        ),
        // Patrón de líneas minimalista
        const MinimalisticLinesAnimation(),
      ],
    );
  }
}

// --- Nuevas clases de animación de fondo ---

class MinimalisticLinesAnimation extends StatelessWidget {
  const MinimalisticLinesAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 10),
        builder: (context, value, child) {
          return CustomPaint(
            painter: MinimalisticLinesPainter(
              animation: value,
              lineColor: const Color(0xFF00FF00).withOpacity(0.15),
            ),
          );
        },
      ),
    );
  }
}

class MinimalisticLinesPainter extends CustomPainter {
  final double animation;
  final Color lineColor;

  MinimalisticLinesPainter({
    required this.animation,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Dibuja líneas horizontales que se mueven suavemente
    for (int i = 0; i < 5; i++) {
      final y = (size.height / 6) * (i + 1) + (math.sin(animation * math.pi * 2 + i) * 10);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Dibuja líneas verticales que se mueven suavemente
    for (int i = 0; i < 7; i++) {
      final x = (size.width / 8) * (i + 1) + (math.cos(animation * math.pi * 2 + i) * 10);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(MinimalisticLinesPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
