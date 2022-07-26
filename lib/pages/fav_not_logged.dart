import 'package:flutter/material.dart';

class FavoriteNotLogged extends StatelessWidget {
  const FavoriteNotLogged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 120,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Musisz się najpierw ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'zalogować',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
