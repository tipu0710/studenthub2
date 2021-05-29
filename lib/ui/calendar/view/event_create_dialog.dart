import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/calendar/controller/calendar_controller.dart';
import 'package:studenthub2/ui/calendar/model/event_model.dart';
import 'package:studenthub2/ui/home/model/event.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class EventCreationDialog extends StatefulWidget {
  /// to edit please pass the [position] argument of the [event]
  final DateTime selectedDate;
  final Event? event;
  final int position;

  const EventCreationDialog(
      {Key? key, required this.selectedDate, this.event, this.position = -1})
      : super(key: key);
  @override
  _EventCreationDialogState createState() => _EventCreationDialogState();
}

class _EventCreationDialogState extends State<EventCreationDialog> {
  late TextEditingController detailsController;
  late TextEditingController titleController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  double margin = 20;
  late DateTime startDate;
  late DateTime endDate;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  var rememberValue = true;

  @override
  void initState() {
    if (widget.event != null) {
      startTime = TimeOfDay(
          hour: widget.event!.dateTo!.hour,
          minute: widget.event!.dateTo!.minute);
      endTime = TimeOfDay(
          hour: widget.event!.dateFrom!.hour,
          minute: widget.event!.dateFrom!.minute);
    }
    startDate = widget.selectedDate;
    endDate =
        widget.event == null ? widget.selectedDate : widget.event!.dateTo!;
    startDateController =
        TextEditingController(text: DateFormat("yyyy-MM-dd").format(startDate));
    endDateController = TextEditingController(
      text: DateFormat("yyyy-MM-dd").format(
        DateTime(startDate.year, startDate.month, startDate.day + 1),
      ),
    );
    startTimeController = TextEditingController(
        text: dateTimeFormatter("${startTime.hour}:${startTime.minute}:00",
            dateType: DateType.time));
    endTimeController = TextEditingController(
        text: dateTimeFormatter("${endTime.hour}:${endTime.minute}:00",
            dateType: DateType.time));
    titleController = TextEditingController(
        text: widget.event == null ? "" : widget.event?.name ?? "");
    detailsController = TextEditingController(
        text: widget.event == null ? "" : widget.event?.description ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .8),
        child: Container(
            width: 320.0,
            padding: EdgeInsets.only(top: margin, bottom: margin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: margin * 2,
                          left: margin * 2,
                          right: margin * 2,
                        ),
                        child: Text(
                          'Date',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue LT 65 Medium',
                            fontSize: 12,
                            color: const Color(0xff505763),
                            height: 1.83,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: widget.event != null && widget.position == -1,
                        child: Container(
                          height: 45,
                          margin: EdgeInsets.only(
                            top: 5,
                            left: margin * 2,
                            right: margin * 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.2, color: const Color(0xff606060)),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: startDateController,
                              readOnly: true,
                              onTap: () {
                                _selectDate(true);
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xff505763),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 0, top: 0),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(
                      //     top: margin,
                      //     left: margin * 2,
                      //     right: margin * 2,
                      //   ),
                      //   child: Text(
                      //     'End Date',
                      //     style: TextStyle(
                      //       fontFamily: 'HelveticaNeue LT 65 Medium',
                      //       fontSize: 12,
                      //       color: const Color(0xff505763),
                      //       height: 1.83,
                      //     ),
                      //     textAlign: TextAlign.left,
                      //   ),
                      // ),
                      // IgnorePointer(
                      //   ignoring: widget.event != null && widget.position == -1,
                      //   child: Container(
                      //     height: 45,
                      //     margin: EdgeInsets.only(
                      //       top: 5,
                      //       left: margin * 2,
                      //       right: margin * 2,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //           width: 0.2, color: const Color(0xff606060)),
                      //     ),
                      //     child: Center(
                      //       child: TextFormField(
                      //         controller: endDateController,
                      //         readOnly: true,
                      //         onTap: () {
                      //           _selectDate(false);
                      //         },
                      //         keyboardType: TextInputType.text,
                      //         style: TextStyle(
                      //           fontSize: 13,
                      //           color: const Color(0xff505763),
                      //         ),
                      //         decoration: InputDecoration(
                      //           contentPadding: EdgeInsets.only(
                      //               left: 20, right: 20, bottom: 0, top: 0),
                      //           border: InputBorder.none,
                      //           focusedBorder: InputBorder.none,
                      //           enabledBorder: InputBorder.none,
                      //           errorBorder: InputBorder.none,
                      //           disabledBorder: InputBorder.none,
                      //         ),
                      //         validator: (text) {
                      //           if (text == null || text.isEmpty) {
                      //             return "";
                      //           } else {
                      //             return null;
                      //           }
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(
                          top: margin - 10,
                          left: margin * 2,
                          right: margin * 2,
                        ),
                        child: Text(
                          'Start Time',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue LT 65 Medium',
                            fontSize: 12,
                            color: const Color(0xff505763),
                            height: 1.83,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: widget.event != null && widget.position == -1,
                        child: Container(
                          height: 45,
                          margin: EdgeInsets.only(
                            top: 5,
                            left: margin * 2,
                            right: margin * 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.2, color: const Color(0xff606060)),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: startTimeController,
                              readOnly: true,
                              onTap: () async {
                                await _selectTime(true);
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xff505763),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 0, top: 0),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: margin - 10,
                          left: margin * 2,
                          right: margin * 2,
                        ),
                        child: Text(
                          'End Time',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue LT 65 Medium',
                            fontSize: 12,
                            color: const Color(0xff505763),
                            height: 1.83,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: widget.event != null && widget.position == -1,
                        child: Container(
                          height: 45,
                          margin: EdgeInsets.only(
                            top: 5,
                            left: margin * 2,
                            right: margin * 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.2, color: const Color(0xff606060)),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: endTimeController,
                              readOnly: true,
                              onTap: () async {
                                await _selectTime(false);
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xff505763),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 0, top: 0),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: margin,
                          left: margin * 2,
                          right: margin * 2,
                        ),
                        child: Text(
                          'Title',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue LT 65 Medium',
                            fontSize: 12,
                            color: const Color(0xff505763),
                            height: 1.83,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: widget.event != null && widget.position == -1,
                        child: Container(
                          height: 45,
                          margin: EdgeInsets.only(
                            top: 5,
                            left: margin * 2,
                            right: margin * 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.2, color: const Color(0xff606060)),
                          ),
                          child: TextFormField(
                            controller: titleController,
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue LT 65 Medium',
                              height: 1.3,
                              fontSize: 13,
                              color: const Color(0xff505763),
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              FocusScope.of(context).requestFocus();
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                            ),
                            validator: (text) {
                              if (text == null || text == "") {
                                return "";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: margin,
                          left: margin * 2,
                          right: margin * 2,
                        ),
                        child: Text(
                          'Details',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue LT 65 Medium',
                            fontSize: 12,
                            color: const Color(0xff505763),
                            height: 1.83,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: widget.event != null && widget.position == -1,
                        child: Container(
                          height: 120,
                          margin: EdgeInsets.only(
                            top: 5,
                            left: margin * 2,
                            right: margin * 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.2, color: const Color(0xff606060)),
                          ),
                          child: TextFormField(
                            controller: detailsController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue LT 65 Medium',
                              height: 1.3,
                              fontSize: 13,
                              color: const Color(0xff505763),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                            ),
                            validator: (text) {
                              if (text == null || text == "") {
                                return "";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      //remember(),
                      UiHelper().button(
                        context: context,
                        anim: true,
                        title: "SAVE",
                        onPressed: () async {
                          EventModel? event =
                              await EventController().createEvent(
                            startDateTime: startDate,
                            startTime: startTime,
                            endTime: endTime,
                            description: detailsController.text,
                            title: titleController.text,
                            position: widget.position,
                            id: widget.position != -1
                                ? widget.event?.id ?? -1
                                : -1,
                            event:
                                widget.event != null && widget.position == -1,
                          );
                          Navigator.pop(context, event);
                        },
                        height: 27,
                        width: 78,
                        fontSize: 12,
                        topMargin: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.only(
                    left: margin * 2 - 1,
                    right: margin * 2 - 13,
                  ),
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            '${widget.position == -1 ? "Create" : "Edit"} Event',
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue LT 65 Medium',
                              fontSize: 15,
                              color: primaryColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 16,
                              color: Color(0xff505763),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget remember() {
    return Container(
      height: 20,
      margin: EdgeInsets.only(
        top: 20,
        left: margin * 2,
        right: margin * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Set Reminder ',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              color: const Color(0xff252525),
            ),
            textAlign: TextAlign.left,
          ),
          FittedBox(
            child: CupertinoSwitch(
              value: rememberValue,
              activeColor: Color(0xff1E5AA7),
              onChanged: (value) {
                setState(() {
                  rememberValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(bool start) async {
    DateTime initDate = start ? startDate : endDate;
    if (initDate.isBefore(DateTime.now())) {
      initDate = DateTime.now();
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initDate, // Refer step 1
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: start
          ? DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          : startDate,
      helpText: "Select Event Date",
    );
    if (picked != null && picked != startDate) {
      setState(() {
        if (start) {
          startDate = picked;
          if (endDate.isBefore(startDate)) {
            endDate = picked.add(Duration(days: 1));
            endDateController.text = DateFormat("yyyy-MM-dd").format(endDate);
          }
          startDateController.text = DateFormat("yyyy-MM-dd").format(startDate);
        } else {
          endDate = picked;
          endDateController.text = DateFormat("yyyy-MM-dd").format(endDate);
        }
      });
    }
  }

  Future<void> _selectTime(bool start) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (picked != null && picked != startTime) {
      setState(() {
        if (start) {
          startTime = picked;
          startTimeController.text = dateTimeFormatter(
              "${startTime.hour}:${startTime.minute}:00",
              dateType: DateType.time);
          endTime = picked.replacing(minute: picked.minute + 10);
          endTimeController.text = dateTimeFormatter(
              "${endTime.hour}:${endTime.minute}:00",
              dateType: DateType.time);
        } else {
          endTime = picked;
          endTimeController.text = dateTimeFormatter(
              "${endTime.hour}:${endTime.minute}:00",
              dateType: DateType.time);
        }
      });
    }
  }
}
