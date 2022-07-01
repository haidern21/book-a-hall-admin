import 'package:book_a_hall_admin_app/Screens/edit-hall-details.dart';
import 'package:book_a_hall_admin_app/Widgets/pageview_with_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/hall_model.dart';
import '../constants/constants.dart';

class HallDetailsScreen extends StatefulWidget {
  final HallModel hallModel;

  const HallDetailsScreen({Key? key, required this.hallModel})
      : super(key: key);

  @override
  _HallDetailsScreenState createState() => _HallDetailsScreenState();
}

class _HallDetailsScreenState extends State<HallDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .35,
                      width: double.infinity,
                      child: widget.hallModel.hallImages!.isEmpty
                          ? const Center(
                              child: Icon(
                                Icons.photo,
                                size: 50,
                                color: Colors.grey,
                              ),
                            )
                          : PageViewWithIndicator(
                              onViewClicked: _onTabClicked,
                              imagesUrlList: widget.hallModel.hallImages!,
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 40),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back,
                              color: greenColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await showAlertDialog(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 40),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.delete,
                              color: greenColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                height: 60,
                width: double.infinity,
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.hallModel.hallName ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Text(
                  widget.hallModel.hallAddress ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(color: greenColor, width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 30),
                      child: Text(
                        'Rs. ${widget.hallModel.ratePerPerson ?? ''}/person',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      'Max Capacity: ${widget.hallModel.maxCapacity} persons',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: double.infinity,
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Text(
                    'Features',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Icon(
                                          CupertinoIcons.circle_fill,
                                          color: greenColor,
                                          size: 5,
                                        ),
                                      ),
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        widget.hallModel.hallFeatures![index],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          50,
                                      height: 30,
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            50,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: const Icon(
                                      CupertinoIcons.check_mark,
                                      color: purpleColor,
                                      size: 25,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 0,
                          ),
                      itemCount: widget.hallModel.hallFeatures!.length)),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: purpleColor,
      //   icon: const Icon(Icons.edit,color: Colors.white,),
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditHallDetails(hallModel: widget.hallModel)));
      //   }, label: const Text('Edit',style: TextStyle(color: Colors.white),),
      // ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(color: greenColor),
      ),
      onPressed: () async {
        await FirebaseFirestore.instance
            .collection(kHalls)
            .doc(widget.hallModel.hallId)
            .delete();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(color: greenColor),
      ),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure you want to delete this?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _onTabClicked(String clickedImageUrl) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: InteractiveViewer(
              panEnabled: true,
              minScale: 0.001,
              child: CachedNetworkImage(imageUrl:clickedImageUrl),
              // child: PageViewWithIndicator(imagesUrlList: ad.ima,),
            ),
          );
        });
  }
}
