import 'package:flutter/material.dart';
import 'package:learn_bloc_pattern/bloc_layer/bloc_provider.dart';
import 'package:learn_bloc_pattern/bloc_layer/blocs/hit_bloc.dart';
import 'package:learn_bloc_pattern/bloc_layer/events/hit_event.dart';
import 'package:learn_bloc_pattern/constants/app_constants.dart';
import 'package:learn_bloc_pattern/data_layer/models/hit.dart';
import 'package:learn_bloc_pattern/ui_layer/shared/text_styles.dart';

class HitItem extends StatelessWidget {
  final Hit currentHit;

  HitItem(this.currentHit);

  @override
  Widget build(BuildContext context) {
    final hitBloc = BlocProvider.of<HitBloc>(context);

    return Padding(
        padding: EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
//          child:
          child: Card(
            child: Container(
              width: double.infinity,
              height: 250,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Routes.DETAIL,
                          arguments: currentHit),
                      child: Hero(
                        tag: currentHit.id,
                        child: Image.network(
                          currentHit.webFormatUrl,
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        color: Colors.black87,
                        height: 70,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      currentHit.user,
                                      style: bigTextStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      currentHit.likes.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: normalTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  hitBloc.hitEventSink.add(FavoriteButtonClickedEvent(clickedHit: currentHit));
                                },
                                icon: Icon(
                                  currentHit.isFavorite ?
                                  Icons.favorite
                                  : Icons.favorite_border,
                                ),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
