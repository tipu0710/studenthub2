import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/calendar/controller/calendar_controller.dart';
import 'package:studenthub2/ui/calendar/model/event_model.dart';
import 'package:studenthub2/ui/home/model/event.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class EventCreationDialog extends StatefulWidget {
  final DateTime selectedDate;
  final Event? event;

  const EventCreationDialog({Key? key, required this.selectedDate, this.event})
      : super(key: key);
  @override
  _EventCreationDialogState createState() => _EventCreationDialogState();
}

class _EventCreationDialogState extends State<EventCreationDialog> {
  TextEditingController detailsController = new TextEditingController();
  //TextEditingController titleController = new TextEditingController();
  TextEditingController? startDateController;
  //TextEditingController endDateController;
  TextEditingController? timeController;

  double margin = 20;
  DateTime? selectedDate;
  TimeOfDay selectedTime = TimeOfDay.now();

  var rememberValue = true;

  @override
  void initState() {
    selectedDate = widget.selectedDate;
    startDateController = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(selectedDate!));
    // endDateController = TextEditingController(
    //   text: DateFormat("yyyy-MM-dd").format(
    //     DateTime(selectedDate.year, selectedDate.month, selectedDate.day + 1),
    //   ),
    // );
    timeController = TextEditingController(
        text: dateTimeFormatter(
            "${selectedTime.hour}:${selectedTime.minute}:00",
            dateType: DateType.time));
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
                        margin: EdgeInsets.only(top: margin,
                          left: margin * 2,
                          right: margin * 2,),
                        child: Text(
                          'Start Date',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue LT 65 Medium',
                            fontSize: 12,
                            color: const Color(0xff505763),
                            height: 1.83,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(top: 5,
                          left: margin * 2,
                          right: margin * 2,),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.2, color: const Color(0xff606060)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: startDateController,
                            readOnly: true,
                            onTap: _selectDate,
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
                      // Container(
                      //   margin: EdgeInsets.only(top: margin,
                      //     left: margin * 2,
                      //     right: margin * 2,),
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
                      // Container(
                      //   height: 45,
                      //   margin: EdgeInsets.only(top: 5,
                      //     left: margin * 2,
                      //     right: margin * 2,),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //         width: 0.2, color: const Color(0xff606060)),
                      //   ),
                      //   child: Center(
                      //     child: TextFormField(
                      //       controller: endDateController,
                      //       readOnly: true,
                      //       onTap: _selectDate,
                      //       keyboardType: TextInputType.text,
                      //       style: TextStyle(
                      //         fontSize: 13,
                      //         color: const Color(0xff505763),
                      //       ),
                      //       decoration: InputDecoration(
                      //         contentPadding: EdgeInsets.only(
                      //             left: 20, right: 20, bottom: 0, top: 0),
                      //         border: InputBorder.none,
                      //         focusedBorder: InputBorder.none,
                      //         enabledBorder: InputBorder.none,
                      //         errorBorder: InputBorder.none,
                      //         disabledBorder: InputBorder.none,
                      //       ),
                      //       validator: (text) {
                      //         if (text == null || text.isEmpty) {
                      //           return "";
                      //         } else {
                      //           return null;
                      //         }
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(top: margin - 10,
                          left: margin * 2,
                          right: margin * 2,),
                        child: Text(
                          'Time',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue LT 65 Medium',
                            fontSize: 12,
                            color: const Color(0xff505763),
                            height: 1.83,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(top: 5,
                          left: margin * 2,
                          right: margin * 2,),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.2, color: const Color(0xff606060)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: timeController,
                            readOnly: true,
                            onTap: _selectTime,
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
                      // widget.event != null
                      //     ? Container()
                      //     : Container(
                      //         margin: EdgeInsets.only(top: margin,
                      //           left: margin * 2,
                      //           right: margin * 2,),
                      //         child: Text(
                      //           'Title',
                      //           style: TextStyle(
                      //             fontFamily: 'HelveticaNeue LT 65 Medium',
                      //             fontSize: 12,
                      //             color: const Color(0xff505763),
                      //             height: 1.83,
                      //           ),
                      //           textAlign: TextAlign.left,
                      //         ),
                      //       ),
                      // widget.event != null
                      //     ? Container()
                      //     : Container(
                      //         height: 45,
                      //         margin: EdgeInsets.only(top: 5,
                      //           left: margin * 2,
                      //           right: margin * 2,),
                      //         decoration: BoxDecoration(
                      //           border: Border.all(
                      //               width: 0.2, color: const Color(0xff606060)),
                      //         ),
                      //         child: TextFormField(
                      //           controller: titleController,
                      //           style: TextStyle(
                      //             fontFamily: 'HelveticaNeue LT 65 Medium',
                      //             height: 1.3,
                      //             fontSize: 13,
                      //             color: const Color(0xff505763),
                      //           ),
                      //           textInputAction: TextInputAction.next,
                      //           onSaved: (value) {
                      //             FocusScope.of(context).requestFocus();
                      //           },
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             focusedBorder: InputBorder.none,
                      //             enabledBorder: InputBorder.none,
                      //             errorBorder: InputBorder.none,
                      //             disabledBorder: InputBorder.none,
                      //             contentPadding: EdgeInsets.only(
                      //                 left: 20, right: 20, top: 10, bottom: 10),
                      //           ),
                      //           validator: (text) {
                      //             if (text == null || text == "") {
                      //               return "";
                      //             } else {
                      //               return null;
                      //             }
                      //           },
                      //         ),
                      //       ),
                      widget.event != null
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(top: margin,
                                left: margin * 2,
                                right: margin * 2,),
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
                      widget.event != null
                          ? Container()
                          : Container(
                              height: 120,
                              margin: EdgeInsets.only(top: 5,
                                left: margin * 2,
                                right: margin * 2,),
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
                      //remember(),
                      UiHelper().button(
                        context: context,
                        anim: true,
                        title: "SAVE",
                        onPressed: () async {
                          EventModel? event = await EventController()
                              .createEvent(
                                  selectedDate!,
                                  selectedTime,
                                  widget.event != null
                                      ? widget.event!.description
                                      : detailsController.text,
                                  title: widget.event?.name ?? null);
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
                    left: margin * 2-1,
                    right: margin * 2-13,
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
                            'Create Event',
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
      margin: EdgeInsets.only(top: 20,
        left: margin * 2,
        right: margin * 2,),
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

  Future _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!, // Refer step 1
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      helpText: "Select Event Date",
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDateController!.text =
            DateFormat("yyyy-MM-dd").format(selectedDate!);
      });
    }
  }

  Future<Null> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      print('Time selected: ${selectedTime.toString()}');
      setState(() {
        selectedTime = picked;
        timeController!.text = dateTimeFormatter(
            "${selectedTime.hour}:${selectedTime.minute}:00",
            dateType: DateType.time);
      });
    }
  }
}
