
import 'package:flutter/material.dart';
import 'package:worker_task2/view/model/worker.dart';
import 'package:worker_task2/view/loginscreen.dart';
import 'package:worker_task2/view/registerscreen.dart';
import 'package:worker_task2/view/viewTask.dart';


class MainScreen extends StatefulWidget {
  final Worker worker;
  const MainScreen({super.key, required this.worker});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Profile'),
        backgroundColor: Color.fromARGB(255, 209, 46, 179),        
      ),
      body: Center( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${widget.worker.iD.toString()}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Full Name: ${widget.worker.name}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Email: ${widget.worker.email}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Phone: ${widget.worker.phone}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Address: ${widget.worker.address}', style: const TextStyle(fontSize: 18)),
                
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => viewTask(iD: widget.worker.iD.toString()),
                        ),
                        );                    
                    },
                    icon: const Icon(Icons.task),
                    label: const Text('View Tasks'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 209, 46, 179),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}