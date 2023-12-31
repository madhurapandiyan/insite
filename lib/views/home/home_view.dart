import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/dashboard.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../core/models/dashboard.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
            screenType: ScreenType.HOME,
            onFilterApplied: () {},
            onRefineApplied: () {},
            viewModel: viewModel,
            body: viewModel.isLoading
                ? Center(
                    child: InsiteProgressBar(),
                  )
                : Container(
                    color: Theme.of(context).backgroundColor,
                    child: GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 1000
                                  ? 5
                                  : MediaQuery.of(context).size.width > 600
                                      ? 3
                                      : 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0),
                      itemBuilder: (context, index) {
                        Category category = categories![index];
                        return _buildCategoryItem(
                            context, index, category, viewModel);
                      },
                      itemCount: categories!.length,
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
      child: Card(
        semanticContainer: true,
        color: selectedIndex != null && selectedIndex == index
            ? Theme.of(context).buttonColor
            : Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                category.image,
                height: 25,
                width: 25,
                color: selectedIndex != null && selectedIndex == index
                    ? Colors.white
                    : Theme.of(context).iconTheme.color,
              ),
              SizedBox(height: 8.0),
              FittedBox(
                child: InsiteTextAlign(
                  textAlign: TextAlign.center,
                  color: selectedIndex != null && selectedIndex == index
                      ? Colors.white
                      : null,
                  fontWeight: FontWeight.bold,
                  size: 12,
                  text: category.name,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buttontap(int index, Category category, HomeViewModel viewModel) {
    Logger().d("buttontap ${category.screenType}");
    setState(() {
      selectedIndex = index;
    });
    viewModel.openRespectivePage(category.screenType);
  }
}
