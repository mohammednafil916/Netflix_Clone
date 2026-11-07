import 'package:go_router/go_router.dart';
import 'package:netflix_clone/features/home/presentation/screens/home_screen.dart';
import 'package:netflix_clone/features/movie_details/presentation/screens/movie_details_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return HomeScreen();
      },
    ),

    GoRoute(
      path: '/movie/:id',
      builder: (context, state) {
        final movieId = int.parse(state.pathParameters['id']!);

        return MovieDetailsScreen(movieId: movieId);
      },
    ),
  ],
);
