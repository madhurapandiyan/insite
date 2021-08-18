import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/dashboard.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/dashboard/dashboard_view.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters.length,
          child: InsiteScaffold(
            screenType: ScreenType.HOME,
            onFilterApplied: () {},
            viewModel: viewModel,
            body: Container(
              color: bgcolor,
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 1000
                        ? 7
                        : MediaQuery.of(context).size.width > 600
                            ? 5
                            : 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0),
                itemBuilder: (context, index) {
                  Category category = categories[index];
                  return _buildCategoryItem(
                      context, index, category, viewModel);
                },
                itemCount: categories.length,
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Image appLogo = Image(
      image: ExactAssetImage("assets/images/hitachi.png"),
      height: 65.75,
      width: 33.21,
      alignment: FractionalOffset.center);

  Widget _buildCategoryItem(BuildContext context, int index, Category category,
      HomeViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        buttontap(index, category, viewModel);
      },
      child: Container(
        width: 118.71,
        height: 111,
        child: Card(
          semanticContainer: true,
          color: selectedIndex != null && selectedIndex == index
              ? tango
              : cardcolor,
          elevation: 10.0,
          margin: EdgeInsets.all(1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(category.image),
              SizedBox(height: 8.0),
              Text(
                category.name,
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: textcolor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buttontap(int index, Category category, HomeViewModel viewModel) {
    setState(() {
      selectedIndex = index;
    });
    viewModel.openRespectivePage(category.screenType);
  }
}
