FOREST Benjamin

git clone https://github.com/ton-compte/omdb_flutter_movies.git
cd omdb_flutter_movies

flutter pub get

Créez un compte gratuit sur OMDb API , récupérez votre clé et ajoutez-la dans :
// lib/services/omdb_service.dart
final String apiKey = "VOTRE_API_KEY";

flutter run

Entrez un mot-clé dans la barre de recherche (ex: Batman, Spiderman, Inception).

Appuyez sur 🔍 pour lancer la recherche.

Les films correspondants s’affichent dans une liste avec :

L’affiche (si disponible)

Le titre

L’année de sortie

Cliquez sur l’icône de tri (⚙️ en haut à droite) pour changer l’ordre des résultats (du plus récent au plus ancien ou l’inverse).