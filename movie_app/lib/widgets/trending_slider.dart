import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movie_details/details_screen.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/networking/api_constants.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({super.key, required this.snapshot});

  //final AsyncSnapshot snapshot;
  final AsyncSnapshot<List<MovieModel>> snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
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
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: SizedBox(
                width: 200,
                height: 300,
                child: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  '${ApiConstants.baseImageUrl}${snapshot.data![itemIndex].posterPath}',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
