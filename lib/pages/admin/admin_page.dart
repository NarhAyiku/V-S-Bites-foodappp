import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodappp/models/food.dart';
import 'package:foodappp/services/auth/auth_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices _authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.fastfood), text: 'Menu'),
              Tab(icon: Icon(Icons.shopping_cart), text: 'Orders'),
              Tab(icon: Icon(Icons.people), text: 'Users'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _authService.signOut();
                if (!mounted) return;
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildMenuTab(),
            _buildOrdersTab(),
            _buildUsersTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddItemDialog(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildMenuTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('menu').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var item = snapshot.data!.docs[index];
            return ListTile(
              leading: Image.network(item['imagePath'] ?? ''),
              title: Text(item['name'] ?? ''),
              subtitle: Text('${item['price'] ?? 0} GH₵'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditItemDialog(item),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOrdersTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('orders').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var order = snapshot.data!.docs[index];
            return ListTile(
              title: Text('Order #${order.id}'),
              subtitle: Text('Status: ${order['status']}'),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'preparing',
                    child: Text('Preparing'),
                  ),
                  const PopupMenuItem(
                    value: 'delivering',
                    child: Text('Delivering'),
                  ),
                  const PopupMenuItem(
                    value: 'completed',
                    child: Text('Completed'),
                  ),
                ],
                onSelected: (value) {
                  _updateOrderStatus(order.id, value);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUsersTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var user = snapshot.data!.docs[index];
            return ListTile(
              title: Text(user['email'] ?? ''),
              subtitle: Text('Orders: ${user['orderCount'] ?? 0}'),
            );
          },
        );
      },
    );
  }

  void _showAddItemDialog() {
    // Implement add item dialog
  }

  void _showEditItemDialog(DocumentSnapshot item) {
    // Implement edit item dialog
  }

  Future<void> _updateOrderStatus(String orderId, String status) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}