import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/screen/place_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.placesList});

  final List<Place> placesList;

  @override
  Widget build(BuildContext context) {
    if (placesList.isEmpty) {
      return Center(
        child: Text(
          'No Places found',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
      itemCount: placesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(
              placesList[index].imageFile,
            ),
          ),
          title: Text(
            placesList[index].title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          subtitle: Text(
            placesList[index].location.address,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PlaceDetails(
                  place: placesList[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
