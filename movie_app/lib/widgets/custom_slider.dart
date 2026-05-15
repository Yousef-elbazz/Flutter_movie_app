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
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 10,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${ApiConstants.baseImageUrl}${snapshot.data[index].posterPath}',
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
