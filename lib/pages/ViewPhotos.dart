import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/Model/photos.dart';
import 'package:registration_practice/state/photoProvider.dart';

class AllPhotos extends ConsumerWidget{

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue <List<Photos>> photos = watch(photoStateFuture);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('River Pod Future Implementation'),),
      body: photos.when(data: (photos){
        return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(photos[index].thumbnailUrl),
                    ),
                    title: Text('${photos[index].id}. ${photos[index].title}'),
                  )
                ],
              );
            });
      }, loading: () => const Center(child: CircularProgressIndicator())
          , error: (err, stack) => Center(child: Text('error is ${err.toString()}'))),
    );
  }
}