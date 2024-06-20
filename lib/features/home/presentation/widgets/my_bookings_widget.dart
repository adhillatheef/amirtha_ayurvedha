import 'package:amirtha_ayurvedha/common/theme/app_palatte.dart';
import 'package:flutter/material.dart';

class MyBookingWidget extends StatelessWidget {
  final String patientName;
  final String packageName;
  final String doctorName;
  final String date;

  final int count;

  const MyBookingWidget({
    super.key,
    required this.count,
    required this.patientName,
    required this.packageName,
    required this.doctorName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      color: AppPalette.fillColor,
      child: Column(
        children: [
          _buildListTile(
              count: count.toString(),
              doctorName: doctorName,
              packageName: packageName),
          _buildInfoRow(date: date, patientName: patientName),
          const Divider(),
          _buildBookingDetailsRow(),
        ],
      ),
    );
  }

  ListTile _buildListTile(
      {required String count,
      required String doctorName,
      required String packageName}) {
    return ListTile(
      leading: Text(
        count,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
      title: Text(
        doctorName,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
      subtitle: Text(
        packageName,
        style: const TextStyle(color: AppPalette.appColor),
      ),
    );
  }

  Widget _buildInfoRow({required String date, required String patientName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconTextRow(
          icon: Icons.calendar_today_outlined,
          text: date,
        ),
        _buildIconTextRow(
          icon: Icons.people_outline,
          text: patientName,
        ),
      ],
    );
  }

  Widget _buildIconTextRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppPalette.errorColor,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              text,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('View Booking Details'),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: AppPalette.appColor,
          ),
        ),
      ],
    );
  }
}
