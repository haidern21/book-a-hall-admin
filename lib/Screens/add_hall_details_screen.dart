import 'dart:io';
import 'package:book_a_hall_admin_app/Screens/landing_screen.dart';
import 'package:book_a_hall_admin_app/Widgets/custom_add_image_widget.dart';
import 'package:book_a_hall_admin_app/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddHallDetailsScreen extends StatefulWidget {
  const AddHallDetailsScreen({Key? key}) : super(key: key);

  @override
  _AddHallDetailsScreenState createState() => _AddHallDetailsScreenState();
}

class _AddHallDetailsScreenState extends State<AddHallDetailsScreen> {
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
  var hallId = const Uuid().v1();
  var hallName = TextEditingController();
  var hallAddress = TextEditingController();
  var ratePerPerson = TextEditingController();
  var maxCapacity = TextEditingController();
  var key= GlobalKey<FormState>();
  @override
  void initState() {
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
        title: const Text('ADD HALL DETAILS'),
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
                          child: AddImageWidget(
                            image: image1,
                          )),
                      InkWell(
                          onTap: () async {
                            var picker = await ImagePicker().getImage(
                              source: ImageSource.gallery,
                              imageQuality: 20,
                            );
                            setState(() {
                              image2 = File(picker!.path);
                              if (image2 != null) {
                                images.add(image2!);
                              }
                            });
                          },
                          child: AddImageWidget(
                            image: image2,
                          )),
                      InkWell(
                          onTap: () async {
                            var picker = await ImagePicker().getImage(
                                source: ImageSource.gallery, imageQuality: 20);
                            setState(() {
                              image3 = File(picker!.path);
                              if (image3 != null) {
                                images.add(image3!);
                              }
                            });
                          },
                          child: AddImageWidget(
                            image: image3,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: hallName,
                  validator: (val){
                    if(val!.isEmpty){
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
                  validator: (val){
                    if(val!.isEmpty){
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
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Enter Value';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Rate per person'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: maxCapacity,
                  validator: (val){
                    if(val!.isEmpty){
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
                            features.add('Air Condition');
                          }
                          if (ac == false) {
                            features.removeWhere(
                                (element) => element == 'Air Condition');
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
                            features.add('Caters');
                          }
                          if (caters == false) {
                            features
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
                            features.add('Photographer');
                          }
                          if (photographer == false) {
                            features
                                .removeWhere((element) => element == 'Photographer');
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
                            features.add('Music System');
                          }
                          if (musicSystem == false) {
                            features.removeWhere(
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
                            features.add('Makeup Artist');
                          }
                          if (makeUpArtist == false) {
                            features.removeWhere(
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
                            features.add('Event Manager');
                          }
                          if (eventManager == false) {
                            features.removeWhere(
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
                            features.add('Decoration');
                          }
                          if (decoration == false) {
                            features.removeWhere(
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
                            features.add('Security');
                          }
                          if (security == false) {
                            features
                                .removeWhere((element) => element == 'Security');
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
                        if(key.currentState!.validate()==false){
                          return ;
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
                          await uploadImagesAndGetDownloadLink();
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

  Future uploadImagesAndGetDownloadLink() async {
    try {
      if (image1 == null) {}
      if (image1 != null) {
        var reference1 = FirebaseStorage.instance.ref('Images/$hallId/1/');
        await reference1.putFile(image1!);
        String download1 = await reference1.getDownloadURL();
        if (kDebugMode) {
          print('Image1 DOWNLOAD URL:$download1');
        }
        imagesDownloadUrl.add(download1);
      }
      if (image2 != null) {
        var reference2 = FirebaseStorage.instance.ref('Images/$hallId/2/');
        await reference2.putFile(image2!);
        String download2 = await reference2.getDownloadURL();
        if (kDebugMode) {
          print('Image2 DOWNLOAD URL:$download2');
        }
        imagesDownloadUrl.add(download2);
      }
      if (image3 != null) {
        var reference3 = FirebaseStorage.instance.ref('Images/$hallId/3/');
        await reference3.putFile(image3!);
        String download3 = await reference3.getDownloadURL();
        if (kDebugMode) {
          print('Image3 DOWNLOAD URL:$download3');
        }
        imagesDownloadUrl.add(download3);
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (kDebugMode) {
      print(imagesDownloadUrl);
    }
  }
}
