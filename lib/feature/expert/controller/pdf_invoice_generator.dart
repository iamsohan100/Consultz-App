import 'dart:developer';
import 'dart:io';

import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/profile/model/booking_details_model.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import 'package:consultz/core/constants/app_images.dart';
import 'package:flutter/services.dart';

class PdfInvoiceGenerator {
  static Future<void> generateAndDownloadInvoice({
    required BookingDetailsData booking,
    required bool isConsultee,
  }) async {
    try {
      // 1. Request Storage Permission (Handling different Android versions)
      bool permissionGranted = false;
      if (Platform.isAndroid) {
        // For Android 13+, Permission.storage is not used for file access like this
        // but for an app-specific external directory, no permission is actually needed.
        // However, if we want to write to public Downloads, it's complex.
        // Let's stick to a safe directory first.
        permissionGranted = true; // App-specific external storage doesn't need permission
      } else if (Platform.isIOS) {
        permissionGranted = true;
      }

      // Check if we need to request anyway for older versions or more access
      if (Platform.isAndroid && !permissionGranted) {
         var status = await Permission.storage.request();
         permissionGranted = status.isGranted;
      }

      if (!permissionGranted) {
        bottomMessage(msg: "Storage permission is required to save the invoice.");
        return;
      }

       log("Starting PDF generation...");

      // Load Logo Image
      pw.MemoryImage? logoImage;
      try {
        final ByteData bytes = await rootBundle.load(AppImages.logo);
        final Uint8List logoBytes = bytes.buffer.asUint8List();
        logoImage = pw.MemoryImage(logoBytes);
      } catch (e) {
        log("Error loading logo image: $e");
        // Continue without logo if it fails
      }

      // 2. Format necessary data
      final String expertName =
          '${booking.consult?.firstName ?? ''} ${booking.consult?.lastName ?? ''}'
              .trim();
      final String userName =
          '${booking.user?.firstName ?? ''} ${booking.user?.lastName ?? ''}'
              .trim();
      final String myName = isConsultee ? userName : expertName;
      final String otherName = isConsultee ? expertName : userName;
      final String role = isConsultee ? "Client" : "Expert";

      final String date = booking.slot?.date ?? 'N/A';
      final String time = booking.slot?.time ?? 'N/A';
      final String sessionType = (booking.sessionType ?? 'Session')
          .replaceAll('_', ' ')
          .toUpperCase();
      final String price = '£${booking.price ?? 0}';
      final String status = booking.status ?? 'completed';

      // 3. Generate PDF
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                  level: 0,
                  title: 'INVOICE',
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'INVOICE',
                        style: pw.TextStyle(
                          fontSize: 40,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      if (logoImage != null)
                        pw.Image(
                          logoImage,
                          width: 120,
                        ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 30),
                // (Rest of the PDF build logic stays same for brevity, but I'll include it to be safe)
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Billed To ($role):',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(myName),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('Date: $date'),
                        pw.Text('Time: $time'),
                        pw.Text('Booking ID: ${booking.sId ?? 'N/A'}'),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 40),
                pw.TableHelper.fromTextArray(
                  headers: [
                    'Description',
                    'Session Type',
                    'Duration',
                    'Amount',
                  ],
                  data: [
                    [
                      'Consultation with $otherName',
                      sessionType,
                      '${booking.sessionDuration ?? 0} mins',
                      price,
                    ],
                  ],
                  border: null,
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.blueGrey,
                  ),
                  cellHeight: 30,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.centerRight,
                  },
                ),
                pw.Divider(),
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Total: ',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      pw.Text(
                        price,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 40),
                pw.Text(
                  'Payment Status: ${booking.paymentStatus?.toUpperCase() ?? 'PAID'}',
                  style: pw.TextStyle(fontSize: 14),
                ),
                pw.Text('Session Status: ${status.toUpperCase()}'),
              ],
            );
          },
        ),
      );

      // 4. Save PDF to device
      Directory? directory;
      String? successMsg;

      if (Platform.isAndroid) {
        // Using app-specific external storage is the most reliable way on Android 11+
        directory = await getExternalStorageDirectory();
        successMsg = "Invoice saved to app folder and opened.";
        
        // Try to see if we can use public Downloads (optional, but good if it works)
        try {
          final publicDownloadDir = Directory('/storage/emulated/0/Download');
          if (await publicDownloadDir.exists()) {
             // We can try to write here, but it might fail on 11+ without MANAGE_EXTERNAL_STORAGE
             // So we stick to app-specific for guaranteed success.
          }
        } catch (_) {}
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
        successMsg = "Invoice generated and opened.";
      }

      if (directory != null) {
        final String filePath = '${directory.path}/invoice_${booking.sId}.pdf';
        final File file = File(filePath);
        await file.writeAsBytes(await pdf.save());

        topMessage(
          title: 'Success',
          msg: successMsg ?? "Invoice generated successfully",
        );

        log("PDF saved to: $filePath");

        // 5. Open the file immediately
        try {
          final result = await OpenFilex.open(filePath);
          log("Open file result: ${result.message}");
          if (result.type != ResultType.done) {
            bottomMessage(msg: "Could not open the PDF: ${result.message}");
          }
        } catch (e) {
          log("Error opening file: $e");
        }
      } else {
        bottomMessage(msg: "Could not access storage to save invoice.");
      }
    } catch (e) {
      log("Global error in generateAndDownloadInvoice: $e");
      bottomMessage(msg: "Failed to generate invoice: $e");
    }
  }
}
