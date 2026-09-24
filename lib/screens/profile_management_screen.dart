// lib/screens/profile_management_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../models/buyer_onboarding_model.dart';
import '../services/auth_service.dart';
import '../utils/craft_assets.dart';

class ProfileManagementScreen extends StatefulWidget {
  final OnboardingState? artisanState;
  final BuyerOnboardingModel? buyerModel;
  final UserRole initialRole;
  final VoidCallback? onBack;
  final Function(OnboardingState)? onArtisanSaved;
  final Function(BuyerOnboardingModel)? onBuyerSaved;
  final Function(int)? onBottomNavTapped;

  const ProfileManagementScreen({
    super.key,
    this.artisanState,
    this.buyerModel,
    this.initialRole = UserRole.artisan,
    this.onBack,
    this.onArtisanSaved,
    this.onBuyerSaved,
    this.onBottomNavTapped,
  });

  @override
  State<ProfileManagementScreen> createState() => _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Role mode: Artisan or Buyer
  late UserRole _activeRole;

  // Personal Information Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _designationController;
  late TextEditingController _bioController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _pincodeController;
  late TextEditingController _govtIdController;
  String _selectedAvatarUrl = '';
  List<String> _selectedLanguages = ['Hindi', 'English'];

  // Store / Business Details Controllers
  late TextEditingController _storeNameController;
  late TextEditingController _taglineController;
  late TextEditingController _storeDescriptionController;
  late TextEditingController _experienceController;
  late TextEditingController _capacityController;
  late TextEditingController _moqController;
  late TextEditingController _leadTimeController;
  late TextEditingController _workshopAddressController;
  late TextEditingController _gstinController;
  String _businessType = 'Master Artisan Studio';
  List<String> _selectedCraftCategories = ['Bamboo & Cane', 'Terracotta & Clay'];
  bool _isBulkReady = true;
  bool _hasGiCertification = true;
  bool _hasCraftmark = true;
  bool _hasHandloomMark = false;
  bool _isEcoCertified = true;

  // Contact & Preferences Controllers
  String _preferredContactMethod = 'WhatsApp';
  bool _notifyOrders = true;
  bool _notifyInquiries = true;
  bool _notifyEscrowPayments = true;
  bool _notifyCollaborations = true;
  bool _notifyMarketInsights = false;
  bool _notifySmsSummary = true;
  
  // Working Hours & Auto Reply
  String _workingHours = '09:00 AM - 07:00 PM';
  String _workingDays = 'Monday to Saturday';
  bool _isAvailableForUrgent = true;
  bool _isVacationMode = false;
  bool _enableAutoReply = true;
  late TextEditingController _autoReplyController;

  bool _isSaving = false;
  bool _hasUnsavedChanges = false;

  // Color Palette matching Brand
  static const Color _terracotta = Color(0xFF8C3A16);
  static const Color _terracottaDark = Color(0xFF6E2B0D);
  static const Color _terracottaLight = Color(0xFFFBF1EB);
  static const Color _sandBg = Color(0xFFFDFBF9);
  static const Color _cardBg = Colors.white;
  static const Color _borderBeige = Color(0xFFEADFD6);
  static const Color _textDark = Color(0xFF221C19);
  static const Color _textMuted = Color(0xFF7A685F);
  static const Color _verifiedGreen = Color(0xFF2E7D32);

  final List<String> _availableLanguages = [
    'Hindi',
    'English',
    'Bengali',
    'Tamil',
    'Telugu',
    'Marathi',
    'Gujarati',
    'Assamese',
    'Odia',
    'Punjabi',
    'Kannada',
  ];

  final List<String> _craftCategoryOptions = [
    'Bamboo & Cane',
    'Blue Pottery',
    'Terracotta & Clay',
    'Madhubani Folk Art',
    'Brass & Bell Metalware',
    'Banarasi & Zardozi Weaves',
    'Wooden & Channapatna Toys',
    'Jute & Natural Fiber',
    'Leather & Mojari Craft',
    'Pattachitra Scroll Art',
  ];

  final List<String> _avatarPresets = [
    CraftAssets.artisanRamuKumar,
    CraftAssets.artisanSunitaDevi,
    CraftAssets.artisanRajeshPrajapati,
    CraftAssets.artisanMeenaBai,
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=400&q=80',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });

    _activeRole = widget.initialRole;
    _initializeData();
  }

  void _initializeData() {
    OnboardingState artisan = const OnboardingState();
    if (widget.artisanState != null) {
      artisan = widget.artisanState!;
    } else if (AuthService().currentArtisan != null) {
      final cur = AuthService().currentArtisan!;
      artisan = OnboardingState(
        artisanName: cur.name,
        email: cur.email ?? '',
        phoneNumber: cur.phone ?? '',
        artisanLocation: cur.location.isNotEmpty ? cur.location : 'Barabanki, Uttar Pradesh',
        selectedCraft: cur.craftType.isNotEmpty ? cur.craftType : 'Bamboo & Cane',
        profilePhotoUrl: (cur.profileImage != null && cur.profileImage!.isNotEmpty)
            ? cur.profileImage!
            : CraftAssets.artisanRamuKumar,
        experienceYears: cur.experienceYears ?? '10+ Years',
      );
    }

    final buyer = widget.buyerModel ?? AuthService().currentBuyer ?? const BuyerOnboardingModel();

    if (_activeRole == UserRole.artisan) {
      _selectedAvatarUrl = artisan.profilePhotoUrl.isNotEmpty
          ? artisan.profilePhotoUrl
          : CraftAssets.artisanRamuKumar;
      _nameController = TextEditingController(text: artisan.artisanName.isNotEmpty ? artisan.artisanName : 'Ramu Kumar');
      _emailController = TextEditingController(text: artisan.email.isNotEmpty ? artisan.email : 'ramukumar@hunarsangam.in');
      _phoneController = TextEditingController(text: artisan.phoneNumber.isNotEmpty ? artisan.phoneNumber : '+91 98765 43210');
      _designationController = TextEditingController(text: 'Master Cane & Bamboo Artisan');
      _bioController = TextEditingController(
        text: artisan.voiceTranscript.isNotEmpty
            ? artisan.voiceTranscript
            : 'Award-winning master craftsman specializing in GI-certified Assam cane and natural river bamboo craft.',
      );
      
      final locationParts = artisan.artisanLocation.split(',');
      _cityController = TextEditingController(text: locationParts.isNotEmpty ? locationParts.first.trim() : 'Barabanki');
      _stateController = TextEditingController(text: locationParts.length > 1 ? locationParts[1].trim() : 'Uttar Pradesh');
      _pincodeController = TextEditingController(text: '225001');
      _govtIdController = TextEditingController(text: 'XXXX-XXXX-9482 (Aadhaar / Artisan Card)');

      _storeNameController = TextEditingController(text: 'Barabanki Bamboo Handicrafts');
      _taglineController = TextEditingController(text: 'Sustainable Handwoven Cane & Bamboo Utility Ware');
      _storeDescriptionController = TextEditingController(
        text: 'Handcrafted utility baskets, eco lamps, fruit trays, and custom home decor made from seasoned bamboo.',
      );
      _experienceController = TextEditingController(text: artisan.experienceYears.isNotEmpty ? artisan.experienceYears : '12+ Years');
      _capacityController = TextEditingController(text: '650 Units / Month');
      _moqController = TextEditingController(text: '25 Pcs');
      _leadTimeController = TextEditingController(text: '7 - 12 Working Days');
      _workshopAddressController = TextEditingController(text: 'Village Dewa Sharif Road, Plot 14, Barabanki Cluster, UP');
      _gstinController = TextEditingController(text: '09AABCH1234F1Z8');
      _businessType = 'Master Artisan Studio';
      _isBulkReady = artisan.bulkProductionReady;
    } else {
      _selectedAvatarUrl = buyer.logoPath ?? CraftAssets.artisanSunitaDevi;
      _nameController = TextEditingController(text: buyer.yourName.isNotEmpty ? buyer.yourName : 'Rahul Sharma');
      _emailController = TextEditingController(text: buyer.workEmail.isNotEmpty ? buyer.workEmail : 'sourcing@crafthouse.in');
      _phoneController = TextEditingController(text: buyer.phoneNumber.isNotEmpty ? buyer.phoneNumber : '+91 98111 22334');
      _designationController = TextEditingController(text: 'Head of Artisan Sourcing');
      _bioController = TextEditingController(
        text: 'Procuring authentic GI-certified handicrafts and handlooms for retail boutiques and institutional bulk gifting.',
      );
      _cityController = TextEditingController(text: 'Indore');
      _stateController = TextEditingController(text: 'Madhya Pradesh');
      _pincodeController = TextEditingController(text: '452001');
      _govtIdController = TextEditingController(text: 'AAACC9876Q (Corporate PAN / GST)');

      _storeNameController = TextEditingController(text: buyer.businessName.isNotEmpty ? buyer.businessName : 'CraftHouse Living Collective');
      _taglineController = TextEditingController(text: 'Curated Indian Craft Home Decor & Lifestyle');
      _storeDescriptionController = TextEditingController(
        text: 'Omni-channel lifestyle retail brand partnering directly with 200+ artisan clusters across India.',
      );
      _experienceController = TextEditingController(text: '8+ Years in Retail Sourcing');
      _capacityController = TextEditingController(text: 'Monthly Sourcing: 2,500 Units');
      _moqController = TextEditingController(text: 'Min PO: 100 Pcs');
      _leadTimeController = TextEditingController(text: 'PO Cycle: 30 Days');
      _workshopAddressController = TextEditingController(text: 'Commercial Complex 4B, MG Road Sourcing Hub, Indore');
      _gstinController = TextEditingController(text: '23AAACC9876Q1Z2');
      _businessType = 'Registered Enterprise / Retail Chain';
      _isBulkReady = true;
    }

    _autoReplyController = TextEditingController(
      text: 'Namaste! Thank you for reaching out to HunarSangam. We have received your message and will respond within 2 business hours.',
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _designationController.dispose();
    _bioController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _govtIdController.dispose();

    _storeNameController.dispose();
    _taglineController.dispose();
    _storeDescriptionController.dispose();
    _experienceController.dispose();
    _capacityController.dispose();
    _moqController.dispose();
    _leadTimeController.dispose();
    _workshopAddressController.dispose();
    _gstinController.dispose();
    _autoReplyController.dispose();
    super.dispose();
  }

  double _calculateCompleteness() {
    int total = 10;
    int filled = 0;
    if (_nameController.text.trim().isNotEmpty) filled++;
    if (_emailController.text.trim().isNotEmpty) filled++;
    if (_phoneController.text.trim().isNotEmpty) filled++;
    if (_selectedAvatarUrl.isNotEmpty) filled++;
    if (_cityController.text.trim().isNotEmpty && _stateController.text.trim().isNotEmpty) filled++;
    if (_storeNameController.text.trim().isNotEmpty) filled++;
    if (_storeDescriptionController.text.trim().isNotEmpty) filled++;
    if (_selectedCraftCategories.isNotEmpty) filled++;
    if (_workshopAddressController.text.trim().isNotEmpty) filled++;
    if (_gstinController.text.trim().isNotEmpty) filled++;
    return (filled / total).clamp(0.0, 1.0);
  }

  void _onFieldChanged() {
    if (!_hasUnsavedChanges) {
      setState(() {
        _hasUnsavedChanges = true;
      });
    } else {
      setState(() {});
    }
  }

  Future<void> _handleSaveProfile() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct highlighted fields before saving.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if (_activeRole == UserRole.artisan) {
      final updatedArtisan = (widget.artisanState ?? const OnboardingState()).copyWith(
        artisanName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        artisanLocation: '${_cityController.text.trim()}, ${_stateController.text.trim()}',
        profilePhotoUrl: _selectedAvatarUrl,
        experienceYears: _experienceController.text.trim(),
        selectedCraft: _selectedCraftCategories.isNotEmpty ? _selectedCraftCategories.first : 'Bamboo & Cane',
        voiceTranscript: _bioController.text.trim(),
        bulkProductionReady: _isBulkReady,
        isProfileComplete: true,
      );

      // Sync to AuthService
      AuthService().syncArtisanFullProfile(updatedArtisan);
      widget.onArtisanSaved?.call(updatedArtisan);
    } else {
      final updatedBuyer = (widget.buyerModel ?? const BuyerOnboardingModel()).copyWith(
        yourName: _nameController.text.trim(),
        workEmail: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        businessName: _storeNameController.text.trim(),
        logoPath: _selectedAvatarUrl,
        selectedCategories: _selectedCraftCategories,
        volumeRequirement: _capacityController.text.trim(),
        useWhatsAppNotifications: _preferredContactMethod == 'WhatsApp',
      );

      AuthService().updateBuyerSession(updatedBuyer);
      widget.onBuyerSaved?.call(updatedBuyer);
    }

    if (mounted) {
      setState(() {
        _isSaving = false;
        _hasUnsavedChanges = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Profile, Store & Preferences saved successfully!',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: _verifiedGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showAvatarPickerModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Update Profile Photo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const Text(
                      'Choose from authentic craft maker presets or take a fresh studio photo.',
                      style: TextStyle(fontSize: 13, color: _textMuted),
                    ),
                    const SizedBox(height: 18),
                    
                    // Quick Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              setState(() {
                                _selectedAvatarUrl = CraftAssets.artisanRamuKumar;
                                _hasUnsavedChanges = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('📸 Studio camera capture simulation applied.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(Icons.camera_alt_rounded, size: 18),
                            label: const Text('Take Photo', style: TextStyle(fontWeight: FontWeight.w700)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _terracotta,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              setState(() {
                                _selectedAvatarUrl = CraftAssets.artisanSunitaDevi;
                                _hasUnsavedChanges = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('🖼️ Image loaded from device gallery.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(Icons.photo_library_outlined, size: 18, color: _textDark),
                            label: const Text('Gallery', style: TextStyle(color: _textDark, fontWeight: FontWeight.w700)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: _borderBeige, width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Or Select Verified Preset Portrait:',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _textDark),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 70,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _avatarPresets.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final url = _avatarPresets[index];
                          final isSelected = _selectedAvatarUrl == url;
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {});
                              setState(() {
                                _selectedAvatarUrl = url;
                                _hasUnsavedChanges = true;
                              });
                              Navigator.pop(ctx);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? _terracotta : _borderBeige,
                                      width: isSelected ? 3 : 1.5,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: _terracottaLight,
                                        child: const Icon(Icons.person, color: _terracotta),
                                      ),
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Positioned(
                                    bottom: 2,
                                    right: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: const BoxDecoration(
                                        color: _terracotta,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.check, color: Colors.white, size: 12),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final completeness = _calculateCompleteness();

    return Scaffold(
      backgroundColor: _sandBg,
      appBar: AppBar(
        backgroundColor: _sandBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _textDark, size: 22),
          onPressed: () {
            if (_hasUnsavedChanges) {
              _showDiscardDialog();
            } else {
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.maybePop(context);
              }
            }
          },
        ),
        title: const Text(
          'Profile Management',
          style: TextStyle(
            color: _textDark,
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          // Role Mode Toggle
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _activeRole = _activeRole == UserRole.artisan ? UserRole.buyer : UserRole.artisan;
                  _initializeData();
                  _hasUnsavedChanges = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _activeRole == UserRole.artisan
                          ? 'Switched to Master Artisan Profile Mode'
                          : 'Switched to Enterprise Bulk Buyer Profile Mode',
                    ),
                    duration: const Duration(seconds: 2),
                    backgroundColor: _terracotta,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _terracottaLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _borderBeige),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _activeRole == UserRole.artisan ? Icons.brush : Icons.storefront,
                      size: 14,
                      color: _terracotta,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _activeRole == UserRole.artisan ? 'Artisan Mode' : 'Buyer Mode',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: _terracotta,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: _borderBeige, width: 1)),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: _terracotta,
              unselectedLabelColor: _textMuted,
              indicatorColor: _terracotta,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              tabs: const [
                Tab(
                  icon: Icon(Icons.person_outline_rounded, size: 18),
                  text: 'Personal',
                ),
                Tab(
                  icon: Icon(Icons.storefront_outlined, size: 18),
                  text: 'Store & Craft',
                ),
                Tab(
                  icon: Icon(Icons.notifications_active_outlined, size: 18),
                  text: 'Preferences',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Top Live Preview Card (Always visible summary)
            _buildLivePreviewHeader(completeness),

            // Tab Views Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: Personal Information
                  _buildPersonalInfoTab(),

                  // Tab 2: Store & Business Details
                  _buildStoreDetailsTab(),

                  // Tab 3: Contact & Preferences
                  _buildPreferencesTab(),
                ],
              ),
            ),

            // Bottom Sticky Save Bar
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  // 1. Live Preview & Completeness Header Card
  Widget _buildLivePreviewHeader(double completeness) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderBeige, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar with camera badge
              GestureDetector(
                onTap: _showAvatarPickerModal,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _terracotta, width: 2),
                      ),
                      child: ClipOval(
                        child: _selectedAvatarUrl.isNotEmpty
                            ? Image.network(
                                _selectedAvatarUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: _terracottaLight,
                                  child: const Icon(Icons.person, color: _terracotta, size: 28),
                                ),
                              )
                            : Container(
                                color: _terracottaLight,
                                child: const Icon(Icons.person, color: _terracotta, size: 28),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: _terracotta,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 11),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),

              // Name & dynamic tags
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            _nameController.text.isNotEmpty ? _nameController.text : 'Your Name',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: _textDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.verified_rounded, color: _verifiedGreen, size: 16),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _storeNameController.text.isNotEmpty
                          ? _storeNameController.text
                          : (_activeRole == UserRole.artisan ? 'Master Craft Studio' : 'Enterprise Buyer'),
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: _textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: _terracotta),
                        const SizedBox(width: 2),
                        Text(
                          '${_cityController.text.isNotEmpty ? _cityController.text : "City"}, ${_stateController.text.isNotEmpty ? _stateController.text : "State"}',
                          style: const TextStyle(fontSize: 11, color: _textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Completeness score
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: completeness >= 0.8 ? const Color(0xFFE8F5E9) : _terracottaLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${(completeness * 100).toInt()}% Done',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: completeness >= 0.8 ? _verifiedGreen : _terracotta,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: completeness,
              minHeight: 5,
              backgroundColor: _borderBeige,
              valueColor: AlwaysStoppedAnimation<Color>(
                completeness >= 0.8 ? _verifiedGreen : _terracotta,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 1: PERSONAL INFORMATION
  // --------------------------------------------------------------------------
  Widget _buildPersonalInfoTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      physics: const BouncingScrollPhysics(),
      children: [
        _buildSectionTitle(
          title: 'Basic Identity & Contact',
          subtitle: 'Update your official name, designation, and verified contact numbers.',
          icon: Icons.badge_outlined,
        ),
        const SizedBox(height: 14),

        // Full Name
        _buildTextField(
          controller: _nameController,
          label: 'Full Name / Primary Contact Person',
          hint: 'e.g. Ramu Kumar or Rahul Sharma',
          icon: Icons.person_rounded,
          isRequired: true,
          validator: (v) => v == null || v.trim().isEmpty ? 'Full name is required' : null,
        ),
        const SizedBox(height: 14),

        // Professional Title / Role
        _buildTextField(
          controller: _designationController,
          label: 'Designation / Professional Title',
          hint: 'e.g. Master Artisan, Lead Wever, Sourcing Director',
          icon: Icons.work_outline_rounded,
        ),
        const SizedBox(height: 14),

        // Phone Number
        _buildTextField(
          controller: _phoneController,
          label: 'Primary Phone Number (WhatsApp Enabled)',
          hint: '+91 98765 43210',
          icon: Icons.phone_android_rounded,
          keyboardType: TextInputType.phone,
          isRequired: true,
          suffixWidget: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check_circle, size: 12, color: _verifiedGreen),
                SizedBox(width: 4),
                Text('Verified', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _verifiedGreen)),
              ],
            ),
          ),
          validator: (v) => v == null || v.trim().isEmpty ? 'Phone number is required' : null,
        ),
        const SizedBox(height: 14),

        // Email Address
        _buildTextField(
          controller: _emailController,
          label: 'Official Email Address',
          hint: 'name@hunarsangam.in',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Email is required';
            if (!v.contains('@')) return 'Enter a valid email address';
            return null;
          },
        ),
        const SizedBox(height: 20),

        // Bio / Craft Story / Mandate
        _buildSectionTitle(
          title: _activeRole == UserRole.artisan ? 'Craft Journey & Bio' : 'Company Bio & Sourcing Mandate',
          subtitle: 'Share your background, master heritage, awards, or sourcing scale.',
          icon: Icons.auto_stories_outlined,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _bioController,
          label: 'About You / Bio',
          hint: 'Tell buyers or artisans about your journey and expertise...',
          icon: Icons.history_edu_rounded,
          maxLines: 3,
        ),
        const SizedBox(height: 20),

        // Location Section
        _buildSectionTitle(
          title: 'Geographic Location & Studio Pincode',
          subtitle: 'Used for order logistics, regional GI cluster tagging, and shipping estimates.',
          icon: Icons.pin_drop_outlined,
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _cityController,
                label: 'City / District',
                hint: 'e.g. Barabanki',
                icon: Icons.location_city_rounded,
                isRequired: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _stateController,
                label: 'State',
                hint: 'e.g. Uttar Pradesh',
                icon: Icons.map_outlined,
                isRequired: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _pincodeController,
                label: 'Pincode',
                hint: '225001',
                icon: Icons.markunread_mailbox_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _govtIdController,
                label: 'Govt ID / Aadhaar / PAN',
                hint: 'XXXX-XXXX-9482',
                icon: Icons.fingerprint_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Languages Spoken
        _buildSectionTitle(
          title: 'Languages Spoken for Calls & Voice Chats',
          subtitle: 'Helps matching with buyers and artisans in your native tongue.',
          icon: Icons.translate_rounded,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableLanguages.map((lang) {
            final isSelected = _selectedLanguages.contains(lang);
            return FilterChip(
              label: Text(lang),
              selected: isSelected,
              onSelected: (val) {
                setState(() {
                  if (val) {
                    _selectedLanguages.add(lang);
                  } else {
                    if (_selectedLanguages.length > 1) {
                      _selectedLanguages.remove(lang);
                    }
                  }
                  _hasUnsavedChanges = true;
                });
              },
              selectedColor: _terracottaLight,
              checkmarkColor: _terracotta,
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? _terracotta : _textDark,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? _terracotta : _borderBeige,
                  width: isSelected ? 1.5 : 1.0,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // TAB 2: STORE & BUSINESS DETAILS
  // --------------------------------------------------------------------------
  Widget _buildStoreDetailsTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      physics: const BouncingScrollPhysics(),
      children: [
        _buildSectionTitle(
          title: _activeRole == UserRole.artisan ? 'Workshop & Brand Information' : 'Enterprise & Sourcing Profile',
          subtitle: 'Display your public shop name, craft focus, and official business details.',
          icon: Icons.store_rounded,
        ),
        const SizedBox(height: 14),

        // Store Name
        _buildTextField(
          controller: _storeNameController,
          label: _activeRole == UserRole.artisan ? 'Workshop / Studio Name' : 'Company / Brand Name',
          hint: 'e.g. Barabanki Bamboo Handicrafts',
          icon: Icons.storefront_rounded,
          isRequired: true,
          validator: (v) => v == null || v.trim().isEmpty ? 'Store name is required' : null,
        ),
        const SizedBox(height: 14),

        // Tagline
        _buildTextField(
          controller: _taglineController,
          label: 'Tagline / Slogan',
          hint: 'e.g. Sustainable Handwoven Cane & Bamboo Utility Ware',
          icon: Icons.short_text_rounded,
        ),
        const SizedBox(height: 14),

        // Store Description
        _buildTextField(
          controller: _storeDescriptionController,
          label: 'Store Description & Core Offerings',
          hint: 'Describe products crafted, materials used, custom bulk capabilities...',
          icon: Icons.description_outlined,
          maxLines: 3,
        ),
        const SizedBox(height: 20),

        // Primary Craft Categories
        _buildSectionTitle(
          title: 'Primary Craft Categories',
          subtitle: 'Select all traditional Indian crafts and techniques you specialize in.',
          icon: Icons.category_outlined,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _craftCategoryOptions.map((craft) {
            final isSelected = _selectedCraftCategories.contains(craft);
            return FilterChip(
              label: Text(craft),
              selected: isSelected,
              onSelected: (val) {
                setState(() {
                  if (val) {
                    _selectedCraftCategories.add(craft);
                  } else {
                    if (_selectedCraftCategories.length > 1) {
                      _selectedCraftCategories.remove(craft);
                    }
                  }
                  _hasUnsavedChanges = true;
                });
              },
              selectedColor: _terracottaLight,
              checkmarkColor: _terracotta,
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? _terracotta : _textDark,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? _terracotta : _borderBeige,
                  width: isSelected ? 1.5 : 1.0,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Business Type Selector
        _buildSectionTitle(
          title: 'Business Entity Type',
          subtitle: 'Select your operational scale for institutional matchmaking.',
          icon: Icons.business_center_outlined,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderBeige),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _businessType,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: _terracotta),
              items: [
                'Master Artisan Studio',
                'Artisan Self-Help Group (SHG)',
                'Handicraft Producer Company',
                'Registered MSME / Pvt Ltd',
                'Retailer / Boutique Chain',
                'Institutional Bulk Buyer',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textDark,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                if (newVal != null) {
                  setState(() {
                    _businessType = newVal;
                    _hasUnsavedChanges = true;
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Capacity & MOQ Grid
        _buildSectionTitle(
          title: 'Production & Order Specifications',
          subtitle: 'Helps buyers match your batch output and turnaround time.',
          icon: Icons.inventory_2_outlined,
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _capacityController,
                label: 'Monthly Output Capacity',
                hint: '650 Units / Month',
                icon: Icons.speed_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _moqController,
                label: 'Min Order Quantity (MOQ)',
                hint: '25 Pcs',
                icon: Icons.production_quantity_limits_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _experienceController,
                label: 'Years of Experience',
                hint: '12+ Years',
                icon: Icons.workspace_premium_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _leadTimeController,
                label: 'Average Lead Time',
                hint: '7 - 12 Days',
                icon: Icons.schedule_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Bulk Production Ready Toggle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderBeige),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.all_inclusive_rounded, color: _terracotta, size: 20),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ready for B2B Bulk Orders',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: _textDark),
                      ),
                      Text(
                        'Enables enterprise RFQ matching & escrow batch payouts',
                        style: TextStyle(fontSize: 11, color: _textMuted),
                      ),
                    ],
                  ),
                ],
              ),
              Switch(
                value: _isBulkReady,
                activeColor: _terracotta,
                onChanged: (val) {
                  setState(() {
                    _isBulkReady = val;
                    _hasUnsavedChanges = true;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Workshop Physical Address & GSTIN
        _buildSectionTitle(
          title: 'Physical Studio Address & Tax Registration',
          subtitle: 'Used on invoices, escrow manifests, and shipping pickup manifests.',
          icon: Icons.receipt_long_outlined,
        ),
        const SizedBox(height: 14),

        _buildTextField(
          controller: _workshopAddressController,
          label: 'Workshop / Studio Full Address',
          hint: 'Plot No, Street, Landmark, District',
          icon: Icons.home_work_outlined,
          maxLines: 2,
        ),
        const SizedBox(height: 14),

        _buildTextField(
          controller: _gstinController,
          label: 'GSTIN / MSME Udyam Registration Number',
          hint: '09AABCH1234F1Z8',
          icon: Icons.verified_user_outlined,
        ),
        const SizedBox(height: 20),

        // Quality & GI Certifications
        _buildSectionTitle(
          title: 'Heritage & Quality Badges',
          subtitle: 'Verified badges shown on your digital visiting card and product catalog.',
          icon: Icons.military_tech_outlined,
        ),
        const SizedBox(height: 12),

        _buildBadgeToggleRow(
          title: 'GI Tagged Heritage Craft',
          subtitle: 'Officially registered in National Geographical Indication Registry',
          icon: Icons.verified,
          value: _hasGiCertification,
          onChanged: (v) => setState(() {
            _hasGiCertification = v;
            _hasUnsavedChanges = true;
          }),
        ),
        const SizedBox(height: 8),

        _buildBadgeToggleRow(
          title: 'Craftmark / Handloom Mark Certified',
          subtitle: 'Authentic handmade process certification',
          icon: Icons.handyman_outlined,
          value: _hasCraftmark,
          onChanged: (v) => setState(() {
            _hasCraftmark = v;
            _hasUnsavedChanges = true;
          }),
        ),
        const SizedBox(height: 8),

        _buildBadgeToggleRow(
          title: '100% Eco-Friendly & Zero Plastic',
          subtitle: 'Natural fibers, chemical-free dyes, and biodegradable packaging',
          icon: Icons.eco_outlined,
          value: _isEcoCertified,
          onChanged: (v) => setState(() {
            _isEcoCertified = v;
            _hasUnsavedChanges = true;
          }),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // TAB 3: CONTACT PREFERENCES & NOTIFICATIONS
  // --------------------------------------------------------------------------
  Widget _buildPreferencesTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      physics: const BouncingScrollPhysics(),
      children: [
        _buildSectionTitle(
          title: 'Preferred Channel for Buyer Inquiries',
          subtitle: 'Choose how enterprise buyers and collaborators reach out to you first.',
          icon: Icons.contact_phone_outlined,
        ),
        const SizedBox(height: 12),

        // Selection Cards for Contact
        Row(
          children: [
            Expanded(
              child: _buildContactChannelCard(
                title: 'WhatsApp',
                subtitle: 'Instant Chat & Photos',
                icon: Icons.chat_rounded,
                channelKey: 'WhatsApp',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildContactChannelCard(
                title: 'Direct Call',
                subtitle: 'Voice Connection',
                icon: Icons.phone_in_talk_rounded,
                channelKey: 'Phone Call',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildContactChannelCard(
                title: 'In-App Hub',
                subtitle: 'Secure Escrow Chat',
                icon: Icons.forum_rounded,
                channelKey: 'In-App Chat',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildContactChannelCard(
                title: 'Email',
                subtitle: 'Official PO & Specs',
                icon: Icons.mark_email_read_rounded,
                channelKey: 'Email',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Notification Controls
        _buildSectionTitle(
          title: 'Push & SMS Notification Preferences',
          subtitle: 'Stay notified on critical milestone updates and payment releases.',
          icon: Icons.tune_rounded,
        ),
        const SizedBox(height: 12),

        _buildNotificationSwitch(
          title: 'Order Status & Shipping Updates',
          subtitle: 'Live updates on dispatch, batch progress, and delivery confirmation',
          value: _notifyOrders,
          onChanged: (v) => setState(() {
            _notifyOrders = v;
            _hasUnsavedChanges = true;
          }),
        ),
        _buildNotificationSwitch(
          title: 'New Bulk RFQ & Sourcing Inquiries',
          subtitle: 'Immediate alert when a buyer requests a quote for your craft',
          value: _notifyInquiries,
          onChanged: (v) => setState(() {
            _notifyInquiries = v;
            _hasUnsavedChanges = true;
          }),
        ),
        _buildNotificationSwitch(
          title: 'Escrow Release & Payout Alerts',
          subtitle: 'Instant SMS & notification when milestones are funded or released',
          value: _notifyEscrowPayments,
          onChanged: (v) => setState(() {
            _notifyEscrowPayments = v;
            _hasUnsavedChanges = true;
          }),
        ),
        _buildNotificationSwitch(
          title: 'Artisan Collective & Cluster Invites',
          subtitle: 'Invitations from neighboring artisans to co-fulfill large orders',
          value: _notifyCollaborations,
          onChanged: (v) => setState(() {
            _notifyCollaborations = v;
            _hasUnsavedChanges = true;
          }),
        ),
        _buildNotificationSwitch(
          title: 'Weekly Craft Market Demand & Price Trends',
          subtitle: 'Insights on top searched craft products across India',
          value: _notifyMarketInsights,
          onChanged: (v) => setState(() {
            _notifyMarketInsights = v;
            _hasUnsavedChanges = true;
          }),
        ),
        const SizedBox(height: 24),

        // Working Hours & Availability
        _buildSectionTitle(
          title: 'Business Working Hours & Availability',
          subtitle: 'Displayed on your public digital visiting card to manage expectations.',
          icon: Icons.access_time_rounded,
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: TextEditingController(text: _workingHours),
                label: 'Working Hours',
                hint: '09:00 AM - 07:00 PM',
                icon: Icons.schedule_rounded,
                onChanged: (v) {
                  _workingHours = v;
                  _hasUnsavedChanges = true;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: TextEditingController(text: _workingDays),
                label: 'Working Days',
                hint: 'Mon - Sat',
                icon: Icons.calendar_today_rounded,
                onChanged: (v) {
                  _workingDays = v;
                  _hasUnsavedChanges = true;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        _buildNotificationSwitch(
          title: 'Available for Urgent Custom Craft Orders',
          subtitle: 'Highlights your profile with a green "Fast Dispatch" badge',
          value: _isAvailableForUrgent,
          onChanged: (v) => setState(() {
            _isAvailableForUrgent = v;
            _hasUnsavedChanges = true;
          }),
        ),
        _buildNotificationSwitch(
          title: 'Workshop Holiday / Vacation Mode',
          subtitle: 'Temporarily pause incoming urgent leads while away from studio',
          value: _isVacationMode,
          onChanged: (v) => setState(() {
            _isVacationMode = v;
            _hasUnsavedChanges = true;
          }),
        ),
        const SizedBox(height: 24),

        // Auto-Reply Greeting Customization
        _buildSectionTitle(
          title: 'Automated Greeting & First Response',
          subtitle: 'Sent immediately when a new business buyer sends an initial message.',
          icon: Icons.auto_awesome_rounded,
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderBeige),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enable Auto-Reply for New Inquiries',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: _textDark),
              ),
              Switch(
                value: _enableAutoReply,
                activeColor: _terracotta,
                onChanged: (v) => setState(() {
                  _enableAutoReply = v;
                  _hasUnsavedChanges = true;
                }),
              ),
            ],
          ),
        ),
        if (_enableAutoReply) ...[
          const SizedBox(height: 12),
          _buildTextField(
            controller: _autoReplyController,
            label: 'Custom Auto-Reply Message',
            hint: 'Write your welcome greeting...',
            icon: Icons.message_rounded,
            maxLines: 3,
          ),
        ],
      ],
    );
  }

  // --------------------------------------------------------------------------
  // REUSABLE HELPER WIDGETS
  // --------------------------------------------------------------------------

  Widget _buildSectionTitle({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _terracottaLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: _terracotta),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: _textMuted, height: 1.3),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    Widget? suffixWidget,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: _textDark,
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: (val) {
            _onFieldChanged();
            if (onChanged != null) onChanged(val);
          },
          validator: validator,
          style: const TextStyle(fontSize: 14, color: _textDark, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400]),
            prefixIcon: Icon(icon, size: 18, color: _terracotta),
            suffixIcon: suffixWidget,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _borderBeige),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _borderBeige),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _terracotta, width: 1.8),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeToggleRow({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: value ? _terracotta : _borderBeige),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: value ? const Color(0xFFE8F5E9) : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: value ? _verifiedGreen : Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: _textDark),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: _textMuted),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: _terracotta,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildContactChannelCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String channelKey,
  }) {
    final isSelected = _preferredContactMethod == channelKey;
    return InkWell(
      onTap: () {
        setState(() {
          _preferredContactMethod = channelKey;
          _hasUnsavedChanges = true;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? _terracottaLight : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? _terracotta : _borderBeige,
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 20, color: isSelected ? _terracotta : _textMuted),
                if (isSelected)
                  const Icon(Icons.check_circle, size: 16, color: _terracotta),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? _terracotta : _textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 10.5, color: _textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderBeige),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _textDark),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: _textMuted),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: _terracotta,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Bottom Save & Discard Action Bar
  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: _borderBeige, width: 1.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Reset / Discard button
            OutlinedButton(
              onPressed: _hasUnsavedChanges ? _showDiscardDialog : null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: _hasUnsavedChanges ? _borderBeige : Colors.grey[300]!),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              ),
              child: Text(
                'Discard',
                style: TextStyle(
                  color: _hasUnsavedChanges ? _textDark : Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Save Changes Primary Button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isSaving ? null : _handleSaveProfile,
                icon: _isSaving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.save_rounded, size: 18),
                label: Text(
                  _isSaving ? 'Saving Profile...' : 'Save Profile & Store',
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _terracotta,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDiscardDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Discard Changes?',
            style: TextStyle(fontWeight: FontWeight.w800, color: _textDark),
          ),
          content: const Text(
            'You have unsaved changes in your profile. Are you sure you want to discard them and exit?',
            style: TextStyle(color: _textMuted, fontSize: 13.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Keep Editing', style: TextStyle(color: _terracotta, fontWeight: FontWeight.w700)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                if (widget.onBack != null) {
                  widget.onBack!();
                } else {
                  Navigator.maybePop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Discard', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }
}
