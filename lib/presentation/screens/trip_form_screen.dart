import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:travel_journal/models/trip.dart';
import 'package:travel_journal/presentation/providers/trip_providers.dart';

class TripFormScreen extends ConsumerStatefulWidget {
  final Trip trip;

  const TripFormScreen({
    super.key,
    required this.trip,
  });

  bool get isEditing => trip.id.isNotEmpty;

  @override
  ConsumerState<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends ConsumerState<TripFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Trip' : 'Add Trip'),
        centerTitle: true,
        // Adding custom back button using text instead of icon
        leading: IconButton(
          icon: const Text(
            'Back',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        // Using text instead of icons to avoid rendering issues
        actions: widget.isEditing
            ? [
                TextButton(
                  onPressed: _deleteTrip,
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: _formKey,
        initialValue: {
          'title': widget.trip.title,
          'startDate': widget.trip.startDate,
          'endDate': widget.trip.endDate,
          'description': widget.trip.description,
        },
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'title',
              decoration: const InputDecoration(
                labelText: 'Trip Title',
                hintText: 'Enter trip title',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.maxLength(100),
              ]),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'startDate',
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                    ),
                    inputType: InputType.date,
                    validator: FormBuilderValidators.required(),
                    selectableDayPredicate: (date) => true,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'endDate',
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                    ),
                    inputType: InputType.date,
                    validator: FormBuilderValidators.required(),
                    selectableDayPredicate: (date) => true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(
              name: 'description',
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter trip description',
              ),
              maxLines: 4,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.maxLength(500),
              ]),
            ),
            const SizedBox(height: 36),
            // Save button - using text only to avoid icon rendering issues
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveTrip,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        widget.isEditing ? 'Update Trip' : 'Save Trip',
                        style: const TextStyle(fontSize: 18),
                      ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Cancel button - using text only to avoid icon rendering issues
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTrip() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final formData = _formKey.currentState!.value;
        final trip = Trip(
          id: widget.trip.id,
          title: formData['title'] as String,
          startDate: formData['startDate'] as DateTime,
          endDate: formData['endDate'] as DateTime,
          description: formData['description'] as String,
        );

        final controller = ref.read(tripControllerProvider);

        if (widget.isEditing) {
          await controller.updateTrip(trip);
        } else {
          await controller.createTrip(trip);
        }

        if (context.mounted) {
          Navigator.pop(context); // Return to the previous screen
        }
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteTrip() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Trip'),
        content: const Text(
            'Are you sure you want to delete this trip? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      setState(() => _isLoading = true);

      try {
        final controller = ref.read(tripControllerProvider);
        await controller.deleteTrip(widget.trip.id);

        if (context.mounted) {
          Navigator.pop(context); // Return to the previous screen
        }
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}
