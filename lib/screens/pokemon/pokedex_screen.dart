import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/state_notifier_provider.dart';

class PokedexScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonList = ref.watch(pokemonListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
      ),
      body: pokemonList.isEmpty
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(pokemonListProvider.notifier).fetchPokemonList();
                },
                child: Text('Load Pokémon'),
              ),
            )
          : ListView.builder(
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonList[index];
                return ListTile(
                  leading: Image.network(pokemon.imageUrl),
                  title: Text(pokemon.name),
                );
              },
            ),
    );
  }
}
