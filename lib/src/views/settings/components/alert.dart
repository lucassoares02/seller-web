import 'package:flutter/material.dart';
import 'package:profair/src/components/button.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/settings_controller.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/home/components/alerts.dart';
import 'package:profair/src/views/settings/components/input.dart';

class SessionAlert extends StatefulWidget {
  const SessionAlert({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  State<SessionAlert> createState() => _SessionAlertState();
}

class _SessionAlertState extends State<SessionAlert> {
  saveForm() async {
    await widget.settingsController.saveSettings(
      widget.settingsController.title.text,
      widget.settingsController.time.text,
      int.parse(widget.settingsController.priority.text),
      widget.settingsController.description.text,
    );
    cleanForm(state: widget.settingsController.stateSave.value);
  }

  onDelete() async {
    await widget.settingsController.deleteAlert();
    cleanForm(state: widget.settingsController.stateDelete.value, closeForm: true);
  }

  cleanForm({required StateApp state, bool closeForm = false}) {
    if (state == StateApp.success) {
      widget.settingsController.title.text = "";
      widget.settingsController.time.text = "";
      widget.settingsController.priority.text = "";
      widget.settingsController.description.text = "";
      if (closeForm) {
        widget.settingsController.visibleForm.value = false;
      }
    } else if (state == StateApp.error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          // padding: const EdgeInsets.all(appPadding * 3),
          decoration: const BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(appRadius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: appPadding * 3,
                  right: appPadding * 3,
                  top: appPadding * 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Alertas",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ValueListenableBuilder(
                        valueListenable: widget.settingsController.visibleForm,
                        builder: (context, value, child) {
                          return AppButton(
                            onPressButton: () {
                              if (!widget.settingsController.visibleForm.value) {
                                widget.settingsController.visibleForm.value = !widget.settingsController.visibleForm.value;
                              } else if (widget.settingsController.visibleForm.value && widget.settingsController.idAlert.value != null) {
                              } else {
                                widget.settingsController.visibleForm.value = !widget.settingsController.visibleForm.value;
                              }
                              widget.settingsController.title.text = "";
                              widget.settingsController.priority.text = "";
                              widget.settingsController.time.text = "";
                              widget.settingsController.description.text = "";
                              widget.settingsController.idAlert.value = null;
                            },
                            type: "filled",
                            colorButton: value == true ? colorBlack : colorSecondary,
                            iconButton: value == true ? Icons.remove : Icons.add,
                            label: value == true ? "Limpar" : "Novo alerta",
                          );
                        })
                  ],
                ),
              ),
              const AppSpacing(),
              const AppSpacing(),
              ValueListenableBuilder(
                valueListenable: widget.settingsController.stateFind,
                builder: (context, value, child) {
                  return value == StateApp.success
                      ? Alerts(
                          settingsController: widget.settingsController,
                          listItems: widget.settingsController.alerts,
                          state: widget.settingsController.stateFind,
                          title: "Visualização dos Alertas",
                          cardHeigth: 120,
                          cardWidth: 380,
                        )
                      : Container();
                },
              ),
              const AppSpacing(),
              const AppSpacing(),
              const AppSpacing(),
              ValueListenableBuilder(
                valueListenable: widget.settingsController.visibleForm,
                builder: ((context, value, child) {
                  return value == false
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: appPadding * 3,
                            right: appPadding * 3,
                            bottom: appPadding * 3,
                          ),
                          child: Column(
                            children: [
                              InputComponent(title: "Título", icon: Icons.title, maxLenght: 50, controller: widget.settingsController.title),
                              const AppSpacing(),
                              const AppSpacing(),
                              Row(
                                children: [
                                  Flexible(
                                      flex: 1,
                                      child: InputComponent(title: "Prioridade", icon: Icons.priority_high_rounded, controller: widget.settingsController.priority)),
                                  const AppSpacing(),
                                  Flexible(flex: 1, child: InputComponent(title: "Horário", icon: Icons.timer_sharp, controller: widget.settingsController.time)),
                                ],
                              ),
                              const AppSpacing(),
                              const AppSpacing(),
                              InputComponent(title: "Descrição", icon: Icons.description, maxLines: 5, controller: widget.settingsController.description, maxLenght: 200),
                              const AppSpacing(),
                              const AppSpacing(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (widget.settingsController.stateSave.value == StateApp.error)
                                    const Text(
                                      "Parece que algo deu errado, tente novamente!",
                                      style: TextStyle(color: colorRed, fontWeight: FontWeight.bold),
                                    ),
                                  Row(
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: widget.settingsController.idAlert,
                                        builder: (context, value, child) {
                                          print("===== idAlert ======");
                                          print(widget.settingsController.idAlert);
                                          print(value);
                                          return value != null
                                              ? AppButton(
                                                  onPressButton: () => onDelete(),
                                                  colorButton: colorRed,
                                                  iconButton: Icons.close,
                                                  label: "Excluir",
                                                  type: "filled",
                                                )
                                              : Container();
                                        },
                                      ),
                                      const AppSpacing(),
                                      ValueListenableBuilder(
                                        valueListenable: widget.settingsController.stateSave,
                                        builder: (context, value, child) {
                                          return AppButton(
                                            onPressButton: () => saveForm(),
                                            colorButton: colorSecondary,
                                            iconButton: Icons.check,
                                            loading: value == StateApp.loading,
                                            label: "Salvar",
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
