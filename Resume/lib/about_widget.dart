import 'package:flutter/material.dart';
import 'package:resume/responsive_widget.dart';

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      smallScreen: _buildSmallAndMediumWidget(context),
      mediumScreen: _buildSmallAndMediumWidget(context),
      largeScreen: _buildLargeWidget(context),
    );
  }

  Widget _buildLargeWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 10,
      ),
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 0.1,
            color: Colors.grey,
            spreadRadius: 0.1,
            offset: Offset(
              0.1,
              0.1,
            ),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/profile.jpg',
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 10,
                ),
                _infoItem('Adress', 'Binagadi district'),
                Divider(),
                _infoItem('Phone', '+994 77 536-19-99'),
                Divider(),
                _infoItem('Email', 'kanan.yusubov@yandex.com'),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Kanan Yusubov',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Flutter Developer & Founder of Azerbaijan Flutter Users Community',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '''Sed ut perspiciatis unde omnis iste natus\nerror sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque.\n
Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque.\n
Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores.
            ''',
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: RaisedButton(
                        hoverColor: Colors.pinkAccent,
                        color: Colors.blue,
                        onPressed: () {},
                        child: Text(
                          'Download CV',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 40,
                      child: RaisedButton(
                        hoverColor: Colors.blueGrey,
                        color: Colors.grey,
                        onPressed: () {},
                        child: Text(
                          'Contact me',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallAndMediumWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 0.1,
            color: Colors.grey,
            spreadRadius: 0.1,
            offset: Offset(
              0.1,
              0.1,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Kanan Yusubov',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Flutter Developer & Founder of Azerbaijan Flutter Users Community',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/profile.jpg',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          _infoItem('Adress', 'Binagadi district'),
          Divider(),
          _infoItem('Phone', '+994 77 536-19-99'),
          Divider(),
          _infoItem('Email', 'kanan.yusubov@yandex.com'),
          SizedBox(
            height: 20,
          ),
          Text(
            '''Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque.
Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque.
Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores.
          ''',
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 40,
            child: RaisedButton(
              hoverColor: Colors.pinkAccent,
              color: Colors.blue,
              onPressed: () {},
              child: Text(
                'Download CV',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 40,
            child: RaisedButton(
              hoverColor: Colors.blueGrey,
              color: Colors.grey,
              onPressed: () {},
              child: Text(
                'Contact Me',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(String title, String description) {
    return Row(
      children: <Widget>[
        _pinkContainer(title),
        SizedBox(
          width: 10,
        ),
        Spacer(),
        Expanded(
          child: Text(
            description,
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }

  Widget _pinkContainer(String title) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
