import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/product_grid_item.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_chips.dart';

class BrowseProductsScreen extends StatefulWidget {
  const BrowseProductsScreen({super.key});

  @override
  State<BrowseProductsScreen> createState() => _BrowseProductsScreenState();
}

class _BrowseProductsScreenState extends State<BrowseProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _sortBy = 'Popular';
  bool _showFilters = false;

  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Books',
    'Sports',
    'Beauty',
    'Food & Drinks',
  ];

  final List<String> _sortOptions = [
    'Popular',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
    'Rating',
  ];

  // Mock products for demo
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Ethiopian Coffee Beans Premium',
      'price': 450.0,
      'originalPrice': 500.0,
      'imageUrl': 'https://via.placeholder.com/200x200/8BC34A/FFFFFF?text=Coffee',
      'sellerName': 'Addis Coffee Co.',
      'rating': 4.8,
      'reviewsCount': 124,
      'category': 'Food & Drinks',
      'isOnSale': true,
    },
    {
      'id': '2',
      'name': 'Traditional Habesha Dress',
      'price': 2500.0,
      'originalPrice': null,
      'imageUrl': 'https://via.placeholder.com/200x200/E91E63/FFFFFF?text=Dress',
      'sellerName': 'Ethiopian Fashion',
      'rating': 4.6,
      'reviewsCount': 89,
      'category': 'Fashion',
      'isOnSale': false,
    },
    {
      'id': '3',
      'name': 'Smartphone Case',
      'price': 120.0,
      'originalPrice': 150.0,
      'imageUrl': 'https://via.placeholder.com/200x200/2196F3/FFFFFF?text=Phone',
      'sellerName': 'Tech Accessories',
      'rating': 4.5,
      'reviewsCount': 67,
      'category': 'Electronics',
      'isOnSale': true,
    },
    {
      'id': '4',
      'name': 'Ethiopian History Book',
      'price': 350.0,
      'originalPrice': null,
      'imageUrl': 'https://via.placeholder.com/200x200/FF9800/FFFFFF?text=Book',
      'sellerName': 'Knowledge Books',
      'rating': 4.7,
      'reviewsCount': 45,
      'category': 'Books',
      'isOnSale': false,
    },
    {
      'id': '5',
      'name': 'Yoga Mat',
      'price': 800.0,
      'originalPrice': 950.0,
      'imageUrl': 'https://via.placeholder.com/200x200/9C27B0/FFFFFF?text=Yoga',
      'sellerName': 'Fitness Store',
      'rating': 4.4,
      'reviewsCount': 78,
      'category': 'Sports',
      'isOnSale': true,
    },
    {
      'id': '6',
      'name': 'Natural Skincare Set',
      'price': 650.0,
      'originalPrice': null,
      'imageUrl': 'https://via.placeholder.com/200x200/4CAF50/FFFFFF?text=Beauty',
      'sellerName': 'Natural Beauty',
      'rating': 4.9,
      'reviewsCount': 156,
      'category': 'Beauty',
      'isOnSale': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    var filtered = _products.where((product) {
      final matchesCategory = _selectedCategory == 'All' || 
          product['category'] == _selectedCategory;
      final matchesSearch = _searchController.text.isEmpty ||
          product['name'].toLowerCase().contains(_searchController.text.toLowerCase());
      
      return matchesCategory && matchesSearch;
    }).toList();

    // Sort products
    switch (_sortBy) {
      case 'Price: Low to High':
        filtered.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 'Price: High to Low':
        filtered.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 'Rating':
        filtered.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Newest':
        // Keep original order for demo
        break;
      default: // Popular
        filtered.sort((a, b) => b['reviewsCount'].compareTo(a['reviewsCount']));
    }

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Products'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            icon: Icon(
              _showFilters ? Icons.filter_list_off : Icons.filter_list,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          SearchBarWidget(
            controller: _searchController,
            onChanged: (value) {
              setState(() {});
            },
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 400))
              .slideY(begin: -0.2, curve: Curves.easeOut),

          // Filters
          if (_showFilters) ...[
            FilterChips(
              categories: _categories,
              selectedCategory: _selectedCategory,
              sortOptions: _sortOptions,
              selectedSort: _sortBy,
              onCategoryChanged: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              onSortChanged: (sort) {
                setState(() {
                  _sortBy = sort;
                });
              },
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 300))
                .slideY(begin: -0.1, curve: Curves.easeOut),
          ],

          // Results count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '${filteredProducts.length} products found',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.mediumGrey,
                      ),
                ),
                const Spacer(),
                if (filteredProducts.isNotEmpty)
                  Text(
                    'Sorted by $_sortBy',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.mediumGrey,
                        ),
                  ),
              ],
            ),
          ),

          // Products Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductGridItem(
                        product: product,
                        animationDelay: Duration(milliseconds: index * 100),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _selectedCategory = 'All';
                _sortBy = 'Popular';
              });
            },
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 600))
        .scale(curve: Curves.easeOut);
  }
}
