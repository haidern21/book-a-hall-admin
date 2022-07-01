import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/hall_details_screen.dart';
import '../Widgets/hall_item.dart';
import '../constants/constants.dart';
import '../providers/hall_provider.dart';

class AllHallsScreen extends StatefulWidget {
  const AllHallsScreen({Key? key}) : super(key: key);

  @override
  _AllHallsScreenState createState() => _AllHallsScreenState();
}

class _AllHallsScreenState extends State<AllHallsScreen> {
  Future? future;

  @override
  void initState() {
    Provider.of<HallProvider>(context, listen: false).getAllHalls();
    future = Provider.of<HallProvider>(context, listen: false).getAllHalls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HallProvider hallProvider = Provider.of<HallProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HALLS'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  greenGradientColor5,
                  greenGradientColor1,
                  greenGradientColor4,
                  greenGradientColor6,
                  greenGradientColor7,
                ]),
          ),
        ),
      ),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HallDetailsScreen(
                                    hallModel: hallProvider.halls[index],
                                  )));
                    },
                    child: HallItem(
                      hallImage: hallProvider.halls[index].hallImages!.first,
                      hallName: hallProvider.halls[index].hallName,
                      hallAddress: hallProvider.halls[index].hallAddress,
                      maxCapacity: hallProvider.halls[index].maxCapacity,
                      ratePerPerson: hallProvider.halls[index].ratePerPerson,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 0,
                    ),
                itemCount: hallProvider.halls.length);
          }),
    );
  }
}
