import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/styles.dart';
import '../../../common/models/image_data.dart';
import '../../../utill/images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeScreen extends StatefulWidget {
  final bool fromAppBar;
  const HomeScreen(this.fromAppBar, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<String> images = [Images.poster, Images.poster1, Images.poster2];
  List<String> images2 = [Images.poster1, Images.poster2, Images.poster];

  List<Map<String, dynamic>> imageWithTitleList = [
    {"image": Images.burger, "title": "Burger"},
    {"image": Images.sandwitch, "title": "Sandwitch"},
    {"image": Images.sushi, "title": "Sushi"},
    {"image": Images.ramen, "title": "Ramen"},
    {"image": Images.drinks, "title": "Drinks"},
    {"image": Images.breakfast, "title": "Ramen"},
    {"image": Images.shwarma, "title": "sharma"},
    {"image": Images.fork, "title": "More"},

    {"image": Images.burger, "title": "Burger"},
    {"image": Images.sandwitch, "title": "Sandwitch"},
    {"image": Images.sushi, "title": "Sushi"},
    {"image": Images.ramen, "title": "Ramen"},
    {"image": Images.drinks, "title": "Drinks"},
    {"image": Images.breakfast, "title": "Ramen"},
    {"image": Images.shwarma, "title": "sharma"},
    {"image": Images.fork, "title": "More"},
    // Add more image-title pairs as needed
  ];

  final List<ImageData> foodItems = [
    ImageData(imagePath: Images.cake, title: 'Cake'),
    ImageData(imagePath: Images.chicken, title: 'Cake'),
    ImageData(imagePath: Images.lunch1, title: 'Cake'),
    ImageData(imagePath: Images.chinese, title: 'Cake'),
    // Add more items as needed
  ];

  final TextEditingController _filter = TextEditingController();
 final ScrollController _scrollController = ScrollController();
  bool _isSearchBarVisible = false;
  final page_controller = PageController();


  Widget buildImageItem(ImageData imageData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Container(
            width: 200,
            height: 180,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                imageData.imagePath,
                fit: BoxFit.cover,
                // Adjust the height as needed
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.redAccent.withOpacity(0.3),
              ),
              child: const Center(
                child: Text(
                  '-20% off',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // backgroundColor: Colors.redAccent.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 12,
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent, // Background color of the circle
                    ),
                    child:const SizedBox(
                      width: 10,
                      height:10,
                      child:  Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  const Text(
                    'ADD',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 1,
            child: IconButton(
              onPressed: () {
                // Perform action when the favorite icon is pressed
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    page_controller.addListener(() {
      setState(() {
        _currentIndex = page_controller.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    setState(() {
      _isSearchBarVisible = offset > 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: MySliverAppBar(
                  expandedHeight: 120,
                  filter: _filter,
                  isSearchBarVisible: _isSearchBarVisible),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0, bottom: 10),
                child: Text(
                  'today special',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              // carousel slider image start----------------------------------
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 150,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CarouselSlider(
                        items: images.map((image) {
                          return Builder(
                            builder: (context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  image,
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                            autoPlayInterval: const Duration(seconds: 3),
                            scrollPhysics: const NeverScrollableScrollPhysics(),
                            disableCenter: true,
                            enableInfiniteScroll: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                                if(page_controller.hasClients){
                                  page_controller.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                }
                              });
                            },
                            autoPlay: true,
                            initialPage: 0,
                            viewportFraction: 1),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: CarouselSlider(
                          items: images2.map((image) {
                            return Builder(
                              builder: (context) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                              autoPlayInterval: const Duration(seconds: 3),
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                              disableCenter: true,
                              enableInfiniteScroll: true,
                              enlargeCenterPage: false,
                              autoPlay: true,
                              initialPage: 0,
                              viewportFraction: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             /* Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  images.length,
                      (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _currentIndex == index ? 16.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // Change color as needed
                    ),
                  ),
                ),
              ),*/
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: SmoothPageIndicator(
                  controller: page_controller, // Replace with your PageController
                  count: images.length,
                  axisDirection: Axis.horizontal,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.redAccent,
                    dotColor: Colors.grey,
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 6,
                    expansionFactor: 4, // Adjust the expansion factor as needed
                  ),
                ),
              ),



              // ------------------- carousel slider image end------------------------

              //------------------ dish discoveris start-------------------------
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints.loose(const Size(200, 20)),
                  child: Swiper(
                    outer: true,
                    itemBuilder: (context, index) {
                      int startIndex = index * 8;
                      int endIndex = startIndex + 8;
                      endIndex = endIndex > imageWithTitleList.length
                          ? imageWithTitleList.length
                          : endIndex;
                      return GridView.builder(

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 6.0,
                          crossAxisSpacing: 6.0,
                        ),
                        itemCount: endIndex - startIndex,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, gridIndex) {
                          String imagePath =
                              imageWithTitleList[startIndex + gridIndex]
                                  ['image'];
                          String title =
                              imageWithTitleList[startIndex + gridIndex]
                                  ['title'];

                          return Column(
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 5.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(imagePath),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  title,
                                  style: rubikRegular,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    pagination:
                        const SwiperPagination(margin: EdgeInsets.all(5.0)),
                    itemCount: (imageWithTitleList.length / 8).ceil(),
                  ),
                ),
              ),
              //------------------ dish discoveris end-------------------------

              //------------------------ local eats start----------------

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated('lets_eat', context)!,
                      style: rubikBold,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(getTranslated('discover_all', context)!))
                  ],
                ),
              ),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foodItems.length,
                  itemBuilder: (context, index) {
                    return buildImageItem(foodItems[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final TextEditingController filter;
  final bool isSearchBarVisible;

  MySliverAppBar({
    required this.expandedHeight,
    required this.filter,
    required this.isSearchBarVisible,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var searchBarOffset = expandedHeight - shrinkOffset - 40;
    var topPosition = searchBarOffset < 0 ? 0 : searchBarOffset;

    // Calculate the visibility of the background color based on scroll position
    bool isBackgroundVisible = shrinkOffset < expandedHeight - kToolbarHeight;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        if (isBackgroundVisible)
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: isSearchBarVisible ? 0.0 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red, // Your desired background color
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Location',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      'Dhanmondi',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Positioned(
          top: isSearchBarVisible ? 15 : topPosition.toDouble() + 15,
          left: 15,
          right: 15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 55,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: Colors.redAccent, // Border color for the text field
                    width: 1.5, // Border width
                  ),
                ),
                child: Center(
                  child: CupertinoTextField(
                    controller: filter,
                    keyboardType: TextInputType.text,
                    placeholder: 'Are you Hungry?',
                    placeholderStyle: const TextStyle(
                      color: Color(0xffC4C6CC),
                      fontSize: 14.0,
                      fontFamily: 'Rubik',
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.fromLTRB(6.0, 5.0, 0.0, 5.0),
                      child: Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
