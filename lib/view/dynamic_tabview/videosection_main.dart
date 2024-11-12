import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/categories_model.dart';
import '../../model/subcategory_model.dart';
import '../../ui_helper/custom_colors.dart';
import '../../utils/api_service.dart';
import 'grid_view/Gridview_data.dart';
import 'list_view/Listview_data.dart';

class VideoSectionMain extends StatefulWidget {
  const VideoSectionMain({super.key});

  @override
  State<VideoSectionMain> createState() => _VideoSectionMainState();
}

class _VideoSectionMainState extends State<VideoSectionMain> {
  List<CategoriesModel> category = [];
  List<KathaModel> subcategory = [];
  bool _isGridView = true;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryData();
  }

  Future<void> refresh() async {
    setState(() {
      getCategoryData();
    });
  }

  // Category API
  Future<void> getCategoryData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final res = await ApiService().getCategory(
          'https://mahakal.rizrv.in/api/v1/astro/youtube/video/category');
      List cdata = res['videoCategory'];
      setState(() {
        category = categoriesModelFromJson(jsonEncode(cdata));
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    List<CategoriesModel> filteredCategories =
        category.where((cat) => cat.status != 0).toList();

    return SafeArea(
      child: DefaultTabController(
        length: filteredCategories.length,
        child: isLoading
            ? const Scaffold(
                backgroundColor: CustomColors.clrwhite,
                body: Center(
                    child: CircularProgressIndicator(
                  color: CustomColors.clrblack,
                )))
            : filteredCategories.isEmpty
                ? Scaffold(
                    backgroundColor: CustomColors.clrwhite,
                    body: Column(
                      children: [
                        SizedBox(
                          height: screenWidth * 0.6,
                        ),
                        Center(
                          child: SizedBox(
                            width: 300,
                            height: 330,
                            child: Card(
                              shadowColor: Colors.black,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/image/connection.png"),
                                          fit: BoxFit.cover),
                                      //color: Colors.red
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'O',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: 'oops!',
                                          style: TextStyle(
                                              fontSize: 27,
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "No Internet connection found \n Check your connection",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                  SizedBox(
                                    height: screenWidth * 0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      getCategoryData();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red.withOpacity(0.7),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.2,
                                            vertical: screenWidth * 0.03),
                                        child: Text(
                                          "Try Again",
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
                : Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size(screenWidth, screenWidth * 0.40),
                      child: AppBar(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.white,
                        title: Text(
                          "Video",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.clrorange,
                            fontSize: screenWidth * 0.06,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        centerTitle: true,
                        leading: Icon(
                          Icons.arrow_back,
                          color: CustomColors.clrblack,
                          size: screenWidth * 0.06,
                        ),
                        flexibleSpace: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.03,
                              top: screenWidth * 0.15),
                          child: Row(
                            children: [
                              Container(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.7,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CustomColors.clrgreydark,
                                    width: 0.8,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Search",
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        size: screenWidth * 0.05,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Container(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.2,
                                decoration: BoxDecoration(
                                  color: CustomColors.clrgreydark,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isGridView = true;
                                        });
                                      },
                                      child: Container(
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.08,
                                        decoration: BoxDecoration(
                                          color: _isGridView
                                              ? CustomColors.clrwhite
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: ImageIcon(
                                          const NetworkImage(
                                              "https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
                                          color: _isGridView
                                              ? CustomColors.clrorange
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isGridView = false;
                                        });
                                      },
                                      child: Container(
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.08,
                                        decoration: BoxDecoration(
                                          color:
                                              _isGridView ? null : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: ImageIcon(
                                          const AssetImage(
                                              "assets/image/myicon.png"),
                                          color: _isGridView
                                              ? CustomColors.clrblack
                                              : CustomColors.clrorange,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: TabBar(
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.black,
                          tabAlignment: TabAlignment.start,
                          indicatorColor: Colors.orange,
                          indicatorPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 18),
                          labelStyle: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          isScrollable: true,
                          tabs: List.generate(
                            filteredCategories.length,
                            (int index) =>
                                Tab(text: filteredCategories[index].name),
                          ),
                        ),
                      ),
                    ),
                    body: TabBarView(
                      children: filteredCategories.map((category) {
                        return RefreshIndicator(
                            onRefresh: () async {
                              await refresh();
                            },
                            color: CustomColors.clrblack,
                            backgroundColor: CustomColors.clrwhite,
                            child: _isGridView
                                ? ListviewData(
                                    categoryName: category.name,
                                    categoryId: category.id,
                                  )
                                : GridviewData(
                                    categoryName: category.name,
                                    categoryId: category.id,
                                  ));
                      }).toList(),
                    ),
                  ),
      ),
    );
  }
}
