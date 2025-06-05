import 'package:flutter/material.dart';

class TeamMemberSection extends StatelessWidget {
  const TeamMemberSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '팀원',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.orange[400],
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                child: const Text('팀원 초대 +'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
