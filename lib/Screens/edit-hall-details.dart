import 'dart:io';

import 'package:book_a_hall_admin_app/Models/hall_model.dart';
import 'package:book_a_hall_admin_app/Widgets/edit-image-widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Widgets/custom_add_image_widget.dart';
import '../constants/constants.dart';
import 'landing_screen.dart';

class EditHallDetails extends StatefulWidget {
  final HallModel hallModel;

  const EditHallDetails({Key? key, required this.hallModel}) : super(key: key);

  @override
  _EditHallDetailsState createState() => _EditHallDetailsState();
}

class _EditHallDetailsState extends State<EditHallDetails> {
  var key = GlobalKey<FormState>();
  List<AddImageWidget> imageWidgets = [];
  List<String> imagesDownloadUrl = [];
  List<File>? dynamicImages = [];
  List<File> images = [];
  File? image1;
  File? image2;
  File? image3;
  bool ac = false;
  bool photographer = false;
  bool caters = false;
  bool musicSystem = false;
  bool makeUpArtist = false;
  bool eventManager = false;
  bool decoration = false;
  bool security = false;
  bool loader = false;
  List<dynamic> features = [];
  List<dynamic> featuresEdited = [];
  var hallId = '';
  var hallName = TextEditingController();
  var hallAddress = TextEditingController();
  var ratePerPerson = TextEditingController();
  var maxCapacity = TextEditingController();

  @override
  void initState() {
    hallName.text = widget.hallModel.hallName ?? '';
    hallAddress.text = widget.hallModel.hallAddress ?? '';
    ratePerPerson.text = widget.hallModel.ratePerPerson ?? '';
    maxCapacity.text = widget.hallModel.maxCapacity ?? '';
    features = widget.hallModel.hallFeatures!;
    hallId = widget.hallModel.hallId!;
    print('hall Features:${widget.hallModel.hallFeatures}');
    features.contains('Air Condition') ? ac = true : false;
    features.contains('Photographer') ? photographer = true : false;
    features.contains('Caters') ? caters = true : false;
    features.contains('Music System') ? musicSystem = true : false;
    features.contains('Makeup Artist') ? makeUpArtist = true : false;
    features.contains('Event Manager') ? eventManager = true : false;
    features.contains('Decoration') ? decoration = true : false;
    features.contains('Security') ? security = true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Text('Edit Hall Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () async {
                            var picker = await ImagePicker().getImage(
                                source: ImageSource.gallery, imageQuality: 20);
                            setState(() {
                              image1 = File(picker!.path);
                              if (image1 != null) {
                                images.add(image1!);
                              }
                            });
                          },
                          child: image1 == null
                              ? EditImageWidget(
                                  image: widget.hallModel.hallImages!.first,
                                )
                              : AddImageWidget(
                                  image: image1,
                                )),
                      InkWell(
                          onTap: () async {
                            var picker = await ImagePicker().getImage(
                                source: ImageSource.gallery, imageQuality: 20);
                            setState(() {
                              image2 = File(picker!.path);
                              if (image2 != null) {
                                images.add(image2!);
                              }
                            });
                          },
                          child: widget.hallModel.hallImages!.elementAt(1)!= null
                              ? EditImageWidget(
                            image: widget.hallModel.hallImages!.elementAt(1),
                          )
                              : AddImageWidget(
                            image: image1,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: hallName,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter hall name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'Hall Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: hallAddress,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter hall address';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Hall Address',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ratePerPerson,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Value';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: 'Rate per person'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: maxCapacity,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Value';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Max capacity'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Air condition'),
                    Checkbox(
                        value: ac,
                        onChanged: (value) {
                          setState(() {
                            ac = value!;
                          });
                          if (ac == true) {
                            featuresEdited.add('Air Condition');
                            print(featuresEdited);
                          }
                          if (ac == false) {
                            featuresEdited.removeWhere(
                                (element) => element == 'Air Condition');
                            print(featuresEdited);
                          }
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Caters'),
                    Checkbox(
                        value: caters,
                        onChanged: (value) {
                          setState(() {
                            caters = value!;
                          });
                          if (caters == true) {
                            featuresEdited.add('Caters');
                          }
                          if (caters == false) {
                            featuresEdited
                                .removeWhere((element) => element == 'Caters');
                          }
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Photographer'),
                    Checkbox(
                        value: photographer,
                        onChanged: (value) {
                          setState(() {
                            photographer = value!;
                          });
                          if (photographer == true) {
                            featuresEdited.add('Caters');
                          }
                          if (photographer == false) {
                            featuresEdited
                                .removeWhere((element) => element == 'Caters');
                          }
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Music System'),
                    Checkbox(
                        value: musicSystem,
                        onChanged: (value) {
                          setState(() {
                            musicSystem = value!;
                          });
                          if (musicSystem == true) {
                            featuresEdited.add('Music System');
                          }
                          if (musicSystem == false) {
                            featuresEdited.removeWhere(
                                (element) => element == 'Music System');
                          }
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Makeup Artist'),
                    Checkbox(
                        value: makeUpArtist,
                        onChanged: (value) {
                          setState(() {
                            makeUpArtist = value!;
                          });
                          if (makeUpArtist == true) {
                            featuresEdited.add('Makeup Artist');
                          }
                          if (makeUpArtist == false) {
                            featuresEdited.removeWhere(
                                (element) => element == 'Makeup Artist');
                          }
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Event Manager'),
                    Checkbox(
                        value: eventManager,
                        onChanged: (value) {
                          setState(() {
                            eventManager = value!;
                          });
                          if (eventManager == true) {
                            featuresEdited.add('Event Manager');
                          }
                          if (eventManager == false) {
                            featuresEdited.removeWhere(
                                (element) => element == 'Event Manager');
                          }
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Decoration'),
                    Checkbox(
                        value: decoration,
                        onChanged: (value) {
                          setState(() {
                            decoration = value!;
                          });
                          if (decoration == true) {
                            featuresEdited.add('Decoration');
                          }
                          if (decoration == false) {
                            featuresEdited.removeWhere(
                                (element) => element == 'Decoration');
                          }
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Security'),
                    Checkbox(
                        value: security,
                        onChanged: (value) {
                          setState(() {
                            security = value!;
                          });
                          if (security == true) {
                            featuresEdited.add('Security');
                          }
                          if (security == false) {
                            featuresEdited.removeWhere(
                                (element) => element == 'Security');
                          }
                        }),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      try {
                        if (key.currentState!.validate() == false) {
                          return;
                        }
                        setState(() {
                          loader = true;
                        });
                        if (image1 != null ||
                            image2 != null ||
                            image3 != null) {
                          Map<String, dynamic> data = {
                            kHallName: hallName.text.trim(),
                            kHallAddress: hallAddress.text.trim(),
                            kRatePerPerson: ratePerPerson.text.trim(),
                            kMaxCapacity: maxCapacity.text.trim(),
                            kHallFeatures: features,
                            kHallId: hallId,
                            kHallImages: imagesDownloadUrl,
                          };
                          //await uploadImagesAndGetDownloadLink();
                          await FirebaseFirestore.instance
                              .collection(kHalls)
                              .doc(hallId)
                              .set(data);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LandingPage()),
                              (route) => false);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: greenColor,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              duration: const Duration(seconds: 2),
                              content: const Text(
                                'DETAILS POSTED',
                                style: TextStyle(color: Colors.white),
                              )));
                          setState(() {
                            imagesDownloadUrl.clear();
                            loader = false;
                          });
                        } else {
                          setState(() {
                            loader = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: greenColor,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              duration: const Duration(seconds: 2),
                              content: const Text(
                                'FILL REQUIRED FIELDS',
                                style: TextStyle(color: Colors.white),
                              )));
                        }
                      } catch (e) {
                        setState(() {
                          loader = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: greenColor,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            duration: const Duration(seconds: 2),
                            content: const Text(
                              'AN ERROR OCCURRED. PLEASE TRY AGAIN LATER. ',
                              style: TextStyle(color: Colors.white),
                            )));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
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
                      child: Center(
                          child: loader == false
                              ? const Text(
                                  'Post Details',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
