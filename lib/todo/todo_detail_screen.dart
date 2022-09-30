import 'package:flutter/material.dart';

class TodoDetailScreen extends StatelessWidget {
  final int todoId;
  const TodoDetailScreen({Key? key, required this.todoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
      ),
      body: DetailScreenBody(todoId: todoId),
    );
  }
}

class DetailScreenBody extends StatelessWidget {
  final int todoId;
  const DetailScreenBody({Key? key, required this.todoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 16, right: 12, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleWidget("TODO Definition is a detailed one"),
          const SizedBox(height: 10),
          _buildCreatedDateAndStatus(),
          const SizedBox(height: 10),
          _buildLabel("Modified on"),
          _buildLabelValue("22/07/2022 12:00 PM"),
          const SizedBox(height: 25),
          _buildLabel("Description"),
          _buildDescriptionWidget(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
        ],
      ),
    );
  }

  _buildTitleWidget(String text) {
    return Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Text(text, style: const TextStyle(fontSize: 18.0)));
  }

  _buildLabel(String text) {
    return Text(text, style: TextStyle(color: Colors.grey[700]));
  }

  _buildLabelValue(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Text(text),
    );
  }

  _buildDescriptionWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Text(text, style: const TextStyle(fontSize: 15.0)),
    );
  }

  _buildCreatedDateAndStatus() {
    return Row(children: [
      _buildCreatedDate("22/07/2022 12:00 PM"),
      _buildStatus("Completed"),
    ]);
  }

  _buildCreatedDate(String text) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Created on"),
        _buildLabelValue(text),
      ],
    ));
  }

  _buildStatus(String text) {
    return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildLabel("Status"),
            _buildLabelValue(text),
          ],
        ));
  }
}
