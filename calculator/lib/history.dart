import 'package:flutter/material.dart';

class History extends StatelessWidget {

  const History({Key? key}) : super(key: key);

  static final List<List<String>> history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_delete_outlined),
            onPressed: () => { history.clear(), Navigator.pop(context,true) },
          ),
        ],
      ),
      body: history.isEmpty ? const Center(
        child: Text(
            'History is empty',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25
            )
        ),
      )
          :
      ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: history.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0) ),
            tileColor: const Color(0xFF212121),
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                history[history.length - i - 1][0],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25
                )
              ),
            ),
            subtitle: Align(
              alignment: Alignment.centerRight,
              child: Text(
                  history[history.length - i - 1][1],
                style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                )
              ),
            )
          );
        },
      ),
    );
  }

  static void addToHistory(mathOperation, result){
    List<String> newHistory = [];
    newHistory.add(mathOperation);
    newHistory.add(result);
    history.add(newHistory);
  }

}


