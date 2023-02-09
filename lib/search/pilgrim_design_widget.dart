import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'package:rafad1/search/user.dart';

class UsersDesignWidget extends StatefulWidget {
  Users? model;
  BuildContext? context;

  UsersDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<UsersDesignWidget> createState() => _UsersDesignWidgetState();
}

class _UsersDesignWidgetState extends State<UsersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
        elevation: 2,
        initialPadding: const EdgeInsets.only(bottom: 7, top: 7),
        baseColor: Colors.blueGrey[50],
        expandedColor: Colors.blueGrey[50],
        //key: cardA,
        title: Text(
          widget.model!.name!,
        ),
        subtitle: const Text(
          "Click to view pilgrim's details",
          style: TextStyle(fontSize: 11),
        ),
        children: [
          const Divider(
            thickness: 1.7,
            height: 1.0,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Center(
                      child: Column(children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Email:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.model!.email!,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Pilgrim ID:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.model!.pilgrimID!,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Pharmaceutical:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.model!.pharma!,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Disease:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.model!.disease!,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Haj ID:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.model!.hajId!,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Phone:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.model!.phone!,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]))))
        ]);
  }
}
