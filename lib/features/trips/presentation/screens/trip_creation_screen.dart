// lib/features/trips/presentation/screens/trip_creation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/participant_entity.dart';
import '../../domain/entities/trip_entity.dart';
import '../providers/trip_provider.dart';
import '../widgets/participant_chip.dart';

class TripCreationScreen extends ConsumerStatefulWidget {
  const TripCreationScreen({super.key});

  @override
  ConsumerState<TripCreationScreen> createState() => _TripCreationScreenState();
}

class _TripCreationScreenState extends ConsumerState<TripCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _destinationController = TextEditingController();
  final _participantController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String _currency = 'INR';
  final List<ParticipantEntity> _participants = [];

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _destinationController.dispose();
    _participantController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _addParticipant() {
    final name = _participantController.text.trim();
    if (name.isEmpty) return;

    final colors = ['#E8674A', '#27AE60', '#F4B942', '#8E44AD', '#3498DB'];
    final color = colors[_participants.length % colors.length];

    setState(() {
      _participants.add(ParticipantEntity(
        id: const Uuid().v4(),
        name: name,
        colorHex: color,
      ));
      _participantController.clear();
    });
  }

  void _removeParticipant(String id) {
    setState(() {
      _participants.removeWhere((p) => p.id == id);
    });
  }

  Future<void> _createTrip() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select trip dates')));
      return;
    }
    
    // Add creator as first participant if empty
    if (_participants.isEmpty) {
      _participants.add(ParticipantEntity(
        id: const Uuid().v4(),
        name: 'Me',
        colorHex: '#1A6FBF',
      ));
    }

    setState(() => _isLoading = true);

    try {
      final trip = TripEntity(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        destination: _destinationController.text.trim(),
        startDate: _startDate!,
        endDate: _endDate!,
        participantIds: _participants.map((p) => p.id).toList(),
        participants: _participants,
        currency: _currency,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSynced: false,
      );

      await ref.read(tripNotifierProvider.notifier).createTrip(trip);
      
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Trip created successfully!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Trip')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: 'Trip Name',
                hint: 'e.g., Summer in Paris',
                controller: _nameController,
                validator: Validators.tripName,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Destination',
                hint: 'City, Country',
                controller: _destinationController,
                validator: Validators.destination,
                prefixIcon: const Icon(Icons.location_on),
              ),
              const SizedBox(height: 16),
              Text('Dates', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              InkWell(
                onTap: _selectDateRange,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _startDate != null && _endDate != null
                              ? '${_startDate!.toString().split(' ')[0]} to ${_endDate!.toString().split(' ')[0]}'
                              : 'Select start and end dates',
                          style: TextStyle(
                            color: _startDate != null ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Currency', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _currency,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.attach_money)),
                items: ['INR', 'USD', 'EUR', 'GBP', 'AUD'].map((c) {
                  return DropdownMenuItem(value: c, child: Text(c));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _currency = val);
                },
              ),
              const SizedBox(height: 24),
              Text('Participants', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: '',
                      hint: 'Add friend by name',
                      controller: _participantController,
                      onTap: () {}, // Prevent keyboard hide on action
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle, size: 36),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: _addParticipant,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _participants.map((p) => ParticipantChip(
                  participant: p,
                  onDelete: () => _removeParticipant(p.id),
                )).toList(),
              ),
              const SizedBox(height: 48),
              AppButton(
                label: 'Create Trip',
                onPressed: _createTrip,
                isLoading: _isLoading,
                isExpanded: true,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
