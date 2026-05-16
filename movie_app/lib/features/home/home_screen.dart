import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/features/search/search_screen.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/networking/api_constants.dart';
import 'package:movie_app/widgets/Trending_slider.dart';
import 'package:movie_app/widgets/custom_slider.dart';

import 'package:movie_app/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieModel>> trendingMovies;
  late Future<List<MovieModel>> topRatedMovies;
  late Future<List<MovieModel>> upComingMovies;
  late Future<List<MovieModel>> nowPlayingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upComingMovies = Api().getUpComingMovies();
    nowPlayingMovies = Api().getNowPlayingMovies();
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: Colours.accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
        title: Image.asset(
          'assets/flutflix.png',
          fit: BoxFit.cover,
          height: 35,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: FutureBuilder(
                future: trendingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return TrendingSlider(snapshot: snapshot);
                  } else {
                    return const SizedBox(
                      height: 450,
                      child: Center(child: CircularProgressIndicator(color: Colours.accentColor)),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Top Rated Movies'),
            const SizedBox(height: 8),
            SizedBox(
              child: FutureBuilder(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return CustomSlider(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator(color: Colours.accentColor));
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Upcoming Movies'),
            const SizedBox(height: 8),
            SizedBox(
              child: FutureBuilder(
                future: upComingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return CustomSlider(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator(color: Colours.accentColor));
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Now Playing'),
            const SizedBox(height: 8),
            SizedBox(
              child: FutureBuilder(
                future: nowPlayingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return CustomSlider(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator(color: Colours.accentColor));
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
