import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_bloc.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_event.dart';
import 'package:rojeta_doctor/shared/widgets/custom_elevated_button.dart';
import 'package:rojeta_doctor/shared/widgets/custom_textfield.dart';

class AddSpecialDateBottomSheet extends StatefulWidget {
  const AddSpecialDateBottomSheet({super.key});

  @override
  State<AddSpecialDateBottomSheet> createState() =>
      _AddSpecialDateBottomSheetState();
}

class _AddSpecialDateBottomSheetState extends State<AddSpecialDateBottomSheet> {
  final _dateController = TextEditingController();
  final _eventController = TextEditingController();
  final _openController = TextEditingController();
  final _closeController = TextEditingController();
  bool _isClosed = false;

  @override
  void dispose() {
    _dateController.dispose();
    _eventController.dispose();
    _openController.dispose();
    _closeController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_dateController.text.isNotEmpty && _eventController.text.isNotEmpty) {
      context.read<SettingsBloc>().add(
        AddSpecialDateEvent(
          dateStr: _dateController.text,
          eventName: _eventController.text,
          openingTime: _isClosed ? null : _openController.text,
          closingTime: _isClosed ? null : _closeController.text,
          isClosed: _isClosed,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.strings.addSpecialDate,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D52),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: context.strings.date,
                controller: _dateController,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: context.strings.eventName,
                controller: _eventController,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.strings.closed,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Switch(
                    value: _isClosed,
                    onChanged: (val) {
                      setState(() {
                        _isClosed = val;
                      });
                    },
                    activeThumbColor: const Color(0xFF0F766E),
                  ),
                ],
              ),
              if (!_isClosed) ...[
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: context.strings.from,
                        controller: _openController,
                        hintText: '08:00 AM',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomTextField(
                        label: context.strings.to,
                        controller: _closeController,
                        hintText: '06:00 PM',
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 32.h),
              CustomElevatedButton(
                text: context.strings.saveChanges,
                onPressed: _onSave,
                backgroundColor: const Color(0xFF0F766E),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
