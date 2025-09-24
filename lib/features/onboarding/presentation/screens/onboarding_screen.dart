import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/storage_service.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to Ethiopian SUQ',
      description: 'Discover amazing products from local sellers across Ethiopia. Shop with confidence and support local businesses.',
      icon: Icons.shopping_bag_outlined,
      color: AppTheme.primaryGreen,
    ),
    OnboardingPage(
      title: 'Earn XP & Unlock Badges',
      description: 'Every purchase, sale, and review earns you XP. Level up and unlock exclusive badges to show off your achievements!',
      icon: Icons.military_tech,
      color: AppTheme.xpBlue,
    ),
    OnboardingPage(
      title: 'Become a Seller',
      description: 'Turn your passion into profit! Set up your shop, manage inventory, and start selling to customers nationwide.',
      icon: Icons.store,
      color: AppTheme.primaryYellow,
    ),
    OnboardingPage(
      title: 'Ethiopian Payment Methods',
      description: 'Pay easily with Telebirr, CBE Birr, or choose Cash on Delivery. We support the payment methods you trust.',
      icon: Icons.payment,
      color: AppTheme.primaryRed,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    await StorageService.setOnboardingCompleted();
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Progress indicator
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentPage
                              ? AppTheme.primaryGreen
                              : AppTheme.lightGrey,
                        ),
                      )
                          .animate()
                          .scale(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          ),
                    ),
                  ),
                  
                  // Skip button
                  TextButton(
                    onPressed: _skipOnboarding,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: AppTheme.mediumGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon with animated background
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: page.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page.icon,
                            size: 80,
                            color: page.color,
                          ),
                        )
                            .animate()
                            .scale(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.elasticOut,
                            )
                            .fadeIn(duration: const Duration(milliseconds: 400)),

                        const SizedBox(height: 48),

                        // Title
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkGrey,
                              ),
                        )
                            .animate(delay: const Duration(milliseconds: 200))
                            .slideY(
                              begin: 0.3,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOut,
                            )
                            .fadeIn(duration: const Duration(milliseconds: 600)),

                        const SizedBox(height: 24),

                        // Description
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppTheme.mediumGrey,
                                height: 1.5,
                              ),
                        )
                            .animate(delay: const Duration(milliseconds: 400))
                            .slideY(
                              begin: 0.3,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOut,
                            )
                            .fadeIn(duration: const Duration(milliseconds: 600)),

                        const SizedBox(height: 48),

                        // XP simulation for gamification page
                        if (index == 1) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.xpBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppTheme.xpBlue.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.stars,
                                  color: AppTheme.xpBlue,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '+10 XP',
                                  style: TextStyle(
                                    color: AppTheme.xpBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          )
                              .animate(delay: const Duration(milliseconds: 800))
                              .scale(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.elasticOut,
                              )
                              .fadeIn(duration: const Duration(milliseconds: 300)),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  // Previous button
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousPage,
                        child: const Text('Previous'),
                      ),
                    ),
                  
                  if (_currentPage > 0) const SizedBox(width: 16),

                  // Next/Get Started button
                  Expanded(
                    flex: _currentPage == 0 ? 1 : 1,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _pages[_currentPage].color,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
