import 'package:flutter/material.dart';
import 'package:erasmusbuddy/models/travel_idea.dart';

class TravelPlanDetailScreen extends StatelessWidget {
  final String currentUserId = "user_123";

  const TravelPlanDetailScreen({super.key});

  static const routeName = '/travel-idea-detail';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    final TravelIdea idea = (args is TravelIdea)
        ? args
        : TravelIdea(
      id: "test_1",
      createdBy: "Test User",
      title: "Budapest + Bratislava Weekend",
      destination: "Budapest, Bratislava, Hungary",
      duration: "2-3 days",
      budget: "150 EUR",
      description: "A perfect idea to spend time at the weekends. Don't forget to try local food!",
      createdAt: DateTime.now(),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(idea.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              const TextSpan(
                                text: "Created by ",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              TextSpan(
                                text: idea.createdBy,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          idea.createdAt.toString().split(' ')[0],
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                        ),
                      ],
                    ),

                    const Divider(height: 30, thickness: 1),

                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(idea.destination,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.orange),
                        const SizedBox(width: 5),
                        Text(idea.duration, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(Icons.euro, color: Colors.green),
                        const SizedBox(width: 5),
                        Text("Budget: ${idea.budget}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),

                    const Divider(height: 40),

                    const Text("Description",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        idea.description,
                        style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}