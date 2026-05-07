// lib/features/expenses/presentation/screens/expense_entry_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../trips/presentation/providers/trip_provider.dart';
import '../../domain/entities/expense_entity.dart';
import '../providers/expense_provider.dart';

class ExpenseEntryScreen extends ConsumerStatefulWidget {
  final String tripId;
  final String? expenseId;

  const ExpenseEntryScreen({
    super.key,
    required this.tripId,
    this.expenseId,
  });

  @override
  ConsumerState<ExpenseEntryScreen> createState() => _ExpenseEntryScreenState();
}

class _ExpenseEntryScreenState extends ConsumerState<ExpenseEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedPayerId;
  Set<String> _splitAmongIds = {};
  String _category = 'food';
  DateTime _date = DateTime.now();

  bool _isLoading = false;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'food', 'icon': Icons.restaurant, 'label': 'Food'},
    {'id': 'transport', 'icon': Icons.directions_car, 'label': 'Transport'},
    {'id': 'hotel', 'icon': Icons.hotel, 'label': 'Hotel'},
    {'id': 'activity', 'icon': Icons.local_activity, 'label': 'Activity'},
    {'id': 'shopping', 'icon': Icons.shopping_bag, 'label': 'Shopping'},
    {'id': 'other', 'icon': Icons.receipt, 'label': 'Other'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initForm();
    });
  }

  void _initForm() {
    final trip = ref.read(tripByIdProvider(widget.tripId));
    if (trip != null && trip.participants.isNotEmpty) {
      setState(() {
        _selectedPayerId = trip.participants.first.id;
        _splitAmongIds = trip.participants.map((p) => p.id).toSet();
      });
    }

    if (widget.expenseId != null) {
      // Load existing expense for editing
      // Not fully implemented in this demo script
    }
  }

  Future<void> _saveExpense() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedPayerId == null) return;
    if (_splitAmongIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select at least one person to split with.')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final trip = ref.read(tripByIdProvider(widget.tripId));
      
      final expense = ExpenseEntity(
        id: widget.expenseId ?? const Uuid().v4(),
        tripId: widget.tripId,
        title: _titleController.text.trim(),
        amount: double.parse(_amountController.text.trim()),
        paidById: _selectedPayerId!,
        splitAmongIds: _splitAmongIds.toList(),
        category: _category,
        date: _date,
        notes: _notesController.text.trim(),
        currency: trip?.currency ?? 'INR',
        splitType: 'equal',
        createdAt: DateTime.now(),
        isSynced: false,
      );

      if (widget.expenseId == null) {
        await ref.read(expenseNotifierProvider.notifier).addExpense(expense);
      } else {
        await ref.read(expenseNotifierProvider.notifier).updateExpense(expense);
      }
      
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final trip = ref.watch(tripByIdProvider(widget.tripId));
    if (trip == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: Text(widget.expenseId == null ? 'Add Expense' : 'Edit Expense')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: 'Title',
                hint: 'What was this for?',
                controller: _titleController,
                validator: Validators.expenseTitle,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Amount',
                hint: '0.00',
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: Validators.expenseAmount,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: Text(trip.currency, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
              Text('Category', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _category == cat['id'];
                    return GestureDetector(
                      onTap: () => setState(() => _category = cat['id']),
                      child: Container(
                        width: 70,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(cat['icon'], color: isSelected ? Colors.white : Colors.grey),
                            const SizedBox(height: 4),
                            Text(
                              cat['label'],
                              style: TextStyle(
                                fontSize: 10,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text('Paid by', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: trip.participants.map((p) {
                  return ChoiceChip(
                    label: Text(p.name),
                    selected: _selectedPayerId == p.id,
                    onSelected: (val) {
                      if (val) setState(() => _selectedPayerId = p.id);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text('Split among', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: trip.participants.map((p) {
                  return FilterChip(
                    label: Text(p.name),
                    selected: _splitAmongIds.contains(p.id),
                    onSelected: (val) {
                      setState(() {
                        if (val) _splitAmongIds.add(p.id);
                        else _splitAmongIds.remove(p.id);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              AppTextField(
                label: 'Notes (Optional)',
                controller: _notesController,
                maxLines: 3,
              ),
              const SizedBox(height: 48),
              AppButton(
                label: 'Save Expense',
                onPressed: _saveExpense,
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
