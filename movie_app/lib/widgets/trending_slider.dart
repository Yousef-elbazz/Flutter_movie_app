import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movie_details/details_screen.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/networking/api_constants.dart';
import 'package:movie_app/colors.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({super.key, required this.snapshot});

  final AsyncSnapshot<List<MovieModel>> snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
          height: 450,
          autoPlay: true,
          viewportFraction: 0.75,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    movie: snapshot.data![itemIndex],
                    movieId: snapshot.data![itemIndex].movieId,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 24, bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${ApiConstants.baseImageUrl}${snapshot.data![itemIndex].posterPath}',
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colours.scaffoldBgColor.withOpacity(1),
                            Colours.scaffoldBgColor.withOpacity(0.0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0.0, 0.4],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

