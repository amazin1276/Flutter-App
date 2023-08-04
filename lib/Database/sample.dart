import 'package:flutter/material.dart';

class SampleGetState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SampleState();
  }
}

class SampleState extends State<SampleGetState> {
  String input;
  List<String> lists;
  List<bool> isChecked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(input),
      ),
      body: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              WInputListName(),
              WInput(),
              WListBuilder(),
            ],
          )),
    );
  }

  Widget WInputListName() {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: TextField(
        maxLength: 10,
        maxLengthEnforced: true,
        decoration: InputDecoration(
          labelText: 'List name',
        ),
        onChanged: (String value) {
          setState(() {
            input = value;
          });
        },
      ),
    );
  }

  Widget WInput() {
    return RaisedButton(
      child: Text('Add'),
      onPressed: () {
        setState(() {
          lists.add(input);
          isChecked.add(false);
        });
      },
    );
  }

  Widget WListBuilder() {
    if (lists[0] != null) {
      return Container(
        height: 50,
        width: double.infinity,
        child: Card(
          child: ListView.builder(
            itemCount: lists.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                value: isChecked[index],
                title: Text(lists[index]),
                onChanged: (bool value) {
                  setState(() {
                    isChecked[index] = value;
                  });
                },
              );
            },
          ),
        ),
      );
    }
    return Container();
  }
}
