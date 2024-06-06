import 'package:amirtha_ayurvedha/common/sized_box/sized_box.dart';
import 'package:amirtha_ayurvedha/common/theme/app_palatte.dart';
import 'package:amirtha_ayurvedha/common/widgets/common_text_field.dart';
import 'package:amirtha_ayurvedha/common/widgets/common_text_field_text.dart';
import 'package:amirtha_ayurvedha/features/register/widgets/textfield_with_date_picker.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/common_button.dart';
import '../data/model/treatment_model.dart';
import '../widgets/add_treatment_dialogue.dart';
import '../widgets/payment_options_row.dart';
import '../widgets/textfield_with_dropdown.dart';
import '../widgets/time_picker_dropdown.dart';
import '../widgets/treatments_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final whatsappNumberController = TextEditingController();
  final addressController = TextEditingController();
  final totalAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final advanceAmountController = TextEditingController();
  final balanceAmountController = TextEditingController();
  final dateController = TextEditingController();
  String? selectedLocation;
  String? selectedBranch;
  String? paymentMethod;
  String? selectedHour;
  String? selectedMinutes;
  String? selectedTreatment;
  List<Treatment> treatments = [];
  List<String> keralaStates = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad',
  ];

  List<String> treatmentList = [
    'Couple combo package',
    'Couple normal package',
    'Single package',
  ];

  @override
  void dispose() {
    nameController.dispose();
    whatsappNumberController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    super.dispose();
  }

  void _openTreatmentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return TreatmentDialog(
          treatmentList: treatmentList,
          onSave: (treatment) {
            setState(() {
              treatments.add(treatment);
              debugPrint('Added treatment: ${treatment.type}');
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Register'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/notification_icon.png'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextField(
                  hintText: 'Enter your name',
                  fieldText: 'Name',
                  controller: nameController,
                ),
                SizedBoxes.normalSizedBox,
                CommonTextField(
                  hintText: 'Enter your whatsapp number',
                  fieldText: 'Whatsapp Number',
                  controller: whatsappNumberController,
                  textInputType: TextInputType.number,
                ),
                SizedBoxes.normalSizedBox,
                CommonTextField(
                  hintText: 'Enter your Address',
                  fieldText: 'Address',
                  controller: addressController,
                ),
                SizedBoxes.normalSizedBox,
                const CommonTextFieldText(text: 'Location'),
                TextFieldWithDropDown(
                  options: keralaStates,
                  hintText: 'Select your location',
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                      debugPrint(selectedLocation);
                    });
                  },
                ),
                SizedBoxes.normalSizedBox,
                const CommonTextFieldText(text: 'Branch'),
                TextFieldWithDropDown(
                  options: keralaStates,
                  hintText: 'Select your branch',
                  onChanged: (value) {
                    setState(() {
                      selectedBranch = value;
                      debugPrint(selectedBranch); // Update selectedLocation
                    });
                  },
                ),
                SizedBoxes.normalSizedBox,
                const CommonTextFieldText(text: 'Treatments'),
                for(var treatment in treatments)
                  TreatmentsWidget(treatment: treatment,),
                CommonButton(
                  buttonText: '+ Add Treatment',
                  onPressed: _openTreatmentDialog,
                  color: AppPalette.lightGreenColor,
                  textColor: Colors.black,
                ),
                SizedBoxes.normalSizedBox,
                CommonTextField(
                  hintText: '',
                  fieldText: 'Total Amount',
                  controller: totalAmountController,
                  showHintText: false,
                ),
                SizedBoxes.normalSizedBox,
                CommonTextField(
                  hintText: '',
                  fieldText: 'Discount Amount',
                  controller: discountAmountController,
                  showHintText: false,
                ),
                SizedBoxes.normalSizedBox,
                const CommonTextFieldText(
                  text: 'Payment Options',
                ),
                PaymentOptionsRow(
                  options: const ['Cash', 'Card', 'UPI'],
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value;
                      debugPrint(paymentMethod);
                    });
                  },
                ),
                SizedBoxes.normalSizedBox,
                CommonTextField(
                  hintText: '',
                  fieldText: 'Advance Amount',
                  controller: discountAmountController,
                  showHintText: false,
                ),
                SizedBoxes.normalSizedBox,
                CommonTextField(
                  hintText: '',
                  fieldText: 'Balance Amount',
                  controller: discountAmountController,
                  showHintText: false,
                ),
                SizedBoxes.normalSizedBox,
                const CommonTextFieldText(text: 'Treatment Date'),
                TextFieldWithDatePicker(
                  hintText: 'Treatment Date',
                  controller: dateController,
                  onDateChanged: (date) {
                    debugPrint('Select treatment date: $date');
                  },
                ),
                SizedBoxes.normalSizedBox,
                const CommonTextFieldText(text: 'Treatment Time'),
                TimePickerDropdown(
                  onHourChanged: (hour) {
                    setState(() {
                      selectedHour = hour;
                    });
                  },
                  onMinuteChanged: (minute) {
                    setState(() {
                      selectedMinutes = minute;
                    });
                  },
                ),
                SizedBoxes.largeSizedBox,
                CommonButton(buttonText: 'Save', onPressed: () {}),
                SizedBoxes.largeSizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
