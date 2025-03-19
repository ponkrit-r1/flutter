import 'dart:async';

import 'package:deemmi/core/theme/app_colors.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import 'package:deemmi/modules/pet/list/pet_list_controller.dart';

import '../../../core/domain/pet/pet_model.dart';
import '../../../core/global_widgets/global_confirm_dialog.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'package:deemmi/modules/settings/account_setting/account_setting_controller.dart';

final mockDogImage =
    'https://s3-alpha-sig.figma.com/img/952e/705e/5cd22f9ed130680a0c8240212a73e224?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=KjD-ZRhmbFEQM0OkfrMm-2J80qhjMtwkt8okWryswahfFuz5Wcnz~7erbMcC~Qti7mWXvQFuTC6vAan-aDzo83A1AnT7g0got3J0ERTUKhVxBp88PG3hHMcyVdkYsqjyqozKkCdgZR-Oq5RWsWP-SJ2OdSKqRkIPMcjDVQYoD~Ynqs3vIsFBlNQHU8NSt2Y-WCrETNcLQ8~nTxwcitXu4BEvqmbcC6ipA-hZclhe6BN-~yITVA1XxjKDQXCYzi9joiG3BuWQlFkfq-kVQfDKmMNlTdtxNRaOjSv5Y9eF0x4SbKc~rjmvmKjHnqSupjusFwlNl7I91LYB6N4wscGHVg__';






class Pet {
  final String name;
  final String imageUrl;

  Pet({required this.name, required this.imageUrl});
}

class Article {
  final String title;
  final String imageUrl;
  final String url;

  Article({required this.title, required this.imageUrl, required this.url});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  
}

class _HomePageState extends State<HomePage>  with WidgetsBindingObserver {
 final PetListController _controller = Get.find<PetListController>();

 Timer? _timer;
String username = '';
  @override
  void initState() {
    super.initState();
    print("Start");
    WidgetsBinding.instance.addObserver(this); // Register as an observer

    _controller.getMyPet();
    

 // ✅ เรียก Get.find() เพื่อดึงข้อมูลจาก AccountSettingController
  try {
    final accountController = Get.find<AccountSettingController>();
    username = accountController.profile?.username ?? '';
  } catch (e) {
    print('Error loading AccountSettingController: $e');
  }


  // _timer = Timer(const Duration(seconds: 5), () {
  //   if (mounted) {
  //     _controller.getMyPet();
  //   }
  // });
    // ตั้ง Timer เพื่อรีเฟรชข้อมูลทุกๆ 5 วินาที
    // _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
    //   if (mounted) {
    //     _controller.getMyPet();
    //   }
    // });
  }



@override
Widget build(BuildContext context) {


  final double topPadding = MediaQuery.of(context).padding.top;

  return Scaffold(
    body: Container(
      color: AppColor.homeBackground,
      child: Stack(
        children: [
          // ✅ ใช้ ClipRRect เพื่อทำมุมโค้ง
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 150 + topPadding,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30), // ✅ เพิ่มโค้งด้านล่างซ้าย
              ),
              child: Container(
                padding: EdgeInsets.only(top: topPadding),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg_0.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: _buildHeader(),
              ),
            ),
          ),

          // ✅ Content หลังจาก bg (ListView)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 170 + topPadding),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _controller.getMyPet();
                  },
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(height: 2),
                      _buildPetList(),
                      const SizedBox(height: 10),
                      _buildUpcoming(),
                      _buildArticleList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


  // @override
  // Widget build(BuildContext context) {

  //   return Container(
  //   color: AppColor.homeBackground,
  //   child: SafeArea(
  //      top: true,
  // bottom: false,
  // left: false,
  // right: false,
  //     child: Stack(
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             _buildHeader(),
  //             Expanded(
  //               child: Stack(
  //                 children: [
  //                     RefreshIndicator(
  //                     onRefresh: () async {
  //                       // Refresh data when pulled down
  //                       await _controller.getMyPet();
  //                     },
  //                     child: 
  //                   ListView(
  //                 children: [
  //                   const SizedBox(
  //                     height: 30,
  //                   ),
  //                   _buildPetList(),
  //                   // const SizedBox(
  //                   //   height: 35,
  //                   // ),
  //                   // Center(
  //                   //   child: Text(
  //                   //     'Let’s get a tag for your pet!',
  //                   //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
  //                   //           color: AppColor.primary500,
  //                   //         ),
  //                   //   ),
  //                   // ),
  //                   // const SizedBox(
  //                   //   height: 10,
  //                   // ),
  //                   // Stack(
  //                   //   children: [
  //                   //     Padding(
  //                   //       padding: const EdgeInsets.only(bottom: 30),
  //                   //       child: Image.asset(
  //                   //         'assets/images/pet_tags_2.png',
  //                   //         width: double.infinity,
  //                   //       ),
  //                   //     ),
  //                   //     Positioned(
  //                   //       bottom: 0,
  //                   //       left: 0,
  //                   //       right: 0,
  //                   //       child: Center(
  //                   //         child: GestureDetector(
  //                   //           onTap: () async {
  //                   //             final Uri url =
  //                   //                 Uri.parse('https://shop.line.me/@deemmi');
  //                   //             if (await canLaunchUrl(url)) {
  //                   //               await launchUrl(url,
  //                   //                   mode: LaunchMode.platformDefault);
  //                   //             } else {
  //                   //               throw 'Could not launch $url';
  //                   //             }
  //                   //           },
  //                   //           child: Container(
  //                   //             padding: const EdgeInsets.symmetric(
  //                   //               horizontal: 20,
  //                   //               vertical: 15,
  //                   //             ),
  //                   //             decoration: BoxDecoration(
  //                   //               color: AppColor.green,
  //                   //               borderRadius: BorderRadius.circular(30),
  //                   //             ),
  //                   //             child: Row(
  //                   //               mainAxisSize: MainAxisSize.min,
  //                   //               children: [
  //                   //                 SvgPicture.asset(
  //                   //                   'assets/icons/shopping_bag.svg',
  //                   //                 ),
  //                   //                 const SizedBox(
  //                   //                   width: 10,
  //                   //                 ),
  //                   //                 Text(                      
  //                   //                   AppLocalizations.of(context)!.shopnow,
  //                   //                   style: Theme.of(context)
  //                   //                       .textTheme
  //                   //                       .bodyLarge
  //                   //                       ?.copyWith(
  //                   //                         color: Colors.white,
  //                   //                         fontWeight: FontWeight.w600,

  //                   //                       ),
  //                   //                 ),
  //                   //                 const SizedBox(
  //                   //                   width: 10,
  //                   //                 ),
  //                   //                 Icon(
  //                   //                   Icons.chevron_right,
  //                   //                   color: Colors.white,
  //                   //                 ),
  //                   //               ],
  //                   //             ),
  //                   //           ),
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //   ],
  //                   // ),
                    
                    
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                    _buildUpcoming(),
  //                   _buildArticleList(),
  //                 ],
  //                   )
  //                     )
  //           ]
  //               ),
  //             ),
  //           ],
  //         ),
  //         // Positioned(
  //         //   right: 0,
  //         //   top: 60,
  //         //   child: Image.asset(
  //         //     'assets/images/home_spy_cat.png',
  //         //     width: 200,
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   )
 
 
  //   );
 
  // } // end widget


Widget _buildUpcoming() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today, // ไอคอนหน้า Upcoming
              color: AppColor.primary500,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.upcoming,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColor.primary500,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildUpcomingItem(
          title: "Vaccine abc",
          subtitle: "23 July 2024 (30 Days)\nat MJ animal health center",
          status: "Appointed",
        ),
        const SizedBox(height: 10),
        _buildUpcomingItem(
          title: "กำจัดเห็บหมัด",
          subtitle: "23 July 2024 (30 Days)\nat MJ animal health center",
          status: "Appointed",
        ),
      ],
    ),
  );
}

Widget _buildUpcomingItem({
  required String title,
  required String subtitle,
  required String status,
}) {
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white, // พื้นหลังสีขาว
      borderRadius: BorderRadius.circular(12), // มุมโค้ง
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2), // เงา
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3), // ตำแหน่งเงา
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.dark500,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.secondaryContentGray,
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),
       Chip(
  label: Text(
    status,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: const Color(0xFF55C7AE), // สีเขียวอ่อนตามดีไซน์
          fontWeight: FontWeight.w600, // เพิ่มน้ำหนัก font
        ),
  ),
  backgroundColor: Colors.white, // พื้นหลังสีขาว
  shape:const StadiumBorder(
    side: BorderSide(
      color:  Color(0xFF55C7AE), // Border สีเขียวอ่อน
      width: 1.0, // ความกว้างของเส้น border
    ),
  ),
),

          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            // Add your navigation or action here
          },
          child: Text(
            AppLocalizations.of(context)!.change,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.primary500,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    ),
  );
}



Widget _buildArticleList() {

  final List<Article> articles = [
    Article(
      title: 'เทรนด์ฮิต! พาหมาเที่ยว ต้องมีไอเทมอะไรบ้าง?',
      imageUrl: 'assets/articles/ar1.png',
      url: 'https://pet.deemmi.com/dogs-items-travelling/',
    ),
    Article(
      title: 'ห้ามหมากินช็อกโกแลต! ภัยร้ายใกล้ตัวที่เจ้าของต้องระวัง',
      imageUrl: 'assets/articles/ar2.png',
      url: 'https://pet.deemmi.com/dogs-chocholate-toxic/',
    ),
    Article(
      title: 'ถอดรหัสภาษากายหมาแมว ต่างกันไงทาสต้องรู้!',
      imageUrl: 'assets/articles/ar3.png',
      url: 'https://pet.deemmi.com/dogs-cats-body-languages/',
    ),
    Article(
      title: 'ฮีโร่ 4 ขา สุนัขตำรวจพันธุ์แกร่ง กว่าจะเป็น K9 ไม่ง่าย',
      imageUrl: 'assets/articles/ar4.png',
      url: 'https://pet.deemmi.com/dogs-k9-heros/',
    ),
    Article(
      title: '5 สายพันธุ์หมาสุดแสบ ที่จะทำให้คุณหลงรัก!',
      imageUrl: 'assets/articles/ar5.png',
      url: 'https://pet.deemmi.com/dogs-five-breeds-naughty/',
    ),
    Article(
      title: 'แมวไทยมงคล เลี้ยงแล้ว โชค เฮง รวย',
      imageUrl: 'assets/articles/ar6.png',
      url: 'https://pet.deemmi.com/cats-lucky-breed/',
    ),
  ];

  final screenSize = MediaQuery.of(context).size.width;
  final imageWidth = screenSize * 0.8; // Resize width
  final imageHeight = imageWidth / 2.0; // Adjust height ratio

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          AppLocalizations.of(context)!.article,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColor.primary500,
              ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          height: imageHeight * 1.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(article.url);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.platformDefault);
                  } else {
                    throw 'Could not launch ${article.url}';
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: imageWidth,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(article.imageUrl),
                      fit: BoxFit.fill, // Scale the image proportionally
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      const SizedBox(height: 50), // Add bottom space
    ],
  );
}

void navigateToPetProfile(PetModel pet) async {
  var result = await Get.toNamed(Routes.petProfile, arguments: {
    RouteParams.petModel: pet,
  });
}


Widget _buildPetList() {
  return Obx(() {
    // แสดง loading indicator ถ้ายังโหลดข้อมูลอยู่
    if (_controller.isLoading.isTrue) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.secondary500),
        ),
      );
    }

    // ตรวจสอบว่ามีรายการสัตว์เลี้ยงอย่างน้อยหนึ่งรายการ
    if (_controller.petList.isEmpty) {
      return const Center(
        child: Text(
          'No pets available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // ถ้ามีมากกว่า 2 รายการ ให้แสดงเฉพาะ 2 ตัวล่าสุด
    final petListToDisplay = _controller.petList.length > 2
        ? _controller.petList.sublist(_controller.petList.length - 2) // เลือก 2 รายการสุดท้าย
        : _controller.petList;

    return RefreshIndicator(
      onRefresh: () => _controller.getMyPet(),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          itemCount: petListToDisplay.length + 1, // เพิ่มปุ่ม Add เข้าไป
          itemBuilder: (context, index) {
            // ถ้าเป็นปุ่มสุดท้าย ให้เป็นปุ่ม Add Pet
            if (index == petListToDisplay.length) {
              return GestureDetector(
                onTap: () {
                  try {
                    Get.toNamed(Routes.addPet);
                  } catch (e) {
                    print("Navigation error: $e");
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DottedBorder(
                        borderType: BorderType.Circle,
                        color: AppColor.formTextColor,
                        strokeWidth: 1,
                        child: Container( // ------> ปุ่ม add pet profile
                          width: 44,
                          height: 43,
                          padding: const EdgeInsets.all(2),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: AppColor.formTextColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Add',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 153, 168, 175),
                            ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // แสดงข้อมูลสัตว์เลี้ยง
            final pet = petListToDisplay[index];
            return _buildPetButton(pet);
          },
        ),
      ),
    );
  });
}

  Widget _buildPetButton(PetModel pet) {
    return GestureDetector(
      onTap: () {
        navigateToPetProfile(pet);
      },
      child: Container( //--------------> ขนาด วงกลม pet profile ก่อน ปุ่ม add
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColor.primaryLight,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Colors.green,
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: pet.image != null
                      ? NetworkImage(pet.image!)
                      : const AssetImage('assets/images/empty_pet_info.webp')
                          as ImageProvider,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              pet.name.length > 8 ? '${pet.name.substring(0, 8)}...' : pet.name,
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColor.dark500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
  // Widget _buildPetList() {
  //     final _controller = Get.find<PetListController>();
  //   final List<Pet?> pets = [
  //     Pet(name: 'Puff', imageUrl: mockDogImage),
  //     Pet(name: 'Max', imageUrl: mockDogImage),
  //     null,
  //   ];

  //   return SizedBox(
  //     height: 70,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       padding: const EdgeInsets.symmetric(horizontal: 10),
  //       itemCount: pets.length,
  //       itemBuilder: (context, index) {
  //         if (pets[index] == null) {
  //  return GestureDetector(
  //             onTap: () {
  //             try {
  //                 Get.toNamed(Routes.addPet);
  //               } catch (e) {
  //                 print("Navigation error: $e");
  //               }
  //             },
  //             child: Container(
  //               margin: const EdgeInsets.only(right: 10),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   DottedBorder(
  //                     borderType: BorderType.Circle,
  //                     color: AppColor.formTextColor,
  //                     strokeWidth: 1,
  //                     child: Container(
  //                       width: 36,
  //                       height: 36,
  //                       padding: const EdgeInsets.all(2),
  //                       child: const Center(
  //                         child: Icon(
  //                           Icons.add,
  //                           color: AppColor.formTextColor,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 2),
  //                   Text(
  //                     'Add',
  //                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //                           fontWeight: FontWeight.w700,
  //                           color: const Color.fromARGB(255, 153, 168, 175),
  //                         ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );

  //         }
  //         return _buildPetButton(pets[index]!);
  //       },
  //     ),
  //   );
  // }

  // Widget _buildPetButton(Pet pet) {
    
  //   return Container(
  //     margin: const EdgeInsets.only(right: 10),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           width: 40,
  //           height: 40,
  //           padding: const EdgeInsets.all(2),
  //           decoration: BoxDecoration(
  //             color: AppColor.primaryLight,
  //             shape: BoxShape.circle,
  //             border: Border.all(
  //               width: 1,
  //               color: Colors.green,
  //             ),
  //           ),
  //           child: Center(
  //             child: CircleAvatar(
  //               backgroundImage: NetworkImage(pet.imageUrl),
  //               backgroundColor: Colors.white,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 2),
  //         Text(
  //           pet.name,
  //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //                 fontWeight: FontWeight.w700,
  //                 color: AppColor.dark500
  //               ),
  //         )
  //       ],
  //     ),
  //   );
  // }


Widget _buildHeader() {
  return Stack(
    children: [
      // Content ที่มี Padding และพื้นหลัง
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        decoration: const BoxDecoration(
         image: DecorationImage(
          image: AssetImage('assets/images/bg_0.png'),
          fit: BoxFit.fill, // Adjust how the image is displayed
        ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 40,
                ),
                Row(
                  children: [
  Container(
    width: 30, // กำหนดขนาดความกว้างของ icon
    height: 30, // กำหนดขนาดความสูงของ icon
    decoration: const BoxDecoration(
      color: Color(0xFF93B4FB), // สีพื้นหลังเป็น #93B4FB
      shape: BoxShape.circle, // ทำให้เป็นวงกลม
    ),
    child: HeaderButton(
      iconPath: 'assets/icons/settings.svg',
      onTap: () {
        try {
          Get.toNamed(Routes.account_setting);
        } catch (e) {
          print("Navigation error: $e");
        }
      },
       backgroundColor: const Color(0xFF93B4FB), // พื้นหลังเป็นสี #93B4FB
  iconColor: Colors.white, // ไอคอนเป็นสีขาว
    ),
  ),
  const SizedBox(width: 10),
  // Container(
  //   width: 30,
  //   height: 30,
  //   decoration: BoxDecoration(
  //     color: Color(0xFF93B4FB), // สีพื้นหลังเป็น #93B4FB
  //     shape: BoxShape.circle,
  //   ),
  //   child: HeaderButton(
  //     iconPath: 'assets/icons/bell.svg',
  //     onTap: () {
  //       try {
  //         Get.toNamed(Routes.notification);
  //       } catch (e) {
  //         print("Navigation error: $e");
  //       }
  //     },
  //      backgroundColor: Color(0xFF93B4FB), // พื้นหลังเป็นสี #93B4FB
  // iconColor: Colors.white, // ไอคอนเป็นสีขาว
  //   ),
  // ),
],

                ),
              ],
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Hi !, ',
                    style: textTheme(context).headlineLarge?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                        ),
                  ),



                  TextSpan(
                    text: username,
                    style: textTheme(context).headlineLarge?.copyWith(
                          color: AppColor.primary500,
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                        ),
                  )


                ],
              ),
            ),
          ],
        ),
      ),
      // รูป home_dog_bg.png วางไว้ layer บนสุด
     Positioned(
        bottom: 0, // ชิดด้านล่างของพื้นที่
        right: 0, // ชิดขวา
        child: Image.asset(
          'assets/images/home_dog_bg.png',
          width: 350, // ปรับขนาดตามต้องการ
          fit: BoxFit.contain, // ปรับให้รูปไม่ผิดสัดส่วน
        ),
      ),
    ],
  );
}










  // Widget _buildHeader() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.symmetric(
  //       vertical: 20,
  //       horizontal: 20,
  //     ),
  //     decoration: const BoxDecoration(
  //       color: AppColor.primaryLight,
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(30),
  //         bottomRight: Radius.circular(30),
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Image.asset(
  //               'assets/images/app_logo.png',
  //               height: 40,
  //             ),
  //             Row(
  //               children: [
  //                 HeaderButton(
  //                   iconPath: 'assets/icons/settings.svg',
  //                     onTap: () {
  //                     try {
  //                       Get.toNamed(Routes.account_setting);
  //                     } catch (e) {
  //                       print("Navigation error: $e");
  //                     }
  //                   },
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 HeaderButton(
  //                   iconPath: 'assets/icons/bell.svg',
  //                    onTap: () {
  //                     try {
  //                       Get.toNamed(Routes.notification);
  //                     } catch (e) {
  //                       print("Navigation error: $e");
  //                     }
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         RichText(
  //           text: TextSpan(
  //             children: <InlineSpan>[
  //               TextSpan(
  //                 text: 'Hi !, ',
  //                 style: textTheme(context).headlineLarge?.copyWith(
  //                       color: AppColor.textColor,
  //                       fontWeight: FontWeight.w600,
  //                        fontSize: 26,
  //                     ),
  //               ),
  //               TextSpan(
  //                 text: ' Roong.',
  //                 style: textTheme(context).headlineLarge?.copyWith(
  //                       color: AppColor.primary500,
  //                       fontWeight: FontWeight.w600,
  //                        fontSize: 26,
  //                     ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }





}

class HeaderButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  final Color backgroundColor; // สีพื้นหลัง
  final Color iconColor; // สีของไอคอน

  const HeaderButton({
    super.key,
    required this.iconPath,
    required this.onTap,
    this.backgroundColor = Colors.white, // ค่าเริ่มต้นสีพื้นหลัง
    this.iconColor = Colors.black, // ค่าเริ่มต้นสีไอคอน
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: backgroundColor, // สีพื้นหลัง
          shape: BoxShape.circle, // ทำให้เป็นวงกลม
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn), // เปลี่ยนสีไอคอน
          ),
        ),
      ),
    );
  }
}
