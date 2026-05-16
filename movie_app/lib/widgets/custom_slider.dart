import 'package:flutter/material.dart';
import 'package:movie_app/features/movie_details/details_screen.dart';
import 'package:movie_app/networking/api_constants.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      movie: snapshot.data[index],
                      movieId: snapshot.data![index].movieId,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 220,
                    width: 140,
                    child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${ApiConstants.baseImageUrl}${snapshot.data[index].posterPath}',
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
