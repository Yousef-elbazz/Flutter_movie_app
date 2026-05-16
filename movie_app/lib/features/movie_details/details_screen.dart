import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/trailer_model.dart';
import 'package:movie_app/networking/api_constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.movie, required this.movieId});

  final MovieModel movie;
  final int movieId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<TrailerModel> _trailerFuture;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _trailerFuture = Api().getTrailer(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
            ),
            expandedHeight: 500,
            pinned: true,
            floating: true,
            backgroundColor: Colours.scaffoldBgColor,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
              title: Text(
                widget.movie.title,
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black.withOpacity(0.8), blurRadius: 10, offset: const Offset(0, 3)),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    '${ApiConstants.baseImageUrl}${widget.movie.posterPath}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colours.scaffoldBgColor,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.0, 0.5],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.calendar_month_rounded,
                        text: widget.movie.releaseDate,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        icon: Icons.star_rounded,
                        iconColor: Colours.ratingColor,
                        text: '${widget.movie.voteAverage.toStringAsFixed(1)}/10',
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Storyline',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.movie.overView,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Trailer',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<TrailerModel>(
                    future: _trailerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colours.accentColor),
                        );
                      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.results.isEmpty) {
                        return const Center(
                          child: Text("Trailer not available", style: TextStyle(color: Colors.white54)),
                        );
                      } else {
                        final trailer = snapshot.data!.results.firstWhere(
                          (video) => video.type == "Trailer" && video.site == "YouTube",
                          orElse: () => snapshot.data!.results.first,
                        );

                        final videoId = trailer.key;
                        _controller = YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: const YoutubePlayerFlags(
                            autoPlay: false,
                          ),
                        );

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colours.accentColor,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text, Color iconColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colours.cardBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
