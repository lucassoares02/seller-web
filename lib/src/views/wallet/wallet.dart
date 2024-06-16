import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profair/src/components/dropdown.dart';
import 'package:profair/src/components/loading_dash.dart';
import 'package:profair/src/components/side_menu.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/router/router.gr.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/format_currency.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/home/components/card_welcome.dart';
import 'package:profair/src/views/wallet/wallet_controller.dart';
import 'package:profair/src/views/wallet/wallet_repository.dart';

@RoutePage()
class Wallet extends StatefulWidget {
  const Wallet({super.key, this.active});

  final bool? active;

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final WalletController _walletController = WalletController(StateApp.start, WalletRepository());
  int item = -1;

  @override
  void initState() {
    if (widget.active != null) {
      _walletController.findActives(widget.active!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.active == null) {
      AutoRouter.of(context).pushNamed("/");
    }
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppSpacing(),
                    const AppSpacing(),
                    const AppSpacing(),
                    CardWelcome(),
                    const AppSpacing(),
                    Padding(
                      padding: const EdgeInsets.all(appPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Ações da carteira",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              // DropdownInput(
                              //   label: "Ordenação",
                              //   hint: "",
                              //   selectedValue: "Valorização",

                              //   options: [
                              //     Option(name: "Valorização", value: "0"),
                              //     Option(name: "Valor Investido", value: "1"),
                              //     Option(name: "Valor do Ativo", value: "2"),
                              //   ],
                              // ),
                              Row(
                                children: [
                                  TextButton.icon(
                                      onPressed: () {
                                        _walletController.sort(type: 0);
                                      },
                                      icon: const Icon(Icons.swap_vert_rounded),
                                      label: const Text("Ordenar por Valorização")),
                                  TextButton.icon(
                                      onPressed: () {
                                        _walletController.sort(type: 1);
                                      },
                                      icon: const Icon(Icons.attach_money_rounded),
                                      label: const Text("Ordenar por Valor Investido")),
                                  TextButton.icon(
                                      onPressed: () {
                                        _walletController.sort(type: 2);
                                      },
                                      icon: const Icon(Icons.money),
                                      label: const Text("Ordenar por Valor do Ativo!")),
                                ],
                              ),
                            ],
                          ),
                          const AppSpacing(),
                          ValueListenableBuilder(
                              valueListenable: _walletController.stateActives,
                              builder: (context, value, child) {
                                return value == StateApp.loading
                                    ? LoadingDash()
                                    : Column(
                                        children: _walletController.actives!.asMap().entries.map((e) {
                                          return MouseRegion(
                                            onEnter: (event) {
                                              setState(() {
                                                item = e.key;
                                              });
                                            },
                                            onExit: (event) => item = -1,
                                            cursor: MaterialStateMouseCursor.clickable,
                                            child: GestureDetector(
                                              onTap: () {
                                                AutoRouter.of(context).push(ActionRoute(action: e.value));
                                              },
                                              child: Container(
                                                height: 90,
                                                padding: const EdgeInsets.all(appPadding),
                                                margin: const EdgeInsets.only(bottom: appPadding),
                                                decoration: BoxDecoration(
                                                  color: e.key == item ? Colors.grey.withOpacity(0.1) : transparent,
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.grey.withOpacity(0.2),
                                                  ),
                                                  borderRadius: BorderRadius.circular(appRadius),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          padding: const EdgeInsets.all(appPadding),
                                                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color(0xFF3C7F7B)),
                                                          child: SvgPicture.network(e.value.image!),
                                                        ),
                                                        const AppSpacing(),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "${e.value.longName}",
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${e.value.symbol}",
                                                              style: const TextStyle(color: colorGreyDark),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const AppSpacing(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          formatCurrency(e.value.investimento!),
                                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                        ),
                                                        const AppSpacing(),
                                                        const Icon(
                                                          Icons.swap_vert,
                                                          color: colorGreen,
                                                        ),
                                                        const AppSpacing(),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "${e.value.valorizacao}%",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                color: (e.value.valorizacao! < 0) ? Colors.red : Colors.blue,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            Text(
                                                              formatCurrency(e.value.valorAtivo!),
                                                              style: const TextStyle(fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
