import '../task/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'components/fields_view.dart';
import 'controller.dart';
import 'components/success_form_view.dart';
import 'components/error_form_view.dart';

class DailyFormView extends StatefulWidget {
  const DailyFormView({super.key});

  @override
  State<DailyFormView> createState() => _DailyFormViewState();
}

class _DailyFormViewState extends State<DailyFormView> {
  final _taskController = Get.find<TaskController>();
  final _dailyFormController =
      Get.put<DailyFormController>(DailyFormController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final lineCount = {'input': 1, 'textArea': 5};
    return Obx(() => _dailyFormController.dailyFormStatus.value ==
            DailyFormStatus.success
        ? SuccessFormView(
            quote: _dailyFormController.quote.value,
          )
        : _dailyFormController.dailyFormStatus.value == DailyFormStatus.error
            ? const ErrorFormView()
            : Scaffold(
                backgroundColor: const Color(0xFFf0f2f5),
                body: SafeArea(
                  top: true,
                  bottom: true,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.06),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: FormBuilder(
                        key: _formKey,
                        child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ListView.builder(
                              itemCount:
                                  _taskController.form.value.questions!.length +
                                      1,
                              itemBuilder: (BuildContext context, int index) {
                                var name = '';
                                var type = '';
                                if (_taskController
                                        .form.value.questions!.length !=
                                    index) {
                                  name = _taskController
                                      .form.value.questions![index].id!;
                                  type = _taskController
                                      .form.value.questions![index].type!;
                                }
                                return index ==
                                        _taskController
                                            .form.value.questions!.length
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: screenWidth * 0.8,
                                          height: screenHeight * 0.06,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              final validation = _formKey
                                                  .currentState!
                                                  .validate();
                                              if (validation) {
                                                _formKey.currentState?.save();
                                                _dailyFormController.answerForm(
                                                    _formKey
                                                        .currentState!.value);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.deepPurple),
                                            child: const Text('Submit'),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _taskController.form.value
                                                .questions![index].question!,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          type == 'slider'
                                              ? SliderField(name: name)
                                              : type == 'input' ||
                                                      type == 'textArea'
                                                  ? FormTextField(
                                                      name: name,
                                                      lines: lineCount[type]!)
                                                  : type == 'choice'
                                                      ? ChoiceField(
                                                          name: name,
                                                          options:
                                                              _taskController
                                                                  .form
                                                                  .value
                                                                  .questions![
                                                                      index]
                                                                  .answers!
                                                                  .map(
                                                                      (answer) =>
                                                                          {
                                                                            'value':
                                                                                answer.id,
                                                                            'displayValue':
                                                                                answer.answer
                                                                          })
                                                                  .toList())
                                                      : SizedBox(
                                                          width:
                                                              screenWidth * 0.7,
                                                          height:
                                                              screenWidth * 0.2,
                                                          child: const Center(
                                                              child: Text(
                                                                  'Invalid Type')),
                                                        ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      );
                              },
                            )),
                        // child: ListView.builder(
                        //   itemCount: 3,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return FormBuilderTextField(
                        //       name: 'email',
                        //     );
                        //   },
                        // ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
