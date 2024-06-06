import 'package:amirtha_ayurvedha/common/sized_box/sized_box.dart';
import 'package:amirtha_ayurvedha/common/theme/app_palatte.dart';
import 'package:flutter/material.dart';

import '../../../common/theme/themes.dart';

class GenderCounterWidget extends StatefulWidget {
  final ValueChanged<int>? onMaleCountChanged;
  final ValueChanged<int>? onFemaleCountChanged;

  const GenderCounterWidget({
    super.key,
    this.onMaleCountChanged,
    this.onFemaleCountChanged,
  });

  @override
  _GenderCounterWidgetState createState() => _GenderCounterWidgetState();
}

class _GenderCounterWidgetState extends State<GenderCounterWidget> {
  int maleCount = 0;
  int femaleCount = 0;

  void _updateMaleCount(int count) {
    setState(() {
      maleCount = count;
    });
    if (widget.onMaleCountChanged != null) {
      widget.onMaleCountChanged!(count);
    }
  }

  void _updateFemaleCount(int count) {
    setState(() {
      femaleCount = count;
    });
    if (widget.onFemaleCountChanged != null) {
      widget.onFemaleCountChanged!(count);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGenderCounter('Male', maleCount, _updateMaleCount),
          SizedBoxes.normalSizedBox,
          _buildGenderCounter('Female', femaleCount, _updateFemaleCount),
        ],
      ),
    );
  }

  Widget _buildGenderCounter(
      String gender, int count, ValueChanged<int> onCountChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: AppTheme.borderDecoration,
            child: Text(gender, style: const TextStyle(fontSize: 18)),
          ),
        ),
        Row(
          children: [
            _buildCounterButton(
              icon: Icons.remove,
              onPressed: () {
                if (count > 0) {
                  onCountChanged(count - 1);
                }
              },
            ),
            Container(
              //height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //how to make the height of the container same as the above container
              decoration: AppTheme.borderDecoration,
              child: Center(
                child: Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            _buildCounterButton(
              icon: Icons.add,
              onPressed: () {
                onCountChanged(count + 1);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        color: AppPalette.appColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
