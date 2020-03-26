import 'package:flutter/material.dart';
import 'package:learn_bloc_pattern/bloc_layer/bloc_provider.dart';
import 'package:learn_bloc_pattern/bloc_layer/blocs/hit_bloc.dart';
import 'package:learn_bloc_pattern/bloc_layer/events/hit_event.dart';
import 'package:learn_bloc_pattern/bloc_layer/states/hit_state.dart';
import 'package:learn_bloc_pattern/data_layer/models/hit.dart';

class DetailScreen extends StatefulWidget {
  final Hit currentHit;

  DetailScreen({@required this.currentHit});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final hitBloc = BlocProvider.of<HitBloc>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.currentHit.user}'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: mediaQuery.size.height * 0.4,
            child: Hero(
              tag: widget.currentHit.id,
              child: Image.network(
                widget.currentHit.webFormatUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(widget.currentHit.likes.toString()),
                IconButton(
                  icon: Icon(
                    widget.currentHit.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  onPressed: () {
                    setState(() {
                      hitBloc.hitEventSink.add(FavoriteButtonClickedEvent(
                          clickedHit: widget.currentHit));
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
