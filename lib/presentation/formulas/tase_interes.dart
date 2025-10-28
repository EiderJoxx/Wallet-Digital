import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InterestRateInfoPage(),
    );
  }
}

class InterestRateInfoPage extends StatelessWidget {
  const InterestRateInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Información sobre Interés',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(176, 64, 34, 184),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: const Color.fromARGB(255, 12, 5, 206),
                    size: 32,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Wallet Digital',
                    style: TextStyle(
                      color: const Color(0xFF293431),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Qué es la Tasa de Interés?',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 13, 17, 17),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'La tasa de interés es el precio que se paga por el uso del dinero. Se expresa como un porcentaje y se aplica al capital inicial (el monto del préstamo o inversión) durante un periodo de tiempo. ',
                    style: TextStyle(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Componentes de la tasa de interés',
                    style: TextStyle(
                      color: const Color(0xFF151616),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    """La tasa de interés se compone de varios factores:
• Interés real: Es la rentabilidad básica que espera el prestamista por ceder su dinero. Refleja el costo de oportunidad.
• Inflación esperada: Protección contra la pérdida de valor del dinero en el tiempo. Si se espera inflación alta, la tasa sube.
• Prima de riesgo: Adicional que se cobra según la probabilidad de que el deudor no pague. Depende del historial crediticio y contexto.
• Liquidez: Si el dinero es difícil de recuperar rápidamente, se cobra una prima adicional.
• Plazo: A mayor plazo, mayor incertidumbre, por lo que la tasa suele ser más alta.

Estos componentes juntos determinan la tasa de interés final que se aplica a un préstamo o inversión.""",

                    style: TextStyle(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Formula de la Tasa de Interés',
                    style: TextStyle(
                      color: const Color(0xFF151616),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tasa de interés = Interés real + Inflación esperada + Prima de riesgo + Prima por liquidez',
                    style: TextStyle(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
