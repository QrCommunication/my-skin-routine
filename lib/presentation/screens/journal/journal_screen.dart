import 'package:flutter/material.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.journalTitle),
      ),
      body: Center(
        child: Text(context.l10n.journalTitle),
      ),
    );
  }
}
