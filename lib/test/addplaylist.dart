
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MutltSelect extends StatefulWidget {
  final List<String> items;
  const MutltSelect({required this.items,super.key});

  @override
  State<MutltSelect> createState() => _MutltSelectState();
}

class _MutltSelectState extends State<MutltSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if(isSelected){
        _selectedItems.add(itemValue);
      }else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
    print(_selectedItems);
    FirebaseFirestore.instance
        .collection("Users")
        .doc('hanksayhank@gmail.com')
        .collection('Playlist')
        .doc(_selectedItems.toString())
        .collection(_selectedItems.toString())
        .add(
        {
          'playlist_name': _selectedItems.toString()
    });

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) => CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) => _itemChange(item, isChecked!)
          )).toList(),
        ),


      ),
      actions: [
        TextButton(onPressed: _cancel, child: Text('Cancel')),
        ElevatedButton(onPressed: _submit, child: Text('Submit'))
      ]

    );
  }
}


class add_playlistPage extends StatefulWidget {
  const add_playlistPage({super.key});

  @override
  State<add_playlistPage> createState() => _add_playlistPageState();
}

class _add_playlistPageState extends State<add_playlistPage> {
  List<String> _selectedItems = [];
  List<String> albumNames = [];
  Future<List<String>> getAlbums() async {


    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection("Albums")
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (data.containsKey("album_name")) {
        albumNames.add(data["album_name"] as String);
      }

    }
    print(albumNames);
    return albumNames;
  }

  @override
  void initState() {
    super.initState();
    // Gọi hàm getAlbums ngay khi trang được khởi tạo
    getAlbums();
  }


  void _showPlaylist() async {
    final List<String> items = albumNames;

    final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context){
            return MutltSelect(items: items);
        });
    if(results != null){
      setState(() {
        _selectedItems = results;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
              ElevatedButton(
                  onPressed: _showPlaylist,
                  child: Text('Selected Your Favorite')),

            Wrap(
              children: _selectedItems.map((e) => Chip(label: Text(e))).toList(),
            )

          ],
        ),
      ),
    );
  }
}
