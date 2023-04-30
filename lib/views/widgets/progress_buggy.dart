import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class WeekProgressIndicator extends StatelessWidget {
  final int currentWeek;
  final List<Map<String, String>> weeks;

  const WeekProgressIndicator({
    super.key,
    required this.currentWeek,
    required this.weeks,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the number of inactive dots on each side of the active dot
    final numInactiveDots = 3;
    final numTotalDots = numInactiveDots * 2 + 1;
    final activeDotIndex = currentWeek;
    final firstDotIndex = activeDotIndex - numInactiveDots;
    final lastDotIndex = activeDotIndex + numInactiveDots;

    // Build the list of dots
    final dots = <Widget>[
      _buildDot(activeDotIndex),
    ];
    for (var i = firstDotIndex; i < activeDotIndex; i++) {
      if (i >= 0) {
        dots.add(_buildDot(i));
      }
    }
    for (var i = activeDotIndex + 1; i <= lastDotIndex; i++) {
      if (i < weeks.length) {
        dots.add(_buildDot(i));
      }
    }

    return Column(
      children: [
        Text(
          weeks[currentWeek - 1]['week']!,
          style: Styles.labelMedium.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          width: screenWidth * 0.9,
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dots,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          weeks[currentWeek - 1]['assignment']!,
          style: Styles.labelMedium.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == currentWeek - 1;

    return Column(
      children: [
        Container(
          width: isActive ? 24.0 : 12.0,
          height: isActive ? 24.0 : 12.0,
          decoration: BoxDecoration(
            color: isActive ? Colors.amber : Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        if (isActive)
          Column(
            children: [
              SizedBox(height: 4.0),
              Text(
                weeks[index]['week']!,
                style: Styles.labelSmall.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                weeks[index]['assignment']!,
                style: Styles.labelSmall.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
