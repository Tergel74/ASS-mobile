import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SliderField extends StatelessWidget {
  const SliderField({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return FormBuilderSlider(
      name: name,
      initialValue: 0,
      max: 100,
      min: 0,
      activeColor: Colors.deepPurple,
      inactiveColor: const Color(0xFFf0f2f5),
      displayValues: DisplayValues.minMax,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}

class FormTextField extends StatelessWidget {
  const FormTextField({super.key, required this.name, required this.lines});

  final String name;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      maxLines: lines,
      validator: FormBuilderValidators.required(),
      style: TextStyle(),
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple))),
    );
  }
}

class ChoiceField extends StatelessWidget {
  const ChoiceField({super.key, required this.name, required this.options});

  final String name;
  final List options;

  @override
  Widget build(BuildContext context) {
    return FormBuilderRadioGroup(
      name: name,
      activeColor: Colors.deepPurple,
      validator: FormBuilderValidators.required(),
      options: options
          .map((option) => FormBuilderFieldOption(
                value: option['value'],
                child: Text(option['displayValue']),
              ))
          .toList(),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
