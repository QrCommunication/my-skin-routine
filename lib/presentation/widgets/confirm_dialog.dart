import 'package:flutter/material.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';

Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? confirmLabel,
  String? cancelLabel,
  bool isDestructive = true,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel ?? context.l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: isDestructive ? FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ) : null,
          child: Text(confirmLabel ?? context.l10n.commonDelete),
        ),
      ],
    ),
  );
  return result ?? false;
}
