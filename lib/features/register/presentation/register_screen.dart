import 'package:amirtha_ayurvedha/common/widgets/common_loading_widget.dart';
import 'package:amirtha_ayurvedha/features/register/presentation/pdf_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/registration_screen_provider.dart';
import '../data/model/treatment_model.dart';
import '../methods/generate_pdf.dart';
import '../widgets/add_treatment_dialogue.dart';
import '../widgets/payment_options_row.dart';
import '../widgets/textfield_with_date_picker.dart';
import '../widgets/textfield_with_dropdown.dart';
import '../widgets/time_picker_dropdown.dart';
import '../widgets/treatments_widget.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/common_text_field.dart';
import '../../../common/widgets/common_text_field_text.dart';
import '../../../common/sized_box/sized_box.dart';
import '../../../common/theme/app_palatte.dart';

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
  bool paymentMethodSelected = true;
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RegistrationScreenProvider>(context, listen: false)
          .getTreatmentList();
      Provider.of<RegistrationScreenProvider>(context, listen: false)
          .getBranchList();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    whatsappNumberController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    advanceAmountController.dispose();
    balanceAmountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void saveAndShowPdf(BuildContext context, {
    required String name,
    required String address,
    required String whatsappNumber,
    required String bookedOn,
    required String treatmentDate,
    required String treatmentTime,
    required List<Map<String, dynamic>> treatments,
    required double totalAmount,
    required double discount,
    required double advance,
    required double balance,
  }) async {
    final pdfFile = await generatePdf(
      name: name,
      address: address,
      whatsappNumber: whatsappNumber,
      bookedOn: bookedOn,
      treatmentDate: treatmentDate,
      treatmentTime: treatmentTime,
      treatments: treatments,
      totalAmount: totalAmount,
      discount: discount,
      advance: advance,
      balance: balance,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(pdfFile: pdfFile),
      ),
    );
  }

  void _openTreatmentDialog(List<String> treatmentList) {
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
    return Consumer<RegistrationScreenProvider>(builder: (context, value, _) {
      return LoadingWidget(
        isLoading: value.isLoading,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Register'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/notification_icon.png'),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      options: value.branchList
                          .map((branch) => branch.name!)
                          .toList(), // Use branchList from provider
                      hintText: 'Select your branch',
                      onChanged: (value) {
                        setState(() {
                          selectedBranch = value;
                          debugPrint(selectedBranch);
                        });
                      },
                    ),
                    SizedBoxes.normalSizedBox,
                    const CommonTextFieldText(text: 'Treatments'),
                    for (var treatment in treatments)
                      TreatmentsWidget(
                        treatment: treatment,
                      ),
                    CommonButton(
                      buttonText: '+ Add Treatment',
                      onPressed: () {
                        _openTreatmentDialog(value.treatmentList);
                      },
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
                          paymentMethodSelected = true;
                          debugPrint(paymentMethod);
                        });
                      },
                    ),
                    if (!paymentMethodSelected)
                      const Text(
                        'Please select a payment method',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppPalette.errorColor,
                        ),
                      ),
                    SizedBoxes.normalSizedBox,
                    CommonTextField(
                      hintText: '',
                      fieldText: 'Advance Amount',
                      controller: advanceAmountController,
                      showHintText: false,
                    ),
                    SizedBoxes.normalSizedBox,
                    CommonTextField(
                      hintText: '',
                      fieldText: 'Balance Amount',
                      controller: balanceAmountController,
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
                    CommonButton(
                        buttonText: 'Save',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if(paymentMethod == null){
                              setState(() {
                                paymentMethodSelected = false;
                              });
                            }else {
                              final DateTime now = DateTime.now();
                              final DateFormat formatter = DateFormat('dd/MM/yyyy | hh:mma');
                              final String formattedDate = formatter.format(now);
                              saveAndShowPdf(
                                context,
                                name: nameController.text.trim(),
                                address: addressController.text.trim(),
                                whatsappNumber: '+91 ${whatsappNumberController.text.trim()}',
                                bookedOn: formattedDate,
                                treatmentDate: dateController.text.trim(),
                                treatmentTime: '$selectedHour: $selectedMinutes',
                                treatments: [
                                  {
                                    'name': 'Panchakarma',
                                    'price': 230,
                                    'male': 4,
                                    'female': 4,
                                    'total': 2540,
                                  },
                                  {
                                    'name': 'Njavara Kizhi Treatment',
                                    'price': 230,
                                    'male': 4,
                                    'female': 4,
                                    'total': 2540,
                                  },
                                  {
                                    'name': 'Panchakarma',
                                    'price': 230,
                                    'male': 4,
                                    'female': 6,
                                    'total': 2540,
                                  },
                                ],
                                totalAmount: 7620,
                                discount: 500,
                                advance: 1200,
                                balance: 5920,
                              );
                            }
                          }
                        }),
                    SizedBoxes.largeSizedBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
