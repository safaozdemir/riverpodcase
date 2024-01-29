import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/userModel.dart';

final katilimciListProvider =
StateNotifierProvider<KatilimciListNotifier, List<UserModel>>(
      (ref) => KatilimciListNotifier(),
);

class KatilimciListNotifier extends StateNotifier<List<UserModel>> {
  KatilimciListNotifier() : super([]) {
    fetchKatilimcilar();
  }

  Future<void> fetchKatilimcilar() async {
    try {
      var response = await http.get(Uri.parse('https://reqres.in/api/users'));
      if (response.statusCode == 200) {
        List<dynamic> katilimcilarJson = jsonDecode(response.body)['data'];
        state = katilimcilarJson
            .map((json) => UserModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load katilimcilar');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
