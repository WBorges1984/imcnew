import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imcnew/model/imc_class.dart';
import 'package:imcnew/model/imc_sqlite_model.dart';
import 'package:imcnew/page/card_imc_page.dart';
import 'package:imcnew/repositories/imc_sqlite_repository.dart';
import 'package:imcnew/widgets/app_images.dart';
import 'package:imcnew/widgets/text_label.dart';

class CalcularImcPage extends StatefulWidget {
  const CalcularImcPage({super.key});
  @override
  State<CalcularImcPage> createState() => _CalcularImcPageState();
}

class _CalcularImcPageState extends State<CalcularImcPage> {
  TextEditingController pesoController = TextEditingController(text: "");
  TextEditingController alturaController = TextEditingController(text: "");
  final imcRepository = ImcQLiteRepository();
  List<ImcSQLiteModel> data = [];
  String resulClasificacao = '';
  double resultImc = 0;
  String resultImage = '';
  int tituloList = 0;
  CardImc ImcCard = CardImc();

  void criarCalculoImc() {
    String altura = alturaController.text;
    String peso = pesoController.text;
    CalcularImcClass CalcularImc = CalcularImcClass(double.parse(altura),
        double.parse(peso), resultImage, resultImage, resultImc);

    debugPrint(CalcularImc.getAltura.toString());
    debugPrint(CalcularImc.getPeso.toString());
    resultImc =
        CalcularImc.calcularIMC(double.parse(altura), double.parse(peso));
    resulClasificacao = CalcularImc.getSaude;
    resultImage = CalcularImc.getImage;

    debugPrint(resultImc.toString());
    debugPrint(CalcularImc.getSaude);
    tituloList = tituloList + 1;
    ImcCard.createState().addChild("oi");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
    fetchDataAndUpdateState();
  }

  carregarDados() async {
    Future<void> fetchDataAndUpdateState() async {
      final data = await imcRepository.obterDados();
      setState(() {
        this.data = data;
      });
    }
  }

  Future<void> fetchDataAndUpdateState() async {
    final data = await imcRepository.obterDados();
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const TextLabel(texto: "Calcular IMC")
                .animate()
                .fade(duration: 500.ms)
                .scale(delay: 500.ms)
                .move(delay: 300.ms, duration: 600.ms)),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
          child: Column(
            children: [
              const TextLabel(texto: "Peso:"),
              TextField(
                keyboardType: TextInputType.number,
                controller: pesoController,
              ),
              const SizedBox(
                height: 10,
              ),
              const TextLabel(texto: "Altura:"),
              TextField(
                keyboardType: TextInputType.number,
                controller: alturaController,
              ),
              ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(10)),
                      onPressed: () {
                        showModalBottomSheet(
                            elevation: 8,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            context: context,
                            builder: (BuildContext bc) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(height: 15),
                                  Text("Seu IMC é de: $resultImc",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 15),
                                  resultImage == "MagrezaGrave"
                                      ? Image.asset(AppImages.magrezaGrave,
                                          height: 50)
                                      : resultImage == "MagrezaModerada"
                                          ? Image.asset(
                                              AppImages.magrezaModerada,
                                              height: 80)
                                          : resultImage == "MagrezaLeve"
                                              ? Image.asset(
                                                  AppImages.magrezaLeve,
                                                  height: 80)
                                              : resultImage == "Saudavel"
                                                  ? Image.asset(
                                                      AppImages.saudavel,
                                                      height: 80)
                                                  : resultImage == "Sobrepeso"
                                                      ? Image.asset(
                                                          AppImages.sobrePeso,
                                                          height: 80)
                                                      : resultImage ==
                                                              "ObesidadeGrau1"
                                                          ? Image.asset(
                                                              AppImages
                                                                  .obesidadeGrau1,
                                                              height: 80)
                                                          : resultImage ==
                                                                  "ObesidadeGrau2"
                                                              ? Image.asset(
                                                                  AppImages
                                                                      .obesidadeGrau2,
                                                                  height: 80)
                                                              : resultImage ==
                                                                      "ObesidadeGrau3"
                                                                  ? Image.asset(
                                                                      AppImages.obesidadeGrau3,
                                                                      height: 80)
                                                                  : const Text(''),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            final imc = CalcularImcClass(
                                                double.parse(
                                                    alturaController.text),
                                                double.parse(
                                                    pesoController.text),
                                                resultImage,
                                                resultImage,
                                                resultImc);
                                            var modelIMC = ImcSQLiteModel(
                                                1,
                                                double.parse(
                                                    pesoController.text),
                                                double.parse(
                                                    alturaController.text),
                                                DateTime.now().toString(),
                                                resultImage,
                                                resulClasificacao,
                                                resultImc);
                                            var repository =
                                                ImcQLiteRepository();
                                            repository.salvar(modelIMC);
                                            Navigator.pop(context);
                                            pesoController.text = "";
                                            alturaController.text = "";
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child:
                                              const TextLabel(texto: "Salvar")),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.redAccent)),
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            pesoController.text = '';
                                            alturaController.text = '';
                                            Navigator.pop(context);
                                          },
                                          child: const TextLabel(
                                              texto: "Descartar")),
                                    ],
                                  ),
                                ],
                              );
                            });
                        setState(() {
                          try {
                            criarCalculoImc();
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        });
                      },
                      child: Text("Calcular"))
                  .animate(
                    onPlay: (c) => c.repeat(),
                  )
                  .shimmer(delay: 3000.ms, duration: 1000.ms),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return ListTile(
                      title: Text(item.peso.toString()),
                      subtitle: Text(item.altura.toString()),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
