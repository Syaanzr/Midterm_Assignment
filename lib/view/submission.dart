import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Submission extends StatefulWidget {
  final int work_id;
  final int worker_id;
  final String title;

  const Submission({
    super.key,
    required this.work_id,
    required this.worker_id,
    required this.title,
  });

  @override
  State<Submission> createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<Submission> {
  final _controller = TextEditingController();
  bool _isSubmitting = false;
  String _message = '';

  Future<void> _submitWork() async {
    final submission_text = _controller.text.trim();
    if (submission_text.isEmpty) {
      setState(() => _message = 'Please describe the completed task.');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _message = '';
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2/worker_list/submit.php'), 
      body: {
  'work_id': widget.work_id.toString(),
  'worker_id': widget.worker_id.toString(),
  'submission_text': submission_text.toString(),
});

print('Raw response: ${response.body}');

try {
  final jsonResponse = json.decode(response.body);
  if (jsonResponse['success'] == true) {
    Navigator.pop(context, true);
  } else {
    setState(() => _message = jsonResponse['message'] ?? 'Server error. Try again.');
  }
} catch (e) {
  print('JSON Decode Error: $e');
  setState(() => _message = 'Invalid server response. Check console for details.');
}


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Task'),
        backgroundColor: Color.fromARGB(255, 209, 46, 179),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Task:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What did you complete ?',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitWork,
              child: Text(_isSubmitting ? 'Submitting...' : 'Submit'),
            ),
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(_message,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }
}