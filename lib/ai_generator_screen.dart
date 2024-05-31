import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIGeneratorScreen extends StatefulWidget {
  const AIGeneratorScreen({Key? key}) : super(key: key);

  @override
  _AIGeneratorScreenState createState() => _AIGeneratorScreenState();
}

class _AIGeneratorScreenState extends State<AIGeneratorScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _generatedImageUrl;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _generateImage() async {
    if (_controller.text.isEmpty) {
      setState(() {
        _errorMessage = 'Prompt cannot be empty';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer sk-proj-LHOX0O2aSNqxkcjtkmdlT3BlbkFJEJz5tTeALP1vNVfNWUko',
        },
        body: jsonEncode({
          'prompt': _controller.text,
          'n': 1,
          'size': '512x512',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _generatedImageUrl = data['data'][0]['url'];
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to generate image. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('AI Generator'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _controller,
                placeholder: 'Enter prompt',
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.inactiveGray),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 16.0),
              CupertinoButton(
                onPressed: _isLoading ? null : _generateImage,
                color: CupertinoColors.activeBlue,
                disabledColor: CupertinoColors.systemGrey,
                child: _isLoading
                    ? const CupertinoActivityIndicator()
                    : const Text('Generate Design'),
              ),
              const SizedBox(height: 16.0),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: CupertinoColors.systemRed),
                ),
              if (_generatedImageUrl != null)
                Image.network(_generatedImageUrl!),
              if (_generatedImageUrl == null &&
                  _errorMessage == null &&
                  !_isLoading)
                const Text('No image generated yet.'),
            ],
          ),
        ),
      ),
    );
  }
}
