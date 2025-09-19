import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/sponsor_data.dart';

class CustomSponsorWidget extends StatelessWidget {
  const CustomSponsorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.primary, width: 1.5.w),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(55),
            blurRadius: 10.r,
            spreadRadius: 2.r,
            offset: Offset(0.w, 5.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_SponsorTitle(), SizedBox(height: 16.h), SponsorGrid()],
      ),
    );
  }
}

class _SponsorTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.workspace_premium_rounded, color: AppColors.primary, size: 28.sp),
        SizedBox(width: 8.w),
        Text(
          'Meet Our Sponsors',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class SponsorGrid extends StatelessWidget {
  const SponsorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12.w,
      runSpacing: 12.h,
      children: List.generate(11, (index) => SponsorCard(index: index)),
    );
  }
}

class SponsorCard extends StatelessWidget {
  final int index;

  const SponsorCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _lanchUrl,
      child: SizedBox(
        width: 70.w,
        height: 50.h,
        child: Image.asset(
          'assets/images/sponsors/sponsor${index + 1}.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Future<void> _lanchUrl() async {
    final Uri uri = Uri.parse(sponsors[index].url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
