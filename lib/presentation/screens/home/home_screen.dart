import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:testapp/presentation/formulas/simple_interest_screen.dart';
import 'package:testapp/presentation/formulas/compound_interest.dart';
import 'package:testapp/presentation/formulas/annuity_screen.dart';
import 'package:testapp/presentation/formulas/tase_interes.dart';
import 'package:testapp/presentation/screens/home/settings_screen.dart';
import 'package:testapp/presentation/formulas/gradient_arithmetic_screen.dart';
import 'package:testapp/presentation/formulas/amortizacion_screen.dart';
import 'package:testapp/presentation/formulas/Internal_Rate_Return_screen.dart';
import 'package:testapp/presentation/formulas/Capitalization_System_Screen.dart';

// Estilos globales pedidos por el usuario
const TextStyle kTextStyleAzulMedio = TextStyle(
  color: Color(0xFF3B4F5C), // Azul acero
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

const TextStyle kTextStyleRojoSuave = TextStyle(
  color: Color(0xFFA14D4D), // Rojo ladrillo
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

const TextStyle kTextStyleVerdeGrisaceo = TextStyle(
  color: Color(0xFF4F6F64), // Verde musgo apagado
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

const TextStyle kTextStyleAmarilloCalido = TextStyle(
  color: Color(0xFFD9A441), // Mostaza suave
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

const TextStyle kTextStyleGrisClaro = TextStyle(
  color: Color(0xFFE0E0E0), // Gris humo
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _showFinancialOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00FF00).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FF00),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                      'Calculos Financieros',
                      style: kTextStyleAzulMedio.copyWith(fontSize: 20, letterSpacing: 0.2),
                    ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildFinancialOption(
                        icon: Icons.info_outline,
                        title: 'Tasa de Interés',
                        description:
                            'Conoce los conceptos y componentes de la tasa de interés.',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const InterestRateInfoPage(),
                            ),
                          );
                        },
                      ),
                      _buildFinancialOption(
                        icon: Icons.trending_up,
                        title: 'Interés Simple',
                        description:
                            'Calcula el crecimiento lineal de tu inversión.',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const SimpleInterestScreen(),
                            ),
                          );
                        },
                      ),
                      _buildFinancialOption(
                        icon: Icons.timeline,
                        title: 'Interés Compuesto',
                        description:
                            'Visualiza el efecto de la capitalización.',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const CompoundInterestScreen(),
                            ),
                          );
                        },
                      ),
                      _buildFinancialOption(
                        icon: Icons.payments,
                        title: 'Anualidades',
                        description:
                            'Determina pagos fijos en intervalos regulares.',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnnuityScreen(),
                            ),
                          );
                        },
                      ),
                        _buildFinancialOption(
                        icon: Icons.info_outline,
                        title: 'iteral rate retur',
                        description:
                            'TIR.',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const IRRCalculator(),
                            ),
                          );
                        },
                      ),
                      _buildFinancialOption(
                        icon: Icons.info_outline,
                        title: 'Amoritización',
                        description:
                            'Sistema de capitalización.',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const AmortizationCalculator(),
                            ),
                          );
                        },
                      ),
                       _buildFinancialOption(
                        icon: Icons.info_outline,
                        title: 'Capitalization_System_Screen',
                        description:
                            'Capitalization_System_Screen.',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const CapitalizationSystem(),
                            ),
                          );
                        },
                      ),
                      
                       _buildFinancialOption(
                         icon: Icons.account_balance,
                         title: 'Gradiente Aritmético',
                         description:
                             'Analiza series de flujos de efectivo en progresión.',
                         onTap: () {
                           Navigator.pop(context);
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder:
                                   (context) => const ArithmeticGradientScreen(),
                             ),
                           );
                         },
                       ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildFinancialOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF39C12).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFFF39C12)),
        ),
        title: Text(
          title,
          style: kTextStyleAzulMedio.copyWith(fontSize: 15),
        ),
        subtitle: Text(
          description,
          style: kTextStyleVerdeGrisaceo.copyWith(fontSize: 13.5, color: Colors.grey[700]),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFFF39C12),
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(107, 177, 216, 255),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF34495E),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bienvenido',
                            style: TextStyle(
                              color: const Color(0xFF34495E).withOpacity(0.9),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Prueba Usuario',
                            style: TextStyle(
                              color: const Color(0xFF0B3D91),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.settings),
                  //   color: const Color(0xFF2C3E50),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const SettingsScreen(),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color.fromARGB(255, 255, 255, 255),
                              const Color.fromARGB(255, 88, 112, 189),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Balance Total',
                              style: TextStyle(
                                color: Color.fromARGB(179, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  '\$',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 10, 10, 10),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'Saldo En Proceso',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 20, 20, 20),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.refresh),
                                  color: Colors.white,
                                  onPressed: () {},
                                  tooltip: 'Actualizar balance',
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 100,
                              child: LineChart(
                                LineChartData(
                                  gridData: FlGridData(show: false),
                                  titlesData: FlTitlesData(show: false),
                                  borderData: FlBorderData(show: false),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: [
                                        FlSpot(0, 3),
                                        FlSpot(2.6, 2),
                                        FlSpot(4.9, 5),
                                        FlSpot(6.8, 3.1),
                                        FlSpot(8, 4),
                                        FlSpot(9.5, 3),
                                        FlSpot(11, 4),
                                      ],
                                      isCurved: true,
                                      color: const Color(0xFFF39C12),
                                      barWidth: 3,
                                      isStrokeCapRound: true,
                                      dotData: FlDotData(show: false),
                                      belowBarData: BarAreaData(
                                        show: true,
                                          color: const Color(0xFF2E86AB).withOpacity(0.12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            if (index == 1) {
              _showFinancialOptionsMenu(context);
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF0B3D91),
          unselectedItemColor: Colors.grey.shade600,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Acciones',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'proximo'),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
              icon: Icon(icon),
              color: color,
              iconSize: 30,
              onPressed: onPressed,
            ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: kTextStyleAzulMedio.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}
