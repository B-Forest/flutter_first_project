import 'package:flutter/material.dart';
import '../services/omdb_service.dart';

class Filmlist extends StatefulWidget {
  const Filmlist({Key? key}) : super(key: key);

  @override
  _FilmlistState createState() => _FilmlistState();
}

class _FilmlistState extends State<Filmlist> {
  final TextEditingController controller = TextEditingController();
  final OmdbService api = OmdbService();

  List<dynamic> movies = [];
  bool loading = false;

  // Mode de tri : true = récents d'abord, false = anciens d'abord
  bool sortDescending = true;

  void search() async {
    setState(() => loading = true);
    final results = await api.searchMovies(controller.text);

    // Trier les films selon le mode choisi
    results.sort((a, b) {
      int yearA = OmdbService.parseYear(a["Year"]);
      int yearB = OmdbService.parseYear(b["Year"]);
      return sortDescending
          ? yearB.compareTo(yearA) // récents → anciens
          : yearA.compareTo(yearB); // anciens → récents
    });

    setState(() {
      movies = results;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Films OMDb"),
        actions: [
          PopupMenuButton<bool>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                sortDescending = value;
                // relancer le tri sans refaire la requête
                movies.sort((a, b) {
                  int yearA = OmdbService.parseYear(a["Year"]);
                  int yearB = OmdbService.parseYear(b["Year"]);
                  return sortDescending
                      ? yearB.compareTo(yearA)
                      : yearA.compareTo(yearB);
                });
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: true,
                child: Text("Plus récents → anciens"),
              ),
              const PopupMenuItem(
                value: false,
                child: Text("Plus anciens → récents"),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Rechercher un film",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: search,
                ),
              ),
            ),
            const SizedBox(height: 10),
            loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: movies.isEmpty
                  ? const Center(child: Text("Aucun film trouvé"))
                  : ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Card(
                    margin:
                    const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: movie["Poster"] != "N/A"
                          ? Image.network(
                        movie["Poster"],
                        width: 50,
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.movie),
                      title: Text(movie["Title"] ?? "Sans titre"),
                      subtitle: Text(movie["Year"] ?? ""),
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
