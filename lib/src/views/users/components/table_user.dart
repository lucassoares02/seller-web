import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/views/users/user_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TableUser extends StatefulWidget {
  const TableUser({Key? key, required this.users}) : super(key: key);

  final List<UserModel> users;

  @override
  State<TableUser> createState() => _TableUserState();
}

class _TableUserState extends State<TableUser> {
  ValueNotifier<int> copied = ValueNotifier(-1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DataTable(
            onSelectAll: (b) {},
            sortColumnIndex: 0,
            sortAscending: true,
            columns: const <DataColumn>[
              DataColumn(
                  label: Text(
                "Código",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Nome",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Empresa",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Código de acesso",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: widget.users
                .asMap()
                .entries
                .map((user) => DataRow(cells: [
                      DataCell(Text(user.value.codeUser.toString())),
                      DataCell(Text(user.value.nameUser!)),
                      DataCell(Text("${user.value.codeProvider} - ${user.value.nameProvider!}")),
                      DataCell(Row(
                        children: [
                          Text(user.value.codeAcess.toString()),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: ValueListenableBuilder(
                              valueListenable: copied,
                              builder: (context, value, child) {
                                return value == user.key
                                    ? const Tooltip(
                                        message: "Copiado com sucesso!",
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          color: colorGreen,
                                          size: 16,
                                        ),
                                      )
                                    : IconButton(
                                        tooltip: "Copiar código",
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(text: user.value.codeAcess!));
                                          copied.value = user.key;
                                        },
                                        icon: const Icon(
                                          Icons.copy,
                                          size: 14,
                                          color: colorGreyDark,
                                        ));
                              },
                            ),
                          ),
                          IconButton(
                            tooltip: "Abrir Código",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${user.value.nameUser}'),
                                        Text(
                                          '${user.value.codeProvider} - ${user.value.nameProvider}',
                                          style: const TextStyle(color: colorGreyDark, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    content: Container(
                                      width: 300,
                                      height: 200,
                                      child: Center(
                                        child: RepaintBoundary(
                                          key: GlobalKey(),
                                          child: QrImageView(
                                            data: user.value.codeAcess!,
                                            version: QrVersions.auto,
                                            size: 200.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context).textTheme.labelLarge,
                                        ),
                                        child: const Text('Fechar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context).textTheme.labelLarge,
                                        ),
                                        child: const Text('Imprimir'),
                                        onPressed: () {},
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.qr_code_rounded,
                              size: 14,
                              color: colorGreyDark,
                            ),
                          ),
                        ],
                      )),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
