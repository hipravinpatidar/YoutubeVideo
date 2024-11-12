import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pravin_mspl/view/tabsscreenviews/tabs_screen.dart';
import '../../../model/subcategory_model.dart';
import '../../../ui_helper/custom_colors.dart';
import '../../../utils/api_service.dart';

class ListviewData extends StatefulWidget {
    const ListviewData({super.key,required this.categoryName, required this.categoryId});

   final String categoryName;
   final int categoryId;

  @override
  State<ListviewData> createState() => _ListviewDataState();
}

class _ListviewDataState extends State<ListviewData> {

  bool _isLoading = false ;

  @override
  void initState() {
    getSubcategoryData(widget.categoryId);
    print(widget.categoryId);
    super.initState();
  }

  List<KathaModel> subcategory = [];

  // SubCategory API
  Future<void> getSubcategoryData(int categoryId) async {
    setState(() {
      _isLoading = true;
    });

    try{

      final url =
          'https://mahakal.rizrv.in/api/v1/astro/get-by-youtube-category/$categoryId';
      final res = await ApiService().getSubcategory(url);

      print(res);

      final subCategoryData = kathaModelFromJson(jsonEncode(res));

      setState(() {
        subcategory = subCategoryData;
      });
      print(subcategory.length);
    }
    catch(e){
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    List<KathaModel> filteredCategories = subcategory.where((cat) => cat.status != 0).toList();

    return SafeArea(child:

    _isLoading
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
              height: screenWidth * 0.3,
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
                          getSubcategoryData(widget.categoryId);
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
                      ),

                      SizedBox(height: screenWidth * 0.01,),
                      Text("Or",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: screenWidth * 0.01,),

                      Text("Empty Data",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenWidth * 0.05),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ))
        :
      Scaffold(
      backgroundColor: CustomColors.clrwhite,
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: filteredCategories.length,
              padding: EdgeInsets.only(left: screenWidth * 0.04,bottom: screenHeight * 0.02,right: screenWidth * 0.04),
              shrinkWrap: true,
              itemBuilder: (context, index) {

                return  Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:CustomColors.clrskyblue,
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02,horizontal: screenWidth * 0.02),
                          child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TabsScreen(
                                          subCategoryId: filteredCategories[index].id,
                                          categoryName: widget.categoryName,
                                        )
                                    ));
                                },
                            child: Row(
                              children: [
                               Container(
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: NetworkImage("https://mahakal.rizrv.in/storage/app/public/video-subcategory-img/${filteredCategories[index].image}"),fit: BoxFit.cover)
                                    ),
                                  ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: screenWidth * 0.6, child: Text(filteredCategories[index].name,style:  TextStyle(fontWeight: FontWeight.bold,fontSize: screenWidth * 0.04,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,)),

                                        SizedBox(height: screenWidth * 0.02,),
                                        Container(
                                          width: 230,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: CustomColors.clrorange
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02,horizontal: screenWidth * 0.1),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                     Text("Watch Now",style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrwhite),),

                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                                      child:
                                                      Container(height: screenWidth * 0.06,width: screenWidth * 0.05,child: Image(image: AssetImage("assets/image/phone.png"), fit: BoxFit.cover,color: Colors.white,))

                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                 );
               },),
            )
          ],
        ),
      )
    );
  }
}
