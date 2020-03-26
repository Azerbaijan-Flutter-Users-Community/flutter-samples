import 'package:flutter/material.dart';
import '../screens/camera_screen.dart';
import '../screens/chats_screen.dart';
import '../screens/status_screen.dart';
import '../screens/calls_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  IconData _fabIcon;
  List<PopupMenuItem> _popUpMenuItems;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1)
    ..addListener((){
      setState(() {
       switch(_tabController.index) {
        case 0:
        _fabIcon = null;
        _popUpMenuItems = null;
          break;
        case 1:
          _fabIcon = Icons.message;
          _popUpMenuItems = [
            PopupMenuItem(
               child: Text('New group'),
               value: 0,
             ),
             PopupMenuItem(
               child: Text('New broadcast'),
               value: 1,
             ),
             PopupMenuItem(
               child: Text('WhatsApp Web'),
               value: 2,
             ),
             PopupMenuItem(
               child: Text('Starred Messages'),
               value: 3,
             ),
             PopupMenuItem(
               child: Text('Settings'),
               value: 4,
             ),
          ];
          break;
        case 2:
          _fabIcon = Icons.camera_enhance;
          _popUpMenuItems = [
            PopupMenuItem(
               child: Text('Status privacy'),
               value: 0,
             ),
             PopupMenuItem(
               child: Text('Settings'),
               value: 1,
             ),
          ];
          break;
        case 3:
          _fabIcon = Icons.call;
          _popUpMenuItems = [
            PopupMenuItem(
               child: Text('Clear call log'),
               value: 0,
             ),
             PopupMenuItem(
               child: Text('Settings'),
               value: 1,
             ),
          ];
          break;
      } 
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        title: const Text(
          'WhatsApp'
        ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: <Widget>[
            const Tab(icon: Icon(Icons.camera_alt)),
            const Tab(text: 'CHATS',),
            const Tab(text: 'STATUS'),
            const Tab(text: 'CALLS',),
          ],
          controller: _tabController,
        ),
        actions: <Widget>[
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 10),
           child:  const Icon(Icons.search),
         ),
         PopupMenuButton(
           onSelected: (_){},
           itemBuilder: (context) => _popUpMenuItems),
        ],),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CameraScreen(),
          ChatsScreen(),
          StatusScreen(),
          CallsScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(_fabIcon, color: Colors.white,),
        onPressed: (){},
      ),
      );
  }
}