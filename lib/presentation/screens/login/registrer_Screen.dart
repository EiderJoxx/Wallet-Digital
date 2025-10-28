import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _documentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _documentController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    // Primero, valida que los términos y condiciones sean aceptados
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Debes aceptar los términos y condiciones para continuar.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Luego, valida el formulario
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final prefs = await SharedPreferences.getInstance();
        final usersJson = prefs.getString('users') ?? '[]';
        List<dynamic> users = jsonDecode(usersJson);

        bool documentExists = users.any(
          (user) => user['document'] == _documentController.text,
        );

        if (documentExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Este documento ya se encuentra registrado.'),
              backgroundColor: Colors.red,
            ),
          );
          return; // Detiene la ejecución si el documento ya existe
        }

        final newUser = {
          'name': _nameController.text,
          'lastName': _lastNameController.text,
          'email': _emailController.text,
          'document': _documentController.text,
          'phone': _phoneController.text,
          'password': _passwordController.text,
        };

        users.add(newUser);
        await prefs.setString('users', jsonEncode(users));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              '¡Registro exitoso! Ahora puedes iniciar sesión.',
            ),
            backgroundColor: Colors.green[600],
          ),
        );

        // Espera un momento y regresa a la pantalla de login
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ocurrió un error inesperado: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Fondo negro profundo
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF00FF00), // Ícono de flecha en verde neón
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Crea tu cuenta',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00FF00), // Título en verde neón
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Únete a Dallet Digital para empezar a gestionar tus finanzas.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[400], // Texto secundario en gris claro
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Formulario de Registro ---
                  _buildTextFormField(
                    context: context,
                    controller: _nameController,
                    labelText: 'Nombre',
                    icon: Icons.person_outline,
                    validator:
                        (value) => value!.isEmpty ? 'Ingresa tu nombre' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    context: context,
                    controller: _lastNameController,
                    labelText: 'Apellido',
                    icon: Icons.person_outline,
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Ingresa tu apellido' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    context: context,
                    controller: _documentController,
                    labelText: 'Documento de Identidad',
                    icon: Icons.badge_outlined,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Ingresa tu documento';
                      if (value.length < 6) return 'Documento muy corto';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    context: context,
                    controller: _emailController,
                    labelText: 'Correo Electrónico',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Ingresa tu correo';
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Ingresa un correo válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    context: context,
                    controller: _passwordController,
                    labelText: 'Contraseña',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onVisibilityToggle:
                        () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Ingresa una contraseña';
                      if (value.length < 8) return 'Mínimo 8 caracteres';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    context: context,
                    controller: _confirmPasswordController,
                    labelText: 'Confirmar Contraseña',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    obscureText: _obscureConfirmPassword,
                    onVisibilityToggle:
                        () => setState(
                          () =>
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword,
                        ),
                    validator: (value) {
                      if (value != _passwordController.text)
                        return 'Las contraseñas no coinciden';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // --- Términos y Condiciones ---
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged:
                            (value) =>
                                setState(() => _acceptTerms = value ?? false),
                        activeColor: theme.colorScheme.primary,
                        checkColor:
                            theme.colorScheme.surface, // Checkmark en negro
                      ),
                      Expanded(
                        child: Text(
                          'Acepto los Términos y Condiciones',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white, // Texto en blanco
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Botón de Registro ---
                    ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF00FF00), // Verde neón
                      foregroundColor:
                          const Color(0xFF1A1A1A), // Texto en negro
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        _isLoading
                            ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color:
                                    theme
                                        .colorScheme
                                        .surface, // Color del indicador de carga
                                strokeWidth: 3,
                              ),
                            )
                            : const Text(
                              'Crear Cuenta',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                  const SizedBox(height: 24),

                  // --- Volver a Iniciar Sesión ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes una cuenta?',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ), // Texto en gris claro
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Inicia Sesión',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                theme
                                    .colorScheme
                                    .primary, // Texto del botón con color primario
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
    );
  }

  // Widget reutilizable para los campos de texto
  Widget _buildTextFormField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? Function(String?)? validator,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onVisibilityToggle,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(
        color: Colors.white,
      ), // Texto que escribe el usuario
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white), // Etiqueta en blanco
          prefixIcon: Icon(
          icon,
          color: const Color(0xFF00FF00),
        ), // Ícono de prefijo en verde neón
        filled: true,
        fillColor: const Color(0xFF2D2D2D), // Fondo del campo en gris oscuro
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
                    focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFF00FF00),
            width: 2,
          ), // Borde enfocado en verde neón
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white, // Ícono de visibilidad en blanco
                  ),
                  onPressed: onVisibilityToggle,
                )
                : null,
      ),
    );
  }
}
