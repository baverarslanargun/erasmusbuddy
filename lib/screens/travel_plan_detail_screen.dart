import 'package:flutter/material.dart';

class TravelPlan {
  final String id;
  final String creatorId;
  final String title;
  final String country;
  final List<String> cities;
  final String duration;
  final List<String> placesToVisit;
  final String note;
  final String imageUrl;

  TravelPlan({
    this.id = '',
    this.creatorId = '',
    this.title = 'İsimsiz Plan',
    this.country = 'Belirtilmemiş Ülke',
    this.cities = const [],
    this.duration = 'Süre Belirtilmedi',
    this.placesToVisit = const [],
    this.note = '',
    this.imageUrl = 'https://placeholder.com/travel.jpg',
  });
}

class TravelPlanDetailScreen extends StatelessWidget {
  final String currentUserId = "user_123";

  const TravelPlanDetailScreen({super.key});

  static const routeName = '/travel-idea-detail';

  @override
  Widget build(BuildContext context) {

    // try to get info from last page
    final args = ModalRoute.of(context)!.settings.arguments;

    // initial
    final TravelPlan plan = (args is TravelPlan)
        ? args
        : TravelPlan(
      id: "test_1",
      creatorId: "user_123",
      title: "Budapest + Bratislava Weekend (Test Mode)",
      country: "Hungary",
      cities: ["Budapest", "Bratislava"],
      duration: "2-3 days",
      placesToVisit: ["Old Town", "Bratislava Castle", "Danube River", "Hungarian Parliament"],
      note: "A perfect idea to spend time at the weekends. Don't forget to try local food!",
      imageUrl: "https://picsum.photos/800/600",
    );

    bool isOwner = plan.creatorId == currentUserId;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(plan.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
              background: plan.imageUrl.startsWith('http')
                  ? Image.network(
                plan.imageUrl,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              )
                  : Container(color: Colors.grey),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () => print("Kaydedildi"),
              ),
              if (isOwner) ...[
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
              ]
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        const SizedBox(width: 5),
                        Text("${plan.country} • ${plan.cities.join(", ")}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.orange),
                        const SizedBox(width: 5),
                        Text(plan.duration, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const Divider(height: 40),
                    const Text("Places to Visit",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: plan.placesToVisit.map((place) => Chip(
                        label: Text(place),
                        backgroundColor: Colors.blue.shade50,
                      )).toList(),
                    ),
                    const SizedBox(height: 30),
                    const Text("Notes",
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
                        plan.note,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Planı Paylaş"),
        icon: const Icon(Icons.share),
      ),
    );
  }
}