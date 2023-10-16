import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imcnew/page/calcular_imc_page.dart';
import 'package:imcnew/widgets/app_images.dart';
import 'package:imcnew/widgets/custom_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "O IMC (índice de massa corporal) é um cálculo \n que serve para avaliar se a pessoa está \n dentro do seu peso ideal.",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  wordSpacing: BorderSide.strokeAlignOutside,
                ),
              ),
            ]),
          ),
          Image.asset(AppImages.logo),
          const SizedBox(height: 80),
          InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CalcularImcPage()));
                  },
                  child: const Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    color: Color.fromRGBO(111, 185, 219, 0.808),
                    shadowColor: Color.fromARGB(200, 250, 250, 123),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 35),
                      ),
                    ),
                  ))
              .animate(
                onPlay: (c) => c.repeat(),
              )
              .shimmer(delay: 3000.ms, duration: 1000.ms),
        ],
      ),
    ));
  }
}
