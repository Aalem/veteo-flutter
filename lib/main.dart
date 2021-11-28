import 'package:flutter/material.dart';
import 'package:veteo_graph/components/add_weight_bottomsheet.dart';
import 'package:veteo_graph/api/veteo_api.dart';
import 'package:veteo_graph/components/graph.dart';
import 'package:veteo_graph/components/months_widget.dart';
import 'package:veteo_graph/constants.dart';
import 'package:veteo_graph/helper.dart';
import 'package:veteo_graph/models/weight.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChartPage(),
    ),
  );
}

class ChartPage extends StatefulWidget {
  @override
  ChartPageState createState() => ChartPageState();
}

final graphKey = GlobalKey();

List<Weight> weightList = [];

double graphWidth = 0;
double numberOfMonths = 0;

class ChartPageState extends State<ChartPage> with TickerProviderStateMixin {
  void changeData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<List<Weight>>(
          future: VeteoAPI().getAllWeights(),
          builder: (context, AsyncSnapshot<List<Weight>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // return const Center(child: Text('Please wait its loading...'));
              return Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircularProgressIndicator(color: Colors.orange),
                          SizedBox(height: 20),
                          Text('Loading...')
                        ],
                      )));
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                weightList = snapshot.data as List<Weight>;
                graphWidth = getGraphWidth(weightList);
                numberOfMonths = getNumberOfMonths(weightList);
                return Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        key: graphKey,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              'Weight Graph',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                height: graphHeight,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('24'),
                                    Text('20'),
                                    Text('16'),
                                    Text('12'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SizedBox(
                                    height: 220,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: graphHeight,
                                              width: graphWidth > 0
                                                  ? graphWidth
                                                  : double.minPositive,
                                              child: CustomPaint(
                                                painter: Graph(
                                                    numberOfMonths:
                                                        numberOfMonths.toInt(),
                                                    weightList: weightList),
                                                child: Container(),
                                              ),
                                            ),
                                            MonthWidget(weightList: weightList),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: const StadiumBorder(),
                                    primary: const Color(0x40FFA04C),
                                    onPrimary: Colors.white),
                                child: const Text(
                                  '+ Weight',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xFFFFA04C),
                                      letterSpacing: 1.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            const AddWeight());
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}
