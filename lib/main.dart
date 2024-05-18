import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Product {
  String name;
  String color;
  String size;
  int count;
  double price;

  Product({
    required this.name,
    required this.color,
    required this.size,
    required this.count,
    required this.price
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> cartItems = [
    Product(name: 'Jeans', color: 'Red', size: 'M', count: 1, price: 10.0),
    Product(name: 'Shoe', color: 'Blue', size: 'L', count: 1, price: 20.0),
    Product(name: 'Tshirt', color: 'Green', size: 'S', count: 1, price: 15.0),
  ];

  double getTotalAmount() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price * item.count;
    }
    return total;
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('You have added'),
              Text(
                getTotalItemCount().toString(),
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const Text('item(s) to your bag!'),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDB3022),
                ),
                child: const Text('Ok', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  int getTotalItemCount() {
    int totalCount = 0;
    for (var item in cartItems) {
      totalCount += item.count;
    }
    return totalCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
        color: const Color(0xFFF9F9F9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'My Bag',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  Product item = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5.0,
                      color: Colors.white,
                      child: ListTile(
                        leading: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/${item.name.toLowerCase()}.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        title: Text(item.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Color: ${item.color} Size: ${item.size}'),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (item.count > 0) {
                                        item.count--;
                                      }
                                    });
                                  },
                                ),
                                Text('${item.count}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      item.count++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Text('\$${item.price * item.count}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF9F9F9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total Amount:                       \$${getTotalAmount()}',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  _showCheckoutDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDB3022),
                ),
                child: const Text('Checkout', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
