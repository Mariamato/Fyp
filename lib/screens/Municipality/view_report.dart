import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:municipal_cms/screens/Municipality/report_widget.dart';

import '../../controllers/report_controller.dart';
import '../../models/report_model.dart';

class ViewReport extends StatefulWidget {
  const ViewReport({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  List<Report> reports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReportData();
  }

  void fetchReportData() async {
    try {
      List<Report> fetchedReports = await fetchReports();
      setState(() {
        reports = fetchedReports;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.chevron_back,
            size: 27,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("Reports List"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: const Border(
                    bottom: BorderSide(color: Colors.blue, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total reports",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Text(reports.length.toString()),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        var report = reports[index];
                        DateTime parsedDoS = report.parsedDateOfService;
                        DateTime? parsedToS = report.parsedTimeOfService;
                        String formattedDate = DateFormat('MMM, dd, yyyy')
                            .format(parsedDoS)
                            .toString();
                        String formattedTime = DateFormat('hh:mm').format(parsedToS!).toString();
                        return ReportWidget(
                            reportId: report.id!,
                            task: report.task!,
                            userName: report.userName!,
                            dateOfService: formattedDate,
                            timeOfService: formattedTime,
                            status: report.status.toString());
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
