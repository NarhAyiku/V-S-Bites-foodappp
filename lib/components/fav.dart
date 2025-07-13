import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> likedItems = [];

  @override
  void initState() {
    super.initState();
    _loadLikedItems();
  }

  Future<void> _loadLikedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList('liked_items') ?? [];
    setState(() {
      likedItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: likedItems.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.builder(
              itemCount: likedItems.length,
              itemBuilder: (context, index) {
                final food = likedItems[index];
                return ListTile(
                  title: Text("Item ID: $food"), 
                  trailing: const Icon(Icons.favorite, color: Colors.red),
                );
              },
            ),
    );
  }
}
