import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflix_clone/features/home/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class FeaturedMovieBanner extends StatelessWidget {
  final List<Movie> movies;

  const FeaturedMovieBanner({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, realIndex) {
        final movie = movies[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Movie backdrop
                if (movie.backdropPath != null)
                  CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey.shade900),
                    errorWidget: (context, url, error) =>
                        Container(color: Colors.grey.shade900),
                  )
                else
                  Container(color: Colors.grey.shade900),

                // Dark gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                        Colors.black,
                      ],
                    ),
                  ),
                ),

                // Movie information
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "FEATURED MOVIE",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        movie.overview,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),

                      SizedBox(height: 12),

                      // Rating and Watch Now button
                      Row(
                        children: [
                          Text(
                            '⭐ ${movie.rating.toStringAsFixed(1)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 20),

                          ElevatedButton.icon(
                            onPressed: () {
                              context.push('/movie/${movie.id}');
                            },
                            icon: Icon(Icons.play_arrow, color: Colors.white),
                            label: Text(
                              "Watch Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 360,
        viewportFraction: 0.78,
        enlargeCenterPage: true,
        enlargeFactor: 0.12,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        enableInfiniteScroll: movies.length > 1,
      ),
    );
  }
}
