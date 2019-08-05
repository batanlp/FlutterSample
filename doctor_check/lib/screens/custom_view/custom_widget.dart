import 'package:flutter/material.dart';

class CustomWidget {
  static Widget dropDownButton(TextStyle textStyle, List<String> list,
      String selected, Function(String selectValue) onSelect) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: DropdownButton(
        isExpanded: true,
        items: list.map((String dropdownItem) {
          return DropdownMenuItem<String>(
            value: dropdownItem,
            child: Text(
              dropdownItem,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          );
        }).toList(),
        style: textStyle,
        value: selected,

        onChanged: (value) {
          onSelect(value);
        },
      ),
    );
  }
}
