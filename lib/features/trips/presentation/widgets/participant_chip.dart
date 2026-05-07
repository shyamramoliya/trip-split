// lib/features/trips/presentation/widgets/participant_chip.dart
import 'package:flutter/material.dart';
import '../../domain/entities/participant_entity.dart';

class ParticipantChip extends StatelessWidget {
  final ParticipantEntity participant;
  final VoidCallback? onDelete;
  final bool isSelected;
  final VoidCallback? onTap;

  const ParticipantChip({
    super.key,
    required this.participant,
    this.onDelete,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      avatar: ParticipantAvatar(participant: participant),
      label: Text(participant.name),
      onDeleted: onDelete,
      selected: isSelected,
      onSelected: onTap != null ? (_) => onTap!() : null,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}

class ParticipantAvatar extends StatelessWidget {
  final ParticipantEntity participant;
  final double size;

  const ParticipantAvatar({
    super.key,
    required this.participant,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = _parseColor(participant.colorHex);

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: bgColor,
      backgroundImage: participant.avatarUrl != null ? NetworkImage(participant.avatarUrl!) : null,
      child: participant.avatarUrl == null
          ? Text(
              participant.name.isNotEmpty ? participant.name[0].toUpperCase() : '?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size * 0.4,
              ),
            )
          : null,
    );
  }

  Color _parseColor(String hexString) {
    try {
      if (hexString.startsWith('#')) hexString = hexString.substring(1);
      if (hexString.length == 6) hexString = 'FF$hexString';
      return Color(int.parse(hexString, radix: 16));
    } catch (e) {
      return Colors.blue;
    }
  }
}
