import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/models/pokemon.dart';
import 'package:riverpod_files/providers/dio_provider.dart';

final pokemonListProvider = StateNotifierProvider<PokemonListNotifier, List<Pokemon>>((ref) {
  return PokemonListNotifier(ref);
});

class PokemonListNotifier extends StateNotifier<List<Pokemon>> {
  PokemonListNotifier(this.ref) : super([]);

  final Ref ref;

  Future<void> fetchPokemonList() async {
    final dio = ref.read(dioProvider);
    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=20');
      final List results = response.data['results'];

      state = await Future.wait(results.map((result) async {
        final pokemonResponse = await dio.get(result['url']);
        return Pokemon.fromJson(pokemonResponse.data);
      }).toList());
    } catch (e) {
      // Manejo de errores
      print(e);
    }
  }
}
