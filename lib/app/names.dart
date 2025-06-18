import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NamesPage extends StatefulWidget {
  const NamesPage({super.key});

  @override
  State<NamesPage> createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onGoPressed() {
    String inputText = _textController.text;
    
    // Split by commas and also by the word "at" (only when it's a standalone word)
    List<String> splitTexts = inputText
        .split(RegExp(r',|\bat\b'))  // Split by comma OR standalone "at" word
        .map((text) => text.trim())  // Remove leading/trailing whitespace
        .where((text) => text.isNotEmpty)  // Remove empty strings
        .toList();
    
    // Create JSON structure
    Map<String, dynamic> jsonResult = {
      'original_text': inputText,
      'split_items': splitTexts,
      'count': splitTexts.length,
      'timestamp': DateTime.now().toIso8601String(),
    };
    
    // Print JSON to terminal
    print('JSON Result:');
    print(jsonResult);
  }

  @override
  Widget build(BuildContext context) {
  DateTime now = DateTime.now();
  String todayDate = DateFormat('MMMM d, yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text(todayDate),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                "Item names:",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            TextField(
              controller: _textController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your text here (separate with commas or "at")...',
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onGoPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), 
              ),
              child: const Text(
                'GO',
                style: TextStyle(fontSize: 20), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}