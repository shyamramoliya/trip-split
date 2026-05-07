// lib/features/trips/presentation/widgets/trip_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/trip_entity.dart';
import 'participant_chip.dart';

class TripCard extends StatelessWidget {
  final TripEntity trip;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const TripCard({
    super.key,
    required this.trip,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Generate a consistent gradient based on trip ID
    final colors = _getGradientColors(trip.id);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: colors[0].withOpacity(0.3),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
          ),
          child: Stack(
            children: [
              // Background pattern (optional)
              Positioned(
                right: -30,
                bottom: -30,
                child: Icon(Icons.flight_takeoff, size: 120, color: Colors.white.withOpacity(0.1)),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            trip.name,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (onDelete != null)
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.white70),
                            onPressed: onDelete,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          trip.destination,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormatter.formatRange(trip.startDate, trip.endDate),
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            for (var i = 0; i < trip.participants.length && i < 3; i++)
                              Align(
                                widthFactor: 0.7,
                                child: ParticipantAvatar(participant: trip.participants[i], size: 32),
                              ),
                            if (trip.participants.length > 3)
                              Align(
                                widthFactor: 0.7,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  child: Text('+${trip.participants.length - 3}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('View Trip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut);
  }

  List<Color> _getGradientColors(String id) {
    final colors = [
      [const Color(0xFF1A6FBF), const Color(0xFF0D4A8A)], // Blue
      [const Color(0xFFE8674A), const Color(0xFFC0392B)], // Red/Coral
      [const Color(0xFF27AE60), const Color(0xFF1E8449)], // Green
      [const Color(0xFF8E44AD), const Color(0xFF5B2C6F)], // Purple
      [const Color(0xFFF39C12), const Color(0xFFD35400)], // Orange
    ];
    int index = id.hashCode.abs() % colors.length;
    return colors[index];
  }
}
