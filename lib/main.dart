import 'package:flutter/material.dart';
import 'api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: FutureBuilder<List<dynamic>>(
            future: apiService.Posts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final post = snapshot.data![index];
                      return ListTile(
                        title: Text(post['title']),
                        subtitle: Text(post['body']),
                      );
                    });
              }
            }),
      ),
    );
  }
}
