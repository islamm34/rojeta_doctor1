import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_staff_model.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_state.dart';


class NursingAddStaffPage extends StatefulWidget {
  const NursingAddStaffPage({super.key});

  @override
  State<NursingAddStaffPage> createState() => _NursingAddStaffPageState();
}

class _NursingAddStaffPageState extends State<NursingAddStaffPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _newSkillController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedStatus = 'Available';
  final List<String> _skills = ['ICU', 'Pediatrics'];
  final List<String> _selectedServices = [];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _experienceController.dispose();
    _newSkillController.dispose();
    super.dispose();
  }

  void _addSkill() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Skill'),
          content: TextField(
            controller: _newSkillController,
            decoration: const InputDecoration(
              hintText: 'e.g. Geriatrics',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_newSkillController.text.trim().isNotEmpty) {
                  setState(() {
                    _skills.add(_newSkillController.text.trim());
                  });
                }
                _newSkillController.clear();
                context.pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final newStaff = NursingStaffModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        imageUrl: 'https://i.pravatar.cc/150?img=${DateTime.now().millisecondsSinceEpoch % 70}',
        gender: _selectedGender.toUpperCase(),
        status: _selectedStatus.toUpperCase(),
        skills: List.from(_skills),
        yearsOfExperience: int.tryParse(_experienceController.text) ?? 0,
      );

      context.read<NursingBloc>().add(AddNursingStaffEvent(newStaff));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add Nurse',
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
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2E8F0),
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFCBD5E1), width: 2, style: BorderStyle.solid), // Should be dashed ideally
                              ),
                              child: Center(
                                child: Icon(Icons.camera_alt_outlined, color: const Color(0xFF64748B), size: 32.w),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 28.w,
                                height: 28.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(Icons.add, color: Colors.white, size: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Upload Profile Photo',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
                          'Basic Information',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildLabel('Full Name'),
                        _buildTextField(
                          controller: _nameController,
                          hintText: 'e.g. Ahmed Mohamed',
                          validator: (v) => v!.isEmpty ? 'Enter name' : null,
                        ),
                        SizedBox(height: 16.h),
                        _buildLabel('Gender Selection'),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedGender = 'Male'),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: _selectedGender == 'Male' ? Colors.white : const Color(0xFFDBEAFE),
                                    border: _selectedGender == 'Male' ? Border.all(color: const Color(0xFF3B82F6)) : null,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Male',
                                    style: TextStyle(
                                      color: _selectedGender == 'Male' ? const Color(0xFF1E3A8A) : const Color(0xFF64748B),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedGender = 'Female'),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: _selectedGender == 'Female' ? Colors.white : const Color(0xFFDBEAFE),
                                    border: _selectedGender == 'Female' ? Border.all(color: const Color(0xFF3B82F6)) : null,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Female',
                                    style: TextStyle(
                                      color: _selectedGender == 'Female' ? const Color(0xFF1E3A8A) : const Color(0xFF64748B),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _buildLabel('Phone Number'),
                        _buildTextField(
                          controller: _phoneController,
                          hintText: '+201X XXXXXXXX',
                          keyboardType: TextInputType.phone,
                          validator: (v) => v!.isEmpty ? 'Enter phone' : null,
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
                          'Professional Details',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildLabel('Skills / Specialty'),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: [
                            ..._skills.map((skill) => Chip(
                                  label: Text(
                                    skill,
                                    style: const TextStyle(color: Color(0xFF047857), fontWeight: FontWeight.bold),
                                  ),
                                  deleteIcon: const Icon(Icons.close, size: 16, color: Color(0xFF047857)),
                                  onDeleted: () {
                                    setState(() => _skills.remove(skill));
                                  },
                                  backgroundColor: const Color(0xFF6EE7B7),
                                  side: BorderSide.none,
                                )),
                            ActionChip(
                              label: const Text('+ Add Skill', style: TextStyle(color: Color(0xFF64748B))),
                              onPressed: _addSkill,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                side:  BorderSide(color: Color(0xFFCBD5E1), style: BorderStyle.solid),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _buildLabel('Years of Experience'),
                        _buildTextField(
                          controller: _experienceController,
                          hintText: '0',
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? 'Enter experience' : null,
                        ),
                        SizedBox(height: 16.h),
                        _buildLabel('Status Selection'),
                        DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Available', child: Text('Available')),
                            DropdownMenuItem(value: 'Busy', child: Text('Busy')),
                            DropdownMenuItem(value: 'On Duty', child: Text('On Duty')),
                            DropdownMenuItem(value: 'On Leave', child: Text('On Leave')),
                          ],
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedStatus = val);
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
                          'Available Services',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ...state.services.map((service) {
                          final isChecked = _selectedServices.contains(service.title);
                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CheckboxListTile(
                              value: isChecked,
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    _selectedServices.add(service.title);
                                  } else {
                                    _selectedServices.remove(service.title);
                                  }
                                });
                              },
                              title: Text(
                                service.title,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF0F172A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              activeColor: const Color(0xFF10B981),
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
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
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 20.w),
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
                      'Cancel',
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF475569),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
        ),
      ),
    );
  }
}
