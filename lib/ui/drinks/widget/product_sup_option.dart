import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/model/drink_model.dart';
import 'package:pif_flutter/ui/drinks/provider/drinks_provider.dart';

class ProductSubOption extends StatefulWidget {
  const ProductSubOption({
    required this.drinkOption,
    required this.reBuild,
    required this.drinksNotifier,
    super.key,
  });

  final DrinksNotifier drinksNotifier;
  final Options drinkOption;
  final void Function() reBuild;

  @override
  State<ProductSubOption> createState() => _ProductSubOptionState();
}

class _ProductSubOptionState extends State<ProductSubOption> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.drinkOption.valueOptionModel.length,
        (index) {
          final drinkSubOption = widget.drinkOption.valueOptionModel[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: InkWell(
              onTap: () {
                print(
                  'drink sub option value:: ${drinkSubOption.valueOptionKey}',
                );
                widget.drinksNotifier.updateValueOption(
                  options: widget.drinkOption,
                  valueOptions: drinkSubOption,
                );
                widget.drinkOption.customPopupMenuController.hideMenu();
                widget.drinkOption.isOptionSelect = true;
                widget.reBuild();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 7.h, horizontal: 3.h),
                    child: Text(
                      drinkSubOption.valueOptionKey.capitalizeTheFirstLetter(),
                      style: Style.commonTextStyle(
                        color: grayTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.reBuild(),
    );
  }
}
