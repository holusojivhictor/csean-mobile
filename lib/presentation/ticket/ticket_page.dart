import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

import 'widgets/ticket_form.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Create Ticket', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          margin: Styles.edgeInsetAll10,
          child: SingleChildScrollView(
            child: Column(
              children: const [
                TicketForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
