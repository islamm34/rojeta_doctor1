import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_staff_model.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_state.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/pages/widgets/nursing_add_skill_dialog.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/pages/widgets/nursing_gender_toggle_row.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/pages/widgets/nursing_labeled_text_field.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/pages/widgets/nursing_profile_photo_picker.dart';

class NursingAddStaffPage extends StatefulWidget {
  final NursingStaffModel? staff;

  const NursingAddStaffPage({super.key, this.staff});

  @override
  State<NursingAddStaffPage> createState() => _NursingAddStaffPageState();
}

class _NursingAddStaffPageState extends State<NursingAddStaffPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  String? _selectedImagePath;
  String _selectedGender = 'Male';
  String _selectedStatus = 'Available';
  final List<String> _skills = [];
  final List<String> _selectedServices = [];

  @override
  void initState() {
    super.initState();
    if (widget.staff != null) {
      _nameController.text = widget.staff!.name ?? '';
      _phoneController.text = widget.staff!.phone ?? '';
      _experienceController.text = (widget.staff!.yearsOfExperience ?? 0)
          .toString();
      _selectedImagePath = widget.staff!.imageUrl;
      _selectedGender =
          (widget.staff!.gender ?? 'MALE').toUpperCase() == 'FEMALE'
          ? 'Female'
          : 'Male';
      _selectedStatus =
          (widget.staff!.status ?? 'AVAILABLE').toUpperCase() == 'BUSY'
          ? 'Busy'
          : 'Available';
      _skills.addAll(widget.staff!.skills);
      _selectedServices.addAll(widget.staff!.selectedServices);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _addSkill() {
    showDialog(
      context: context,
      builder: (context) {
        return NursingAddSkillDialog(
          onSkillAdded: (skill) {
            setState(() {
              _skills.add(skill);
            });
          },
        );
      },
    );
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final newStaff = NursingStaffModel(
        id:
            widget.staff?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        imageUrl: _selectedImagePath ?? '',
        gender: _selectedGender.toUpperCase(),
        status: _selectedStatus.toUpperCase(),
        skills: List.from(_skills),
        yearsOfExperience: int.tryParse(_experienceController.text) ?? 0,
        phone: _phoneController.text.trim(),
        selectedServices: List.from(_selectedServices),
      );

      if (widget.staff != null) {
        context.read<NursingBloc>().add(UpdateNursingStaffEvent(newStaff));
      } else {
        context.read<NursingBloc>().add(AddNursingStaffEvent(newStaff));
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.staff != null ? 'Edit Nurse' : s.addNurse,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Profile Photo Upload
                  NursingProfilePhotoPicker(
                    imagePath: _selectedImagePath,
                    onImagePicked: (path) {
                      setState(() {
                        _selectedImagePath = path;
                      });
                    },
                  ),
                  SizedBox(height: 24.h),

                  // Basic Information Section
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.basicInformation,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        NursingLabeledTextField(
                          controller: _nameController,
                          label: s.fullName,
                          hint: s.fullNameHint,
                          validator: (v) =>
                              (v == null || v.isEmpty) ? s.requiredField : null,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          s.genderSelection,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF475569),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        NursingGenderToggleRow(
                          selectedGender: _selectedGender,
                          maleLabel: s.male,
                          femaleLabel: s.female,
                          onChanged: (val) =>
                              setState(() => _selectedGender = val),
                        ),
                        SizedBox(height: 16.h),
                        NursingLabeledTextField(
                          controller: _phoneController,
                          label: s.phoneNumber,
                          hint: '+201X XXXXXXXX',
                          keyboardType: TextInputType.phone,
                          validator: (v) =>
                              (v == null || v.isEmpty) ? s.requiredField : null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Professional Details
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.professionalDetails,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          s.skillsSpecialty,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF475569),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: [
                            ..._skills.map(
                              (skill) => Chip(
                                label: Text(
                                  skill,
                                  style: const TextStyle(
                                    color: Color(0xFF047857),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                deleteIcon: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Color(0xFF047857),
                                ),
                                onDeleted: () {
                                  setState(() => _skills.remove(skill));
                                },
                                backgroundColor: const Color(0xFF6EE7B7),
                                side: BorderSide.none,
                              ),
                            ),
                            ActionChip(
                              label: Text(
                                '+ ${s.addSkill}',
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              onPressed: _addSkill,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                side: const BorderSide(
                                  color: Color(0xFFCBD5E1),
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        NursingLabeledTextField(
                          controller: _experienceController,
                          label: s.yearsOfExperience,
                          hint: '0',
                          keyboardType: TextInputType.number,
                          validator: (v) =>
                              (v == null || v.isEmpty) ? s.requiredField : null,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          s.statusSelection,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF475569),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedStatus,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: Color(0xFFCBD5E1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: Color(0xFFCBD5E1),
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'Available',
                              child: Text(s.available),
                            ),
                            DropdownMenuItem(
                              value: 'Busy',
                              child: Text(s.busy),
                            ),
                            DropdownMenuItem(
                              value: 'On Duty',
                              child: Text(s.onDuty),
                            ),
                            DropdownMenuItem(
                              value: 'On Leave',
                              child: Text(s.onLeave),
                            ),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedStatus = val);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Available Services Section
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.availableServices,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ...state.services.map((service) {
                          final isChecked = _selectedServices.contains(
                            service.title,
                          );
                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              clipBehavior: Clip.antiAlias,
                              child: CheckboxListTile(
                                value: isChecked,
                                onChanged: (val) {
                                  setState(() {
                                    if (val == true) {
                                      _selectedServices.add(
                                        service.title ?? '',
                                      );
                                    } else {
                                      _selectedServices.remove(service.title);
                                    }
                                  });
                                },
                                title: Text(
                                  service.title ?? '',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF0F172A),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                activeColor: const Color(0xFF10B981),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Buttons
                  ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      minimumSize: Size(double.infinity, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          s.save,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                    ),
                    child: Text(
                      s.cancel,
                      style: TextStyle(
                        color: const Color(0xFF64748B),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
