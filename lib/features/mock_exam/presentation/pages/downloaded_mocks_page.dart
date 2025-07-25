import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../features.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DownloadedMocksPage extends StatefulWidget {
  const DownloadedMocksPage({super.key});

  @override
  State<DownloadedMocksPage> createState() => _DownloadedMocksPageState();
}

class _DownloadedMocksPageState extends State<DownloadedMocksPage> {
  @override
  void initState() {
    super.initState();
    context.read<OfflineMockBloc>().add(FetchDownloadedMockEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.downloaded_exams,
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
      ),
      body: const DownloadedMocksTab(),
    );
  }
}
