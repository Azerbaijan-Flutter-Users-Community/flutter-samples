import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hits_provider.dart';
import '../widgets/list_item.dart';

class ImagesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
      body: RefreshIndicator(
        onRefresh: Provider.of<HitsProvider>(context, listen: false).getNewHints,
        child: FutureBuilder(
        future: Provider.of<HitsProvider>(context, listen: false).getHits(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          } else {
            if(snapshot.hasData == null) {
              return Center(child: Text('Error has occured'),);
            } else {
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Consumer<HitsProvider>(
                builder: (context, data, _child){
                  return ListView.builder(
                itemBuilder: (ctx, index) => ListItem(data.hits[index]),
                itemCount: data.hits.length,
              );
                },
              ),
              );
            }
          } 
        },
      ),
      )
      );
  }
}