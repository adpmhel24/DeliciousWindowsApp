import 'package:fluent_ui/fluent_ui.dart';

class DialogRemarks extends StatefulWidget {
  const DialogRemarks({Key? key, required this.submitRemarks})
      : super(key: key);
  final void Function(String remarks) submitRemarks;

  @override
  _DialogRemarksState createState() => _DialogRemarksState();
}

class _DialogRemarksState extends State<DialogRemarks> {
  final TextEditingController _remarksController = TextEditingController();

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Add Remarks'),
      content: TextBox(
        controller: _remarksController,
        minLines: 3,
        maxLines: 5,
      ),
      actions: [
        Button(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        Button(
            child: const Text('Proceed'),
            onPressed: () {
              Navigator.of(context).pop();
              widget.submitRemarks(_remarksController.text);
            }),
      ],
    );
  }
}
