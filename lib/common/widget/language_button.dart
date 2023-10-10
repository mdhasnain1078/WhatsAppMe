import 'package:flutter/material.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';
import '../utils/appColors.dart';
import '../../constants/colors.dart';
import 'custom_icon_button.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
  });

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: context.theme.greyColor!.withOpacity(0.4)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    CustomIconButton(
              onTap: ()=>Navigator.of(context).pop(),
              icon:  Icons.close_outlined,
            ),
                    // IconButton(
                    //     splashRadius: 22,
                    //     iconSize: 22,
                    //     padding: EdgeInsets.zero,
                    //     splashColor: Colors.transparent,
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.close_outlined,
                    //       color: AppColors.greyDark,
                    //     )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "App Language",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                  color: context.theme.greyColor!.withOpacity(0.4),
                ),
                RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: AppColors.greenDark,
                  title: const Text("English"),
                  subtitle: const Text("(Phone's Language)"),
                ),
                RadioListTile(
                  value: true,
                  groupValue: false,
                  onChanged: (value) {},
                  activeColor: AppColors.greenDark,
                  title: const Text("Hindi"),
                  subtitle: const Text("(Phone's Language)"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.langBtnBgColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          showBottomSheet(context);
        },
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.theme.langBtnHighLightColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                color: kGreen,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "English",
                style: TextStyle(color: kGreen),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: kGreen)
            ],
          ),
        ),
      ),
    );
  }
}
