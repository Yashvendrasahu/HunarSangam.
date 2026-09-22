// lib/models/buyer_onboarding_model.dart

enum BusinessType {
  retailer('Retailer / Boutique', 'Curated physical retail shop'),
  eventOrganizer('Event Organizer', 'Weddings, corporate & cultural events'),
  corporateBuyer('Corporate Buyer', 'Gifting, hospitality & decor'),
  shopOwner('Shop Owner / Distributor', 'Wholesale & distribution'),
  institutional('Institutional / NGO', 'Govt, foundations & museums'),
  other('Other Business', 'Custom sourcing requirements');

  final String title;
  final String subtitle;

  const BusinessType(this.title, this.subtitle);
}

class BuyerOnboardingModel {
  final String buyerId;
  final String yourName;
  final String businessName;
  final String countryCode;
  final String phoneNumber;
  final String workEmail;
  final bool useWhatsAppNotifications;
  final BusinessType businessType;
  final String? logoPath;
  final List<String> selectedCategories;
  final String? volumeRequirement;
  final String? customNote;
  final bool isVerified;

  const BuyerOnboardingModel({
    this.buyerId = 'BB-88392',
    this.yourName = '',
    this.businessName = '',
    this.countryCode = '+91',
    this.phoneNumber = '',
    this.workEmail = '',
    this.useWhatsAppNotifications = true,
    this.businessType = BusinessType.retailer,
    this.logoPath,
    this.selectedCategories = const ['Pottery & Ceramics', 'Bamboo & Cane'],
    this.volumeRequirement = '50-200 pcs / month',
    this.customNote,
    this.isVerified = true,
  });

  BuyerOnboardingModel copyWith({
    String? buyerId,
    String? yourName,
    String? businessName,
    String? countryCode,
    String? phoneNumber,
    String? workEmail,
    bool? useWhatsAppNotifications,
    BusinessType? businessType,
    String? logoPath,
    List<String>? selectedCategories,
    String? volumeRequirement,
    String? customNote,
    bool? isVerified,
  }) {
    return BuyerOnboardingModel(
      buyerId: buyerId ?? this.buyerId,
      yourName: yourName ?? this.yourName,
      businessName: businessName ?? this.businessName,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      workEmail: workEmail ?? this.workEmail,
      useWhatsAppNotifications: useWhatsAppNotifications ?? this.useWhatsAppNotifications,
      businessType: businessType ?? this.businessType,
      logoPath: logoPath ?? this.logoPath,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      volumeRequirement: volumeRequirement ?? this.volumeRequirement,
      customNote: customNote ?? this.customNote,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
