import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key, required this.entitiesList});
  final List<ServicesEntity> entitiesList;
  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 17, top: 33),
                    child:  BackButtonWidget(
                      action: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 28,
                  left: 16,
                  right: 16,
                ),
                width: context.mediaQuery.size.width,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 17);
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.entitiesList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.entitiesList[index].image,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 13),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Container(
                            margin: const EdgeInsets.only(left: 17),
                            child: Text(
                              '${widget.entitiesList[index].title} | ${widget.entitiesList[index].hour}',
                              style: AppFonts.headline(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.only(right: 3),
                            child: IconButtonWidget(
                              size: Platform.isIOS ? null : 33,
                              color: AppColors.white,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iOSIcon: CupertinoIcons.chevron_forward,
                              androidIcon: Icons.navigate_next_sharp,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ServiceModule.servicesCollectionRoute,
                              arguments: widget.entitiesList[index],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
