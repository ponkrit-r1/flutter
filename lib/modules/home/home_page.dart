import 'package:deemmi/core/theme/app_colors.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

final mockDogImage =
    'https://s3-alpha-sig.figma.com/img/952e/705e/5cd22f9ed130680a0c8240212a73e224?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=KjD-ZRhmbFEQM0OkfrMm-2J80qhjMtwkt8okWryswahfFuz5Wcnz~7erbMcC~Qti7mWXvQFuTC6vAan-aDzo83A1AnT7g0got3J0ERTUKhVxBp88PG3hHMcyVdkYsqjyqozKkCdgZR-Oq5RWsWP-SJ2OdSKqRkIPMcjDVQYoD~Ynqs3vIsFBlNQHU8NSt2Y-WCrETNcLQ8~nTxwcitXu4BEvqmbcC6ipA-hZclhe6BN-~yITVA1XxjKDQXCYzi9joiG3BuWQlFkfq-kVQfDKmMNlTdtxNRaOjSv5Y9eF0x4SbKc~rjmvmKjHnqSupjusFwlNl7I91LYB6N4wscGHVg__';

final mockArticleImage =
    'https://s3-alpha-sig.figma.com/img/b131/c6cf/657c638ef0257e504858116511e9caf0?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=KLfhcfacGsNqXpRmWNEjGEfjqalo6bwNUxtfV7T2jJKCGDKYgmi~5TOyXcKbJaSTfExRamLVD0WcNXUBmh1RbsUo7oWxq6dgswAEA4R6bQ2~Mm-a8PBu26cJ4KKSrL42CUU-kCQUXNyOJS0a25WQ8tgt46mFSaCP-dIfXap1CJrbqGaMOo8~IrP0Zd2kXSZjeUDCnoechpc1ns7FH8Murd0wkOGMuAfYAMKV7tWBlEg7ONfvNe~1jdHyiAPkT2-FkW0qlmJ8AmPrH8UfytP-RrkGwqmXX5wIQHZGcqgeOLnZ7bQWswqN4f3sPLQFsHlN1YUVvMG7kxQP-tLMo2eCZQ__';
final mockArticleImage2 =
    'https://s3-alpha-sig.figma.com/img/2363/8330/054046e2edf1e7e998d63680c91fbfdb?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=De4itdjEojXJi53k32glLpSz8ULw4Us0B8K1j96RV2PPKaeAaGzooluBF2dGostonqumzs0UP2626mQRA-zvTglh-1oPWJ0PRf4UEtyq1~OfYA5yF1OuuLP5GTQVwAmgpoUuqjEyWpS7TIX7RWKXSYLp-MpRWOUZwL2nDe1ST8ioSXkgJYDV-4KhBd4pQNioPbNI-XxWHmtPPdEXQdcOanZp6fpJEvcS8MRzC7ThcWEESlSrB93ANnY~39HwQzPoLYi6uVybatI72kLmBNf2rrv6HLBIirHuL0mF2tx~gf9z5vrNdLJgSIBswvrG4xS-DD9Aflb7MTKo1tzX~o~H5Q__';

class Pet {
  final String name;
  final String imageUrl;

  Pet({required this.name, required this.imageUrl});
}

class Article {
  final String title;
  final String imageUrl;

  Article({required this.title, required this.imageUrl});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeader(),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    _buildPetList(),
                    const SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Text(
                        'Let’s get a tag for your pet!',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColor.primary500,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Image.asset(
                            'assets/images/pet_tags_2.png',
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                final Uri url =
                                    Uri.parse('https://shop.line.me/@deemmi');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.platformDefault);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.green,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/shopping_bag.svg',
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Shop now!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildArticleList(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 60,
            child: Image.asset(
              'assets/images/home_spy_cat.png',
              width: 200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleList() {
    final List<Article> articles = [
      Article(title: 'Article 1', imageUrl: mockArticleImage),
      Article(title: 'Article 2', imageUrl: mockArticleImage2),
    ];

    final screenSize = MediaQuery.of(context).size.width;
    final imageWidth = screenSize * 0.8;
    final imageHeight = imageWidth / 1.8;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Article',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColor.primary500,
                ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: imageHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: articles.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                width: imageWidth,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(articles[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPetList() {
    final List<Pet?> pets = [
      Pet(name: 'Puff', imageUrl: mockDogImage),
      Pet(name: 'Max', imageUrl: mockDogImage),
      null,
    ];

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          if (pets[index] == null) {
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DottedBorder(
                    borderType: BorderType.Circle,
                    color: AppColor.formTextColor,
                    strokeWidth: 2,
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(2),
                      child: const Center(
                          child: Icon(
                        Icons.add,
                        color: AppColor.formTextColor,
                      )),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Add',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  )
                ],
              ),
            );
          }
          return _buildPetButton(pets[index]!);
        },
      ),
    );
  }

  Widget _buildPetButton(Pet pet) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
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
                backgroundImage: NetworkImage(pet.imageUrl),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            pet.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
        color: AppColor.primaryLight,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
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
                  HeaderButton(
                    iconPath: 'assets/icons/settings.svg',
                    onTap: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  HeaderButton(
                    iconPath: 'assets/icons/bell.svg',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Hi !, ',
                  style: textTheme(context).headlineLarge?.copyWith(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                TextSpan(
                  text: ' Roong.',
                  style: textTheme(context).headlineLarge?.copyWith(
                        color: AppColor.primary500,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const HeaderButton({
    super.key,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 16,
          ),
        ),
      ),
    );
  }
}
