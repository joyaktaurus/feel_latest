// @dart=2.9
import 'package:feelathomeproject/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/user_view_model.dart';

class MyRadioOption<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final T id;
  final String label;
  final String image;
  final ValueChanged<T> onChanged;

  const MyRadioOption({
    this.value,
    this.groupValue,
    this.id,
    this.label,
    this.image,
    this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;
    return Container(
      height: 50,
      decoration: new BoxDecoration(
        color: isSelected ? GreenBottom : GreyLighty,
        border: Border.all(
            color: isSelected ? GreenBottom : GreyLighty, width: 0.0),
        borderRadius: new BorderRadius.all(Radius.elliptical(50, 50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:5.0,right: 10.0,bottom: 5,top: 5),
            child:
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(image.toString()),
                  ),
                  borderRadius: BorderRadius.all( Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.white60,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:5.0,right: 10.0),
            child: Text(
              label.toString(),
              style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 10),
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      return Container(
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
            padding: EdgeInsets.all(2),
            child: Row(
              children: [
                _buildLabel(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
