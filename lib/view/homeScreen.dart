import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodcase/services/sharedPrefencesService.dart';
import 'package:riverpodcase/view/loginView.dart';

import '../controller/homeScreenController.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final katilimcilar = ref.watch(katilimciListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Katilimcilar List'),
      ),
      body: katilimcilar.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: katilimcilar.length,
        itemBuilder: (context, index) {
          final katilimcilars = katilimcilar[index];
          return ListTile(
            title: Text(katilimcilars.firstName + ' ' + katilimcilars.lastName),
            subtitle: Text(katilimcilars.email),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(katilimcilars.avatar),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await TokenService.removeData();
        Navigator.push(context, MaterialPageRoute(builder: (context) => LogInView()));
      },child: Icon(Icons.output),),
    );
  }
}
