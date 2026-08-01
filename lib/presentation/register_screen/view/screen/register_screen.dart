import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';
import 'package:ogrova_team/presentation/auth/login_screen/view/login_screen.dart';
import 'package:ogrova_team/presentation/register_screen/view/widget/image_option_tile.dart';
import 'package:ogrova_team/presentation/register_screen/view/widget/registration_section_card.dart';
import 'package:ogrova_team/presentation/register_screen/view/widget/resigtration_text_field.dart';
import 'package:ogrova_team/presentation/register_screen/viewModel/registration_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _presentAddressController =
      TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _bloodController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _presentAddressController.dispose();
    _permanentAddressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Choose Profile Picture",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ImageOptionTile(
                        icon: Icons.photo_library_rounded,
                        label: "Gallery",
                        onTap: () async {
                          Navigator.pop(context);
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 80,
                          );
                          if (image != null)
                            setState(() => _profileImage = File(image.path));
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ImageOptionTile(
                        icon: Icons.camera_alt_rounded,
                        label: "Camera",
                        onTap: () async {
                          Navigator.pop(context);
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 80,
                          );
                          if (image != null)
                            setState(() => _profileImage = File(image.path));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF00A86B)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(
        () => _dobController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}",
      );
    }
  }

  void _selectGender() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: ["male", "female", "other"]
            .map(
              (e) => ListTile(
                title: Text(e.toUpperCase()),
                onTap: () {
                  _genderController.text = e;
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _selectBloodGroup() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
            .map(
              (e) => ListTile(
                title: Text(e),
                onTap: () {
                  _bloodController.text = e;
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final success = await ref
        .read(registerProviderId.notifier)
        .register(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          dob: _dobController.text.trim(),
          gender: _genderController.text.trim(),
          blood: _bloodController.text.trim(),
          present: _presentAddressController.text.trim(),
          permanent: _permanentAddressController.text.trim(),
          pass: _passwordController.text,
          Cpass: _confirmPasswordController.text,
          photo: _profileImage,
        );

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile Created Successfully"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } else {
      if (mounted) {
        final error = ref.read(registerProviderId).errorMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? "Registration Failed!"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProviderId);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorManager.primary,
              Color(0xFFF0FDF6),
              Color(0xFFF8FAFC),
              Color(0xFFF1F5F9),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 36),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    RegistrationSectionCard(
                      icon: Icons.badge_outlined,
                      title: "BASIC INFORMATION",
                      children: [
                        RegistrationTextField(
                          label: "Full Name",
                          hint: "e.g. Rahim",
                          controller: _nameController,
                        ),
                        RegistrationTextField(
                          label: "Phone",
                          hint: "01XXXXXXXXX",
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        RegistrationTextField(
                          label: "Email",
                          hint: "name@example.com",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        RegistrationTextField(
                          label: "Date of Birth",
                          hint: "dd/mm/yyyy",
                          controller: _dobController,
                          icon: Icons.calendar_today_outlined,
                          readOnly: true,
                          onTap: _selectDate,
                        ),
                        RegistrationTextField(
                          label: "Gender",
                          hint: "Select Gender",
                          controller: _genderController,
                          readOnly: true,
                          icon: Icons.arrow_drop_down,
                          onTap: _selectGender,
                        ),
                        RegistrationTextField(
                          label: "Blood Group",
                          hint: "Select Blood Group",
                          controller: _bloodController,
                          readOnly: true,
                          icon: Icons.arrow_drop_down,
                          onTap: _selectBloodGroup,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RegistrationSectionCard(
                      icon: Icons.lock_outline_rounded,
                      title: "SECURITY",
                      children: [
                        RegistrationTextField(
                          label: "Password",
                          hint: "Min 8 chars, Uppercase, symbol",
                          controller: _passwordController,
                          isPassword: true,
                          obscureText: _obscurePassword,
                          onTogglePassword: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                        RegistrationTextField(
                          label: "Confirm Password",
                          hint: "Re-enter password",
                          controller: _confirmPasswordController,
                          isPassword: true,
                          obscureText: _obscureConfirmPassword,
                          onTogglePassword: () => setState(
                            () => _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: const Color(0xFFF1F5F9),
                                  backgroundImage: _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : null,
                                  child: _profileImage == null
                                      ? const Icon(
                                          Icons.person_rounded,
                                          size: 52,
                                          color: Color(0xFF009A64),
                                        )
                                      : null,
                                ),
                                Positioned(
                                  right: -2,
                                  bottom: -2,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF00A86B),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Profile Picture",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RegistrationSectionCard(
                      icon: Icons.location_on_outlined,
                      title: "ADDRESS",
                      children: [
                        RegistrationTextField(
                          label: "Present Address",
                          hint: "Address here...",
                          controller: _presentAddressController,
                          lines: 3,
                        ),
                        RegistrationTextField(
                          label: "Permanent Address",
                          hint: "Address here...",
                          controller: _permanentAddressController,
                          lines: 3,
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: registerState.isloading
                            ? null
                            : _handleRegistration,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A86B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: registerState.isloading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Create Profile",
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
