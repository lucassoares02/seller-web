import 'package:flutter/material.dart';
import 'package:profair/src/components/button.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/settings_controller.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/settings/components/card_notice.dart';
import 'package:profair/src/views/settings/components/input.dart';
import 'package:skeletons/skeletons.dart';

class SessionNotice extends StatefulWidget {
  const SessionNotice({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  State<SessionNotice> createState() => _SessionNoticeState();
}

class _SessionNoticeState extends State<SessionNotice> {
  saveForm() async {
    await widget.settingsController.saveNotice();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: appPadding * 2, right: appPadding * 2, top: appPadding * 2),
          decoration: const BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(appRadius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: appPadding,
                  right: appPadding,
                  top: appPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notícia",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const AppSpacing(),
              const AppSpacing(),
              const AppSpacing(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InputComponent(
                                  settingsController: widget.settingsController,
                                  title: "Descrição do selo",
                                  icon: Icons.event,
                                  maxLenght: 15,
                                  controller: widget.settingsController.stampNotice),
                            ),
                            const AppSpacing(),
                            Flexible(
                              flex: 1,
                              child: InputComponent(
                                  settingsController: widget.settingsController,
                                  title: "Cor",
                                  icon: Icons.color_lens,
                                  maxLenght: 10,
                                  controller: widget.settingsController.stampColorNotice),
                            ),
                          ],
                        ),
                        InputComponent(
                            settingsController: widget.settingsController,
                            title: "Título",
                            icon: Icons.title,
                            maxLenght: 50,
                            controller: widget.settingsController.titleNotice),
                        const AppSpacing(),
                        const AppSpacing(),
                        InputComponent(
                            settingsController: widget.settingsController,
                            title: "Legenda",
                            icon: Icons.subtitles_rounded,
                            controller: widget.settingsController.legendNotice),
                        const AppSpacing(),
                        const AppSpacing(),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InputComponent(
                                  settingsController: widget.settingsController,
                                  title: "Descrição do botão",
                                  maxLenght: 20,
                                  icon: Icons.text_fields_outlined,
                                  controller: widget.settingsController.descriptionButtonNotice),
                            ),
                            const AppSpacing(),
                            Flexible(
                              flex: 1,
                              child: InputComponent(
                                  settingsController: widget.settingsController,
                                  title: "Cor",
                                  maxLenght: 20,
                                  icon: Icons.color_lens_rounded,
                                  controller: widget.settingsController.colorNotice),
                            ),
                          ],
                        ),
                        const AppSpacing(),
                        const AppSpacing(),
                        InputComponent(
                            settingsController: widget.settingsController,
                            title: "Descrição",
                            icon: Icons.description,
                            maxLines: 5,
                            controller: widget.settingsController.descriptionNotice,
                            maxLenght: 300),
                        const AppSpacing(),
                        const AppSpacing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (widget.settingsController.stateSaveNotice.value == StateApp.error)
                              const Text(
                                "Parece que algo deu errado, tente novamente!",
                                style: TextStyle(color: colorRed, fontWeight: FontWeight.bold),
                              ),
                            Row(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: widget.settingsController.stateSaveNotice,
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
                  ),
                  const AppSpacing(),
                  Flexible(
                    flex: 1,
                    child: ValueListenableBuilder(
                      valueListenable: widget.settingsController.stateFind,
                      builder: (context, value, child) {
                        return value == StateApp.success
                            ? ValueListenableBuilder(
                                valueListenable: widget.settingsController.stateFindNotice,
                                builder: (context, value, child) {
                                  return value == StateApp.loading
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(horizontal: appPadding),
                                          child: SkeletonAvatar(
                                            style: SkeletonAvatarStyle(height: 400, width: double.maxFinite, borderRadius: BorderRadius.circular(10)),
                                          ),
                                        )
                                      : CardNotice(settingsController: widget.settingsController);
                                })
                            : Container();
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
