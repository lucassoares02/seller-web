import 'package:profair/generated/l10n.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderList extends StatefulWidget {
  HeaderList({super.key, this.label, this.activeSearch = true, this.onSearch, this.icon, this.onBack = true});

  String? label;
  bool? activeSearch;
  Function(String?)? onSearch;
  IconData? icon;
  bool onBack;

  @override
  State<HeaderList> createState() => _HeaderListState();
}

class _HeaderListState extends State<HeaderList> {
  TextEditingController controllerSearch = TextEditingController();
  ValueNotifier<bool> visibleSearch = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 120,
          padding: const EdgeInsets.only(top: appPadding * 3, left: appMargin, right: appMargin),
          margin: const EdgeInsets.only(bottom: appMargin),
          decoration: const BoxDecoration(
            color: colorWhite,
            border: Border(
              bottom: BorderSide(color: colorGrey),
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: visibleSearch,
            builder: (context, value, child) {
              return visibleSearch.value
                  ? TextField(
                      autofocus: true,
                      cursorColor: colorSecondary,
                      controller: controllerSearch,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        suffixIcon: IconButton(
                            onPressed: () {
                              visibleSearch.value = !visibleSearch.value;
                              controllerSearch.text = "";
                              widget.onSearch!("");
                            },
                            icon: const Icon(Icons.close)),
                        prefixIcon: const Icon(Icons.search),
                        hintText: S.of(context).text_search,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                        ),
                      ),
                      onChanged: (value) {
                        widget.onSearch!(value);
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (widget.onBack)
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 20,
                                ),
                              ),
                            const AppSpacing(),
                            Text(
                              "${widget.label}",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: widget.activeSearch!
                              ? () {
                                  visibleSearch.value = !visibleSearch.value;
                                }
                              : null,
                          icon: Icon(
                            color: widget.activeSearch! ? colorBlack : transparent,
                            Icons.search,
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
        // Container(
        //   width: width,
        //   decoration: const BoxDecoration(
        //     color: colorSecondary,
        //     border: Border(
        //       top: BorderSide(color: colorSecondary),
        //     ),
        //   ),
        //   padding: const EdgeInsets.all(appPadding),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Icon(widget.icon, size: 24, color: colorWhite),
        //       const SizedBox(width: appMargin),
        //       Text(
        //         "${widget.label}",
        //         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorWhite),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class Tuple2 {}
