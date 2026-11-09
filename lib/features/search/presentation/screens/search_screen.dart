import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/features/search/presentation/providers/search_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  Timer? debounce;

  String searchQuery = '';

  @override
  void dispose() {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = searchQuery.trim().isEmpty
        ? null
        : ref.watch(searchMoviesProvider(searchQuery));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Search", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search movies...",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                debounce?.cancel();

                debounce = Timer(Duration(milliseconds: 500), () {
                  setState(() {
                    searchQuery = value.trim();
                  });
                });
              },
            ),
          ),

          Expanded(
            child: searchState == null
                ? Center(
                    child: Text(
                      "Search for your favourite movies",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : searchState.when(
                    loading: () {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(
                          "Something went wrong",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    data: (movies) {
                      if (movies.isEmpty) {
                        return Center(
                          child: Text(
                            "No movies found",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          return ListTile(
                            onTap: () {
                              context.push('/movie/${movie.id}');
                            },

                            leading: movie.posterPath != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                    width: 60,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      width: 60,
                                      height: 90,
                                      color: Colors.grey.shade900,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: 60,
                                          height: 90,
                                          color: Colors.grey.shade900,
                                          child: Icon(
                                            Icons.movie,
                                            color: Colors.white,
                                          ),
                                        ),
                                  )
                                : SizedBox(
                                    width: 60,
                                    child: Icon(
                                      Icons.movie,
                                      color: Colors.grey,
                                    ),
                                  ),

                            title: Text(
                              movie.title,
                              style: TextStyle(color: Colors.white),
                            ),

                            subtitle: Text(
                              movie.releaseDate,
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
