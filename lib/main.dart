// lib/main.dart

import 'package:flutter/material.dart';
import 'models/onboarding_state.dart';
import 'screens/splash_welcome_screen.dart';
import 'screens/language_selection_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/account_creation_screen.dart';
import 'screens/login_screen.dart';
import 'screens/voice_intro_screen.dart';
import 'screens/craft_selection_screen.dart';
import 'screens/profile_photo_screen.dart';
import 'screens/profile_preview_screen.dart';
import 'screens/artisan_home_screen.dart';
import 'models/buyer_onboarding_model.dart';
import 'screens/buyer_onboarding_step1_screen.dart';
import 'screens/buyer_onboarding_step2_screen.dart';
import 'screens/buyer_onboarding_step3_screen.dart';
import 'screens/buyer_profile_confirmation_screen.dart';
import 'screens/buyer_home_screen.dart';
import 'screens/buyer_discover_screen.dart';
import 'screens/buyer_search_screen.dart';
import 'screens/buyer_search_results_screen.dart';
import 'screens/buyer_featured_artisans_screen.dart';
import 'screens/buyer_artisan_profile_screen.dart';
import 'screens/buyer_business_sourcing_screen.dart';
import 'screens/buyer_requirements_screen.dart';
import 'screens/buyer_voice_requirement_screen.dart';
import 'screens/buyer_requirement_step2_screen.dart';
import 'screens/buyer_requirement_review_screen.dart';
import 'screens/buyer_reference_image_screen.dart';
import 'screens/buyer_review_match_screen.dart';
import 'screens/buyer_matched_artisans_screen.dart';
import 'screens/buyer_compare_artisans_screen.dart';
import 'screens/buyer_selected_artisan_screen.dart';
import 'screens/buyer_orders_hub_screen.dart';
import 'screens/buyer_profile_screen.dart';
import 'screens/buyer_order_details_screen.dart';
import 'screens/buyer_artisan_chat_screen.dart';
import 'screens/conversations_list_screen.dart';
import 'screens/profile_management_screen.dart';
import 'services/supabase_service.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService().init();
  runApp(const HunarSangamApp());
}

class HunarSangamApp extends StatelessWidget {
  const HunarSangamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HunarSangam Craft Maker & Bulk Buyer Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFDFBF9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA84318),
          primary: const Color(0xFFA84318),
          secondary: const Color(0xFFD85A2A),
          surface: const Color(0xFFFDFBF9),
        ),
        fontFamily: 'Roboto',
      ),
      home: const OnboardingFlowCoordinator(),
    );
  }
}

class OnboardingFlowCoordinator extends StatefulWidget {
  const OnboardingFlowCoordinator({super.key});

  @override
  State<OnboardingFlowCoordinator> createState() => _OnboardingFlowCoordinatorState();
}

class _OnboardingFlowCoordinatorState extends State<OnboardingFlowCoordinator> {
  OnboardingState _state = const OnboardingState();
  BuyerOnboardingModel _buyerModel = const BuyerOnboardingModel();
  final PageController _pageController = PageController();
  int _currentFlowIndex = 0;
  int _buyerStep = 0; // 0: not in buyer flow, 1: Step 1, 2: Step 2, 3: Step 3, 4: Confirmation, 5: Home, 6: Discover (d1), 7: Search (d2), 8: Results (d3), 9: Featured (d4), 10: Profile (d5), 11: Sourcing (d6)
  String _buyerSearchQuery = 'Bamboo fruit baskets';
  String _selectedBuyerOrderId = 'HS-BKT-892';
  bool _isLoggedIn = false;
  bool _showingLoginScreen = false;

  @override
  void initState() {
    super.initState();
    _checkExistingSession();
  }

  Future<void> _checkExistingSession() async {
    final user = await AuthService().restoreSession();
    if (user != null && mounted) {
      if (user.role == 'buyer') {
        setState(() {
          _buyerModel = AuthService().currentBuyer ??
              BuyerOnboardingModel(
                yourName: user.name,
                businessName: 'FabCraft Living',
                workEmail: user.email,
                phoneNumber: user.phone,
              );
          _buyerStep = 5;
        });
      } else {
        final artisan = AuthService().currentArtisan;
        setState(() {
          _state = _state.copyWith(
            artisanName: user.name,
            email: user.email,
            phoneNumber: user.phone,
            selectedRole: UserRole.artisan,
            artisanLocation: artisan?.location ?? 'Barabanki, Uttar Pradesh',
          );
          _isLoggedIn = true;
        });
      }
    }
  }

  void _updateState(OnboardingState newState) {
    setState(() {
      _state = newState;
    });
  }

  void _handleRoleContinue() {
    if (_state.selectedRole == UserRole.buyer) {
      setState(() {
        _buyerStep = 1;
      });
    } else {
      _nextPage();
    }
  }

  void _navigateToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 340),
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextPage() {
    if (_currentFlowIndex < 7) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _previousPage() {
    if (_currentFlowIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _goToLoginScreen() {
    setState(() {
      _showingLoginScreen = true;
    });
  }

  void _goToAccountCreation() {
    setState(() {
      _showingLoginScreen = false;
    });
    _pageController.jumpToPage(3); // Account creation page
  }

  void _performLogin([OnboardingState? sessionState]) {
    setState(() {
      if (sessionState != null) {
        _state = sessionState;
      }
      _showingLoginScreen = false;
      _isLoggedIn = true;
    });
  }

  void _completeOnboardingAndGoHome() async {
    await AuthService().syncArtisanFullProfile(_state);
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
      _showingLoginScreen = false;
      _currentFlowIndex = 0;
    });
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    // If user is logged in or completed account creation, display Artisan Home Screen
    if (_isLoggedIn) {
      return ArtisanHomeScreen(
        state: _state,
        onLogout: _logout,
        onStateChanged: _updateState,
      );
    }

    // If user clicked 'Already have an account? Login'
    if (_showingLoginScreen) {
      return LoginScreen(
        initialState: _state,
        currentLanguage: _state.selectedLanguage.isNotEmpty ? _state.selectedLanguage : 'English',
        onLoginSuccess: _performLogin,
        onLoginSuccessWithState: (loggedInState) => _performLogin(loggedInState),
        onBuyerLoginSuccess: (buyerModel) {
          setState(() {
            _buyerModel = buyerModel;
            _buyerStep = 5;
            _showingLoginScreen = false;
          });
        },
        onCreateAccount: _goToAccountCreation,
        onBack: _goToAccountCreation,
      );
    }

    // Buyer Registration Flow - Steps 1, 2, 3
    if (_buyerStep == 1) {
      return BuyerOnboardingStep1Screen(
        initialModel: _buyerModel,
        onBack: () => setState(() => _buyerStep = 0),
        onContinue: (updated) => setState(() {
          _buyerModel = updated;
          _buyerStep = 2;
        }),
      );
    }

    if (_buyerStep == 2) {
      return BuyerOnboardingStep2Screen(
        model: _buyerModel,
        onBack: () => setState(() => _buyerStep = 1),
        onContinue: (updated) => setState(() {
          _buyerModel = updated;
          _buyerStep = 3;
        }),
      );
    }

    if (_buyerStep == 3) {
      return BuyerOnboardingStep3Screen(
        model: _buyerModel,
        onBack: () => setState(() => _buyerStep = 2),
        onEditStep1: () => setState(() => _buyerStep = 1),
        onEditStep2: () => setState(() => _buyerStep = 2),
        onCreateProfile: () async {
          await AuthService().registerBuyer(
            yourName: _buyerModel.yourName,
            businessName: _buyerModel.businessName,
            phone: _buyerModel.phoneNumber,
            email: _buyerModel.workEmail,
            password: 'BuyerPassword@123',
            businessType: _buyerModel.businessType.title,
            cityLocation: 'New Delhi',
          );
          setState(() => _buyerStep = 4);
        },
      );
    }

    // Buyer Profile Confirmation Screen (matching bulk buyer profile confirmation after register.png)
    if (_buyerStep == 4) {
      return BuyerProfileConfirmationScreen(
        model: _buyerModel,
        onGoToDashboard: () => setState(() => _buyerStep = 5),
        onViewProfile: () => setState(() => _buyerStep = 3),
        onBack: () => setState(() => _buyerStep = 3),
      );
    }

    // Bulk Buyer Home Dashboard Screen (matching home - bulk buyer.png)
    if (_buyerStep == 5) {
      return BuyerHomeScreen(
        model: _buyerModel,
        onLogout: () => setState(() {
          _buyerStep = 0;
          _isLoggedIn = false;
        }),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenSearch: () => setState(() => _buyerStep = 7),
        onPostRequirement: () => setState(() => _buyerStep = 13),
        onTabChange: (idx) {
          if (idx == 0) setState(() => _buyerStep = 5);
          if (idx == 1) setState(() => _buyerStep = 6);
          if (idx == 2) setState(() => _buyerStep = 12);
          if (idx == 3) setState(() => _buyerStep = 20);
          if (idx == 4) setState(() => _buyerStep = 21);
        },
      );
    }

    // Screen d1: Bulk Buyer Discover Screen (matching d1 - bulk- Discover.png)
    if (_buyerStep == 6) {
      return BuyerDiscoverScreen(
        model: _buyerModel,
        onBack: () => setState(() => _buyerStep = 5),
        onOpenSearch: () => setState(() => _buyerStep = 7),
        onOpenFeaturedArtisans: () => setState(() => _buyerStep = 9),
        onOpenArtisanProfile: () => setState(() => _buyerStep = 10),
        onOpenBusinessSourcing: () => setState(() => _buyerStep = 11),
        onTabChange: (idx) {
          if (idx == 0) setState(() => _buyerStep = 5);
          if (idx == 1) setState(() => _buyerStep = 6);
          if (idx == 2) setState(() => _buyerStep = 12);
          if (idx == 3) setState(() => _buyerStep = 20);
          if (idx == 4) setState(() => _buyerStep = 21);
        },
      );
    }

    // Screen d2: Bulk Buyer Search & Voice Search Screen (matching d2 - bulk— Search.png)
    if (_buyerStep == 7) {
      return BuyerSearchScreen(
        onBack: () => setState(() => _buyerStep = 6),
        onSelectQuery: (query) => setState(() {
          _buyerSearchQuery = query;
          _buyerStep = 8;
        }),
        onVoiceSearch: () => setState(() {
          _buyerSearchQuery = 'Bamboo fruit baskets';
          _buyerStep = 8;
        }),
        onTabChange: (idx) {
          if (idx == 0) setState(() => _buyerStep = 5);
          if (idx == 1) setState(() => _buyerStep = 6);
          if (idx == 2) setState(() => _buyerStep = 12);
          if (idx == 3) setState(() => _buyerStep = 20);
          if (idx == 4) setState(() => _buyerStep = 21);
        },
      );
    }

    // Screen d3: Bulk Buyer Search Results Screen (matching d3 - bulk — Search Results.png)
    if (_buyerStep == 8) {
      return BuyerSearchResultsScreen(
        searchQuery: _buyerSearchQuery,
        onBack: () => setState(() => _buyerStep = 7),
        onViewArtisanProfile: () => setState(() => _buyerStep = 10),
        onAddRequirement: () => setState(() => _buyerStep = 13),
        onTabChange: (idx) {
          if (idx == 0) setState(() => _buyerStep = 5);
          if (idx == 1) setState(() => _buyerStep = 6);
          if (idx == 2) setState(() => _buyerStep = 12);
          if (idx == 3) setState(() => _buyerStep = 20);
          if (idx == 4) setState(() => _buyerStep = 21);
        },
      );
    }

    // Screen d4: Featured Master Artisans Screen (matching d4 - bulk — Featured Artisans - pagr from discover page flow.png)
    if (_buyerStep == 9) {
      return BuyerFeaturedArtisansScreen(
        onBack: () => setState(() => _buyerStep = 6),
        onOpenArtisanProfile: () => setState(() => _buyerStep = 10),
        onTabChange: (idx) {
          if (idx == 0) setState(() => _buyerStep = 5);
          if (idx == 1) setState(() => _buyerStep = 6);
          if (idx == 2) setState(() => _buyerStep = 12);
          if (idx == 3) setState(() => _buyerStep = 20);
          if (idx == 4) setState(() => _buyerStep = 21);
        },
      );
    }

    // Screen d5: Public Artisan Profile Screen (matching d5 bulk — Public Artisan Profile.png)
    if (_buyerStep == 10) {
      return BuyerArtisanProfileScreen(
        onBack: () => setState(() => _buyerStep = 6),
        onSendRequirement: () => setState(() => _buyerStep = 13),
        onTabChange: (idx) {
          if (idx == 0) setState(() => _buyerStep = 5);
          if (idx == 1) setState(() => _buyerStep = 6);
          if (idx == 2) setState(() => _buyerStep = 12);
          if (idx == 3) setState(() => _buyerStep = 20);
          if (idx == 4) setState(() => _buyerStep = 21);
        },
      );
    }

    // Screen d6: Popular Business Sourcing Screen (matching d6 bulk— Popular Business Sourcing.png)
    if (_buyerStep == 11) {
      return BuyerBusinessSourcingScreen(
        onBack: () => setState(() => _buyerStep = 6),
        onTabChange: (idx) {
          if (idx == 0) setState(() => _buyerStep = 5);
          if (idx == 1) setState(() => _buyerStep = 6);
          if (idx == 2) setState(() => _buyerStep = 12);
          if (idx == 3) setState(() => _buyerStep = 20);
          if (idx == 4) setState(() => _buyerStep = 21);
        },
      );
    }

    // Screen r1: Buyer Bulk Requirements Dashboard (matching r1-bulk — Requirements.png)
    if (_buyerStep == 12) {
      return BuyerRequirementsScreen(
        onBackToHome: () => setState(() => _buyerStep = 5),
        onCreateRequirement: () => setState(() => _buyerStep = 13),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
        onViewDetails: (reqId) => setState(() => _buyerStep = 17),
      );
    }

    // Screen r2: Voice Post Bulk Requirement (matching r2- bulk — Voice-First Requirement Description.png)
    if (_buyerStep == 13) {
      return BuyerVoiceRequirementScreen(
        onBack: () => setState(() => _buyerStep = 12),
        onContinue: () => setState(() => _buyerStep = 14),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen r7-bulk: Post Bulk Requirement Step 2 of 3 (matching r7-bulk ai artisan matching in bulk side.png)
    if (_buyerStep == 14) {
      return BuyerRequirementStep2Screen(
        onBack: () => setState(() => _buyerStep = 13),
        onContinue: () => setState(() => _buyerStep = 15),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen r4: Reference Image Upload (matching r4- bulk  — Reference Image.png)
    if (_buyerStep == 15) {
      return BuyerReferenceImageScreen(
        onBack: () => setState(() => _buyerStep = 14),
        onContinue: () => setState(() => _buyerStep = 16),
        onSkip: () => setState(() => _buyerStep = 16),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen r3: Create Bulk Requirement Review (matching r3-bulk — Create Bulk Requirement review.png)
    if (_buyerStep == 16) {
      return BuyerRequirementReviewScreen(
        onBack: () => setState(() => _buyerStep = 15),
        onContinue: () => setState(() => _buyerStep = 17),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen r5: Matched Artisans (matching r5-bulk— Find Artisan Matches.png)
    if (_buyerStep == 17) {
      return BuyerMatchedArtisansScreen(
        onBack: () => setState(() => _buyerStep = 16),
        onCompare: () => setState(() => _buyerStep = 18),
        onViewArtisan: (id) => setState(() => _buyerStep = 19),
        onMessageArtisan: (id) => setState(() => _buyerStep = 23),
        onPlaceOrder: (id) => setState(() => _buyerStep = 20),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen r6: Compare Artisans (matching r6-bulk — Artisan Match & Comparison.png)
    if (_buyerStep == 18) {
      return BuyerCompareArtisansScreen(
        onBack: () => setState(() => _buyerStep = 17),
        onSelectArtisan: (id) => setState(() => _buyerStep = 20),
        onMessageArtisans: () => setState(() => _buyerStep = 23),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen r8: Selected Artisan (matching r8-bulk — Selected Artisan.png)
    if (_buyerStep == 19) {
      return BuyerSelectedArtisanScreen(
        onBack: () => setState(() => _buyerStep = 17),
        onSelectAndReviewOrder: () => setState(() => _buyerStep = 20),
        onMessageArtisan: () => setState(() => _buyerStep = 23),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen: Enterprise Buyer Orders Hub
    if (_buyerStep == 20) {
      return BuyerOrdersHubScreen(
        onBack: () => setState(() => _buyerStep = 5),
        onViewOrderDetails: (orderId) => setState(() {
          _selectedBuyerOrderId = orderId;
          _buyerStep = 22;
        }),
        onMessageArtisan: (orderId) => setState(() {
          _buyerStep = 23;
        }),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen: Enterprise Buyer Profile
    if (_buyerStep == 21) {
      return BuyerProfileScreen(
        onBack: () => setState(() => _buyerStep = 5),
        onLogOut: () => setState(() {
          _buyerStep = 0;
          _isLoggedIn = false;
        }),
        onEditProfile: () => setState(() => _buyerStep = 25),
        onNavTap: (idx) {
          if (idx == 0) setState(() => _buyerStep = 5);
          if (idx == 1) setState(() => _buyerStep = 6);
          if (idx == 2) setState(() => _buyerStep = 12);
          if (idx == 3) setState(() => _buyerStep = 20);
          if (idx == 4) setState(() => _buyerStep = 21);
        },
      );
    }

    // Screen: Enterprise Buyer & Artisan Profile Management
    if (_buyerStep == 25) {
      return ProfileManagementScreen(
        buyerModel: _buyerModel,
        artisanState: _state,
        initialRole: UserRole.buyer,
        onBack: () => setState(() => _buyerStep = 21),
        onBuyerSaved: (updatedBuyer) {
          setState(() {
            _buyerModel = updatedBuyer;
          });
        },
        onArtisanSaved: (updatedArtisan) {
          setState(() {
            _state = updatedArtisan;
          });
        },
      );
    }

    // Screen: Enterprise Buyer Order Details & Escrow Milestones
    if (_buyerStep == 22) {
      return BuyerOrderDetailsScreen(
        orderId: _selectedBuyerOrderId,
        onBack: () => setState(() => _buyerStep = 20),
        onMessageArtisan: () => setState(() => _buyerStep = 23),
        onOpenHome: () => setState(() => _buyerStep = 5),
        onOpenDiscover: () => setState(() => _buyerStep = 6),
        onOpenRequirements: () => setState(() => _buyerStep = 12),
        onOpenOrders: () => setState(() => _buyerStep = 20),
        onOpenProfile: () => setState(() => _buyerStep = 21),
      );
    }

    // Screen: Enterprise Buyer vs Artisan Real-time Chat
    if (_buyerStep == 23) {
      return BuyerArtisanChatScreen(
        onBack: () => setState(() => _buyerStep = 20),
        onViewOrder: () => setState(() => _buyerStep = 22),
        onOpenConversations: () => setState(() => _buyerStep = 24),
      );
    }

    // Screen: Buyer Discussions / Conversations Hub
    if (_buyerStep == 24) {
      return ConversationsListScreen(
        userRole: 'buyer',
        currentUserName: 'FabIndia Sourcing Hub',
        onBack: () => setState(() => _buyerStep = 23),
        onOpenConversation: (conv) {
          setState(() {
            _buyerStep = 23;
          });
        },
      );
    }

    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          _currentFlowIndex = index;
        });
      },
      children: [
        // Screen 0: Splash & Brand Welcome Screen
        SplashWelcomeScreen(
          onGetStarted: _nextPage,
        ),

        // Screen 1: Language Selection
        LanguageSelectionScreen(
          state: _state,
          onStateChanged: _updateState,
          onBack: _previousPage,
          onContinue: _nextPage,
        ),

        // Screen 2: Role Selection
        RoleSelectionScreen(
          state: _state,
          onStateChanged: _updateState,
          onBack: _previousPage,
          onContinue: _handleRoleContinue,
        ),

        // Screen 3: Step 1 of 5 - Create Account (with 'Already have account' login link)
        AccountCreationScreen(
          state: _state,
          onStateChanged: _updateState,
          onBack: _previousPage,
          onContinue: _nextPage,
          onAlreadyHaveAccount: _goToLoginScreen,
        ),

        // Screen 4: Step 2 of 5 - Voice Intro
        VoiceIntroScreen(
          state: _state,
          onStateChanged: _updateState,
          onBack: _previousPage,
          onContinue: _nextPage,
        ),

        // Screen 5: Step 3 of 5 - Craft Selection
        CraftSelectionScreen(
          state: _state,
          onStateChanged: _updateState,
          onBack: _previousPage,
          onContinue: _nextPage,
        ),

        // Screen 6: Step 4 of 5 - Profile Photo
        ProfilePhotoScreen(
          state: _state,
          onStateChanged: _updateState,
          onBack: _previousPage,
          onContinue: _nextPage,
        ),

        // Screen 7: Step 5 of 5 - Profile Preview & Go to Home Screen
        ProfilePreviewScreen(
          state: _state,
          onStateChanged: _updateState,
          onBack: _previousPage,
          onComplete: _completeOnboardingAndGoHome,
        ),
      ],
    );
  }
}
