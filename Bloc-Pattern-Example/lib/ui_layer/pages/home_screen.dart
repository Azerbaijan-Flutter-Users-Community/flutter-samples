import 'package:flutter/material.dart';
import 'package:learn_bloc_pattern/bloc_layer/bloc_provider.dart';
import 'package:learn_bloc_pattern/bloc_layer/blocs/hit_bloc.dart';
import 'package:learn_bloc_pattern/bloc_layer/events/hit_event.dart';
import 'package:learn_bloc_pattern/bloc_layer/states/hit_state.dart';
import 'package:learn_bloc_pattern/data_layer/models/hit.dart';
import 'package:learn_bloc_pattern/ui_layer/widgets/hit_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hitBloc = BlocProvider.of<HitBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter what you want',
              ),
              onSubmitted: (query) {
                if (query != null && query.trim().isNotEmpty) {
                  hitBloc.hitEventSink.add(GetHitsEvent(query: query));
                } else {
                  hitBloc.hitEventSink.add(EmptyQueryEvent());
                }
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              initialData: hitBloc.initialState,
              stream: hitBloc.hitStateStream,
              builder: (BuildContext context, AsyncSnapshot<HitState> snaphot) {
                if (snaphot.data is HitLoading) {
                  return _buildLoading();
                }

                if (snaphot.data is HitFetched) {
                  return _buildList((snaphot.data as HitFetched).fetchedHits);
                }

                if (snaphot.data is HitError) {
                  return Center(
                      child: Text((snaphot.data as HitError).errorMessage));
                }

                return _buildDefault();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefault() {
    return Center(
      child: Text('Type anything'),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<Hit> hits) {
    return ListView.builder(
      itemBuilder: (context, index) => HitItem(hits[index]),
      itemCount: hits.length,
    );
  }
}
