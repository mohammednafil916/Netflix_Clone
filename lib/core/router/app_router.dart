import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/core/widgets/bottom_nav_bar.dart';
import 'package:netflix_clone/features/home/presentation/screens/home_screen.dart';
import 'package:netflix_clone/features/movie_details/presentation/screens/movie_details_screen.dart';
import 'package:netflix_clone/features/search/presentation/screens/search_screen.dart';
import 'package:netflix_clone/features/downloads/presentation/screens/downloads_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(index);
            },
          ),
        );
      },

      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => HomeScreen()),
          ],
        ),

        // Search Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => SearchScreen(),
            ),
          ],
        ),

        // Downloads Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/downloads',
              builder: (context, state) => DownloadsScreen(),
            ),
          ],
        ),
      ],
    ),

    // Movie Details Route
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) {
        final movieId = int.parse(state.pathParameters['id']!);
        return MovieDetailsScreen(movieId: movieId);
      },
    ),
  ],
);
