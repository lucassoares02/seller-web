import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/components/loading_list.dart';
import 'package:profair/src/router/router.gr.dart';
import 'package:profair/src/shared/responsive.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/home/home_controller.dart';

class SideMenu extends StatefulWidget {
  SideMenu({Key? key, required this.homeController, this.action}) : super(key: key);

  HomeController homeController;
  Function()? action;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  ValueNotifier<bool> openDrawer = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("widget.homeController.data --------------------------------------------");
    print(widget.homeController.data);

    return SizedBox(
      width: ((!Responsive.isDesktop(context)) ? 60 : 250),
      child: Container(
        decoration: const BoxDecoration(
          color: colorGreyLigth,
        ),
        child: ValueListenableBuilder(
            valueListenable: widget.homeController.stateData,
            builder: (context, value, child) {
              return value == StateApp.loading
                  ? Container(padding: EdgeInsets.only(top: height * 0.15), child: LoadingList(loadingHeader: false))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 120,
                              // padding: const EdgeInsets.only(top: appPadding * 3, bottom: appMargin),
                              // margin: const EdgeInsets.only(bottom: appMargin),
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: colorGrey))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: !Responsive.isDesktop(context)
                                        ? null
                                        : Text(widget.homeController.data!.nameUser!.split(" ")[0]),
                                    subtitle: !Responsive.isDesktop(context)
                                        ? null
                                        : Text(widget.homeController.data!.nameCompany!.split(" ")[0]),
                                    leading: Container(
                                      // padding: const EdgeInsets.all(appMargin),
                                      decoration: const BoxDecoration(
                                        color: colorPrimary,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      child: Icon(Icons.person_outline_rounded),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Column(
                            //   children: widget.homeController!.categories.asMap().entries.map((e) {
                            //     return ListTile(
                            //       title: Text("${e.value.title}"),
                            //       leading: Icon(e.value.icon),
                            //       onTap: () {
                            //         widget.action!(e.key);
                            //       },
                            //     );
                            //   }).toList(),
                            // )
                            widget.homeController.data!.accessTargeting == 3
                                ? Column(
                                    children: [
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Dashboard"),
                                        leading: const Icon(Icons.dashboard),
                                        onTap: () => AutoRouter.of(context).push(const HomeRoute()),
                                      ),
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Fornecedores"),
                                        leading: const Icon(Icons.sell),
                                        onTap: () {
                                          print(widget.homeController.data!.codAccess);
                                          AutoRouter.of(context)
                                              .push(Providers(codeClient: 0, codeBranch: 0, codeBuyer: 0));
                                        },
                                      ),
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Associados"),
                                        leading: const Icon(Icons.person),
                                        onTap: () => AutoRouter.of(context).push(Clients(
                                            codeProvider: 0,
                                            accessTargenting: widget.homeController.data!.accessTargeting,
                                            merchandise: 0,
                                            trading: 0)),
                                      ),
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Usuários"),
                                        leading: const Icon(Icons.group),
                                        onTap: () => AutoRouter.of(context).push(const Users()),
                                      ),
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Pedidos"),
                                        leading: const Icon(Icons.swap_vert),
                                        onTap: () =>
                                            AutoRouter.of(context).push(RequestsStores(codeProvider: 0, userCode: 0)),
                                      ),
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Relatórios"),
                                        leading: const Icon(Icons.auto_graph_outlined),
                                        onTap: () => AutoRouter.of(context).push(Reports(
                                            codeProvider: 0,
                                            accessTargeting: widget.homeController.data!.accessTargeting)),
                                      ),
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Importar"),
                                        leading: const Icon(Icons.drive_folder_upload_rounded),
                                        onTap: () => AutoRouter.of(context).push(const Upload()),
                                      ),
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Exportar"),
                                        leading: const Icon(Icons.sim_card_download_rounded),
                                        onTap: () => AutoRouter.of(context)
                                            .push(Download(homeController: widget.homeController)),
                                      ),
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Configurações"),
                                        leading: const Icon(Icons.settings),
                                        onTap: () => AutoRouter.of(context).push(const Settings()),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      ListTile(
                                        title: !Responsive.isDesktop(context) ? null : const Text("Exportar"),
                                        leading: const Icon(Icons.sim_card_download_rounded),
                                        onTap: () => AutoRouter.of(context)
                                            .push(Download(homeController: widget.homeController)),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: appPadding, horizontal: appMargin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ListTile(
                                title: !Responsive.isDesktop(context) ? null : const Text("Sair"),
                                leading: const Icon(Icons.logout_outlined),
                                onTap: () {
                                  widget.homeController.logout();
                                  AutoRouter.of(context)
                                      .pushAndPopUntil(const LoginRoute(), predicate: ((route) => false));
                                  // AutoRouter.of(context).pushAndPopUntil(const LoginRoute());
                                },
                              ),
                            ],
                          ),
                        ),
                        // ListTile(
                        //   title: const Text("Dúvidas"),
                        //   leading: const Icon(Icons.message),
                        //   onTap: () => widget.action!(3),
                        // ),
                        // ListTile(
                        //   title: const Text("Contatos"),
                        //   leading: const Icon(Icons.phone),
                        //   onTap: () => widget.action!(0),
                        // ),
                      ],
                    );
            }),
      ),
    );
  }
}
