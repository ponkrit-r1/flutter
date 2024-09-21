import 'package:deemmi/core/global_widgets/primary_button.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/list/pet_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/domain/pet/pet_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({super.key});

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  final _controller = Get.find<PetListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'My pets',
          style: textTheme(context)
              .headlineSmall!
              .copyWith(color: AppColor.textColor),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.addPet);
              },
              icon: const Icon(
                Icons.add,
                color: AppColor.primary500,
              ))
        ],
      ),
      body: Obx(() => _body(context)),
    );
  }

  _body(BuildContext context) {
    if (_controller.isLoading.isTrue) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.secondary500),
        ),
      );
    }
    if (_controller.petList.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          16.0,
          0,
          16.0,
          64.0,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return _petItem(_controller.petList.elementAtOrNull(index)!, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0);
        },
        itemCount: _controller.petList.length,
      );
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/onboarding_3.webp',
                  height: Get.width / 2,
                  width: Get.width / 2,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 24),
                Text(
                  "Your pet list is empty.",
                  textAlign: TextAlign.center,
                  style: textTheme(context).headlineSmall?.copyWith(
                        color: AppColor.secondaryContentGray,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Don't forget to add your pet to record their information and get notified on their important schedules.",
                  textAlign: TextAlign.center,
                  style: textTheme(context).bodyMedium?.copyWith(
                        color: AppColor.secondaryContentGray,
                      ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      title: 'Add pet',
                      color: AppColor.primary500,
                      onPressed: () {
                        navigateToAddPet();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ],
      ));
    }
  }

  _petItem(
    PetModel petModel,
    int idx,
  ) {
    return InkWell(
      onTap: () {
        navigateToPetProfile(petModel);
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Stack(children: [
                    Positioned.fill(
                      child: Image.memory(
                        petModel.imageData!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      bottom: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColor.secondaryBgColor,
                        ),
                        child: const Icon(
                          Icons.male_rounded,
                          color: AppColor.primary500,
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petModel.name,
                      style: textTheme(context)
                          .headline4!
                          .copyWith(color: AppColor.primary500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      petModel.name,
                      style: textTheme(context)
                          .bodyMedium!
                          .copyWith(color: AppColor.secondaryContentGray),
                    ),
                    Text(
                      "${petModel.weight.toString()} kg",
                      style: textTheme(context)
                          .bodyMedium!
                          .copyWith(color: AppColor.secondaryContentGray),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  showPetOption(petModel);
                },
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPetOption(
    PetModel petModel,
  ) {
    var bottomSheet = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SizedBox(
        height: 150,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                navigateToPetProfile(petModel);
              },
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: AppColor.secondaryBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.remove_red_eye_sharp,
                      color: AppColor.primary500),
                ),
                title: Text(
                  "View pet profile",
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: AppColor.primary500),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.primary500,
                ),
              ),
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: AppColor.secondaryBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    const Icon(Icons.delete_rounded, color: AppColor.redError),
              ),
              title: Text(
                "Remove",
                style: textTheme(context)
                    .bodyMedium
                    ?.copyWith(color: AppColor.redError),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.redError,
              ),
            )
          ],
        ),
      ),
    );
    Get.bottomSheet(bottomSheet);
  }

  navigateToPetProfile(PetModel pet) async {
    var result = await Get.toNamed(Routes.petProfile, arguments: {
      RouteParams.petModel: pet,
    });
  }

  navigateToAddPet() async {
    var result = await Get.toNamed(Routes.addPet);
    if (result != null) {
      _controller.getMyPet();
    }
  }
}
