import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  State<ManageOrdersScreen> createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> _mockOrders = [
    {
      'id': 'ORD-001',
      'customerName': 'Sarah Johnson',
      'customerPhone': '+251911234567',
      'productName': 'Ethiopian Coffee Beans',
      'quantity': 2,
      'amount': 900.0,
      'status': 'pending',
      'date': '2024-01-20',
      'address': 'Bole, Addis Ababa',
      'paymentMethod': 'Telebirr',
    },
    {
      'id': 'ORD-002',
      'customerName': 'Michael Chen',
      'customerPhone': '+251922345678',
      'productName': 'Traditional Habesha Dress',
      'quantity': 1,
      'amount': 2500.0,
      'status': 'processing',
      'date': '2024-01-19',
      'address': 'Piazza, Addis Ababa',
      'paymentMethod': 'CBE Birr',
    },
    {
      'id': 'ORD-003',
      'customerName': 'Emma Wilson',
      'customerPhone': '+251933456789',
      'productName': 'Smartphone Case',
      'quantity': 3,
      'amount': 360.0,
      'status': 'shipped',
      'date': '2024-01-18',
      'address': 'Kazanchis, Addis Ababa',
      'paymentMethod': 'Cash on Delivery',
    },
    {
      'id': 'ORD-004',
      'customerName': 'Ahmed Hassan',
      'customerPhone': '+251944567890',
      'productName': 'Bluetooth Headphones',
      'quantity': 1,
      'amount': 1200.0,
      'status': 'delivered',
      'date': '2024-01-17',
      'address': 'Merkato, Addis Ababa',
      'paymentMethod': 'Telebirr',
    },
    {
      'id': 'ORD-005',
      'customerName': 'Fatima Ali',
      'customerPhone': '+251955678901',
      'productName': 'Laptop Bag',
      'quantity': 1,
      'amount': 800.0,
      'status': 'cancelled',
      'date': '2024-01-16',
      'address': 'CMC, Addis Ababa',
      'paymentMethod': 'CBE Birr',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Processing'),
            Tab(text: 'Shipped'),
            Tab(text: 'Delivered'),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList('all'),
                _buildOrdersList('pending'),
                _buildOrdersList('processing'),
                _buildOrdersList('shipped'),
                _buildOrdersList('delivered'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search orders...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'date_desc',
                child: Text('Newest First'),
              ),
              const PopupMenuItem(
                value: 'date_asc',
                child: Text('Oldest First'),
              ),
              const PopupMenuItem(
                value: 'amount_desc',
                child: Text('Highest Amount'),
              ),
              const PopupMenuItem(
                value: 'amount_asc',
                child: Text('Lowest Amount'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String status) {
    final filteredOrders = status == 'all'
        ? _mockOrders
        : _mockOrders.where((order) => order['status'] == status).toList();

    if (filteredOrders.isEmpty) {
      return _buildEmptyState(status);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return _OrderCard(
          order: order,
          animationDelay: Duration(milliseconds: index * 100),
          onStatusUpdate: _updateOrderStatus,
        );
      },
    );
  }

  Widget _buildEmptyState(String status) {
    String message;
    IconData icon;

    switch (status) {
      case 'pending':
        message = 'No pending orders';
        icon = Icons.hourglass_empty;
        break;
      case 'processing':
        message = 'No orders being processed';
        icon = Icons.sync;
        break;
      case 'shipped':
        message = 'No shipped orders';
        icon = Icons.local_shipping;
        break;
      case 'delivered':
        message = 'No delivered orders';
        icon = Icons.check_circle_outline;
        break;
      default:
        message = 'No orders found';
        icon = Icons.receipt_long_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Orders will appear here as customers place them',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
          ),
        ],
      ),
    );
  }

  void _updateOrderStatus(String orderId, String newStatus) {
    setState(() {
      final orderIndex =
          _mockOrders.indexWhere((order) => order['id'] == orderId);
      if (orderIndex != -1) {
        _mockOrders[orderIndex]['status'] = newStatus;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order $orderId updated to $newStatus'),
        backgroundColor: AppTheme.success,
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final Duration animationDelay;
  final Function(String, String) onStatusUpdate;

  const _OrderCard({
    required this.order,
    required this.animationDelay,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final status = order['status'] as String;
    final statusColor = _getStatusColor(status);
    final statusText = _getStatusText(status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order['id'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    order['customerName'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.mediumGrey,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  order['productName'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Text(
                '${order['amount'].toStringAsFixed(0)} ETB',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Customer Phone', order['customerPhone']),
                _buildDetailRow('Quantity', '${order['quantity']}'),
                _buildDetailRow('Delivery Address', order['address']),
                _buildDetailRow('Payment Method', order['paymentMethod']),
                _buildDetailRow('Order Date', order['date']),
                const SizedBox(height: 16),
                _buildActionButtons(context, order['id'], status),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(delay: animationDelay)
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideX(begin: 0.2, curve: Curves.easeOut);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.mediumGrey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, String orderId, String status) {
    switch (status) {
      case 'pending':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showCancelDialog(context, orderId),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.error,
                  side: BorderSide(color: AppTheme.error),
                ),
                child: const Text('Decline'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => onStatusUpdate(orderId, 'processing'),
                child: const Text('Accept'),
              ),
            ),
          ],
        );
      case 'processing':
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => onStatusUpdate(orderId, 'shipped'),
            icon: const Icon(Icons.local_shipping),
            label: const Text('Mark as Shipped'),
          ),
        );
      case 'shipped':
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => onStatusUpdate(orderId, 'delivered'),
            icon: const Icon(Icons.check_circle),
            label: const Text('Mark as Delivered'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.success,
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _showCancelDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text('Are you sure you want to cancel this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onStatusUpdate(orderId, 'cancelled');
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return AppTheme.primaryYellow;
      case 'processing':
        return AppTheme.xpBlue;
      case 'shipped':
        return AppTheme.primaryGreen;
      case 'delivered':
        return AppTheme.success;
      case 'cancelled':
        return AppTheme.error;
      default:
        return AppTheme.mediumGrey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'PENDING';
      case 'processing':
        return 'PROCESSING';
      case 'shipped':
        return 'SHIPPED';
      case 'delivered':
        return 'DELIVERED';
      case 'cancelled':
        return 'CANCELLED';
      default:
        return status.toUpperCase();
    }
  }
}
