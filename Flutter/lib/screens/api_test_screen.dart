import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({Key? key}) : super(key: key);

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  final TextEditingController _endpointController = TextEditingController();
  String _selectedMethod = 'GET';
  final List<Map<String, TextEditingController>> _parameters = [
    {'key': TextEditingController(), 'value': TextEditingController()}
  ];
  String _response = '';
  bool _isLoading = false;

  final List<String> _methods = ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'];

  void _addParameter() {
    setState(() {
      _parameters.add({
        'key': TextEditingController(),
        'value': TextEditingController(),
      });
    });
  }

  void _removeParameter(int index) {
    if (_parameters.length > 1) {
      setState(() {
        _parameters[index]['key']!.dispose();
        _parameters[index]['value']!.dispose();
        _parameters.removeAt(index);
      });
    }
  }

  Map<String, String> _getParameters() {
    final Map<String, String> params = {};
    for (var param in _parameters) {
      final key = param['key']!.text.trim();
      final value = param['value']!.text.trim();
      if (key.isNotEmpty) {
        params[key] = value;
      }
    }
    return params;
  }

  Future<void> _testApi() async {
    final endpoint = _endpointController.text.trim();

    if (endpoint.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('エンドポイントを入力してください')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _response = '';
    });

    final result = await ApiService.makeApiRequest(
      endpoint: endpoint,
      method: _selectedMethod,
      parameters: _getParameters(),
    );

    setState(() {
      _isLoading = false;
      if (result['success']) {
        _response = 'ステータスコード: ${result['statusCode']}\n\n'
            'ヘッダー:\n${result['headers']}\n\n'
            'レスポンスボディ:\n${result['body']}';
      } else {
        _response = 'エラー: ${result['error']}';
      }
    });
  }

  @override
  void dispose() {
    _endpointController.dispose();
    for (var param in _parameters) {
      param['key']!.dispose();
      param['value']!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'REST API テスター',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      'エンドポイント:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF555555),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _endpointController,
                      decoration: InputDecoration(
                        hintText: 'https://api.example.com/endpoint',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFF667eea),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'HTTPリクエストメソッド:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF555555),
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedMethod,
                      items: _methods.map((method) {
                        return DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value!;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFF667eea),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'パラメータ (Key-Value):',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF555555),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(_parameters.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _parameters[index]['key']!,
                                decoration: InputDecoration(
                                  hintText: 'Key',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF667eea),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _parameters[index]['value']!,
                                decoration: InputDecoration(
                                  hintText: 'Value',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF667eea),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => _removeParameter(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFf44336),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                              ),
                              child: const Text(
                                '削除',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    ElevatedButton(
                      onPressed: _addParameter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'パラメータを追加',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _isLoading ? null : _testApi,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: const Color(0xFF667eea),
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: Text(
                        _isLoading ? '送信中...' : 'テスト実行',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Divider(thickness: 2),
                    const SizedBox(height: 20),

                    const Text(
                      'レスポンス',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF555555),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf5f5f5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 100,
                        maxHeight: 400,
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          _response.isEmpty ? 'レスポンスがここに表示されます' : _response,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}