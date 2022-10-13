// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/user_view_model.dart';


class MyRadioOption<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String label;
  final String image;
  final ValueChanged<T> onChanged;

  const MyRadioOption({
    this.value,
    this.groupValue,
    this.label,
    this.image,
    this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;
    return Container(
      width: 60,
      height: 60,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            width: 2.0,
            color: isSelected ? Colors.teal : Colors.white,
          ),
        ),
        color: isSelected ? Colors.teal : Colors.white,
      ),
      child: Center(
        child: new Container(
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(image.toString()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      label.toString(),
      style: const TextStyle(color: Colors.blue, fontSize: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      return Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () async {
            int i = num.tryParse(value.toString()).toInt();
            model.collageList.clear();
            model.campusList.clear();
            model.cityList.clear();
            await model.getCountryList(i ?? 1);
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                Provider.of<UserViewModel>(context, listen: false)
                    .getSearchList(
                        null, i ?? 1, null, null, null, null, null, null));
            onChanged(value);
          },
          splashColor: Colors.teal.withOpacity(0.2),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                _buildLabel(),
                const SizedBox(height: 3),
                _buildText(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
