import 'package:flutter/material.dart';

void main() {
  runApp(const MoChatApp());
}

class MoChatApp extends StatelessWidget {
  const MoChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoChat',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFD8C3A5),
        fontFamily: 'Roboto',
      ),
      home: const RoomsPage(),
    );
  }
}

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  final List<Map<String, dynamic>> rooms = const [
    {'name': 'Общение', 'online': 24},
    {'name': 'Знакомства', 'online': 18},
    {'name': 'Друзья', 'online': 12},
    {'name': 'Флирт', 'online': 9},
    {'name': 'Музыка', 'online': 7},
    {'name': 'Отдых', 'online': 5},
    {'name': 'Тюрьма', 'online': 0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 18),
              child: Text(
                'MoChat',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(color: Colors.black, height: 1),
            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];

                  return InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Комната: ${room['name']}'),
                        ),
                      );
                    },
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              room['name'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Text(
                            '${room['online']}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
