import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/viewmodels/app_language_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/faq.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

class QaPage extends StatelessWidget {
  const QaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: false,
              title: Text(
                localization.labels.qa,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.defaultTextColor,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: AppDimens.padding,
            ),
          ),
          FutureBuilder<List<Qa>>(
            future: Provider.of<DbService>(context, listen: false).getQA(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Qa> qas = snapshot.data;

                return Consumer<AppLanguageViewModel>(
                  builder: (context, appLanguage, __) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final qa = qas[index];

                        Locale currentLocale = Localizations.localeOf(context);

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppDimens.padding,
                            horizontal: AppDimens.lgPadding,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                qa.getQuestionByLanguageCode(
                                    currentLocale.languageCode),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColors.defaultTextColor,
                                ),
                              ),
                              SizedBox(
                                height: AppDimens.smPadding,
                              ),
                              Html(
                                data: qa.getAnswerByLanguageCode(
                                    currentLocale.languageCode),
                                style: {
                                  "html": Style.fromTextStyle(TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.defaultTextColor,
                                  )),
                                  "strong": Style.fromTextStyle(TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.defaultTextColor,
                                  )),
                                },
                                customRender: {
                                  "icon-play": (context, _, __, ___) =>
                                      Status.opened.widget,
                                  "icon-timer": (context, _, __, ___) =>
                                      Status.pending.widget,
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: qas.length,
                    ),
                  ),
                );
              }
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: AppDimens.mdPadding,
            ),
          ),
        ],
      ),
    );
  }
}
