import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../data/models/ngo_model.dart';
import '../../../../data/providers/ngo_provider.dart';
import '../../utils/ngo_share_message.dart';

/// NGODetailScreen - Complete NGO information
class NGODetailScreen extends StatefulWidget {
  final NGOModel ngo;

  const NGODetailScreen({super.key, required this.ngo});

  @override
  State<NGODetailScreen> createState() => _NGODetailScreenState();
}

class _NGODetailScreenState extends State<NGODetailScreen>
    with SingleTickerProviderStateMixin {
  final _shareButtonKey = GlobalKey();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ngoProvider = Provider.of<NGOProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with cover image
          _buildAppBar(ngoProvider),

          // NGO header info
          _buildHeaderInfo(),

          // Action buttons
          _buildActionButtons(),

          // Statistics
          _buildStatistics(),

          // Tab bar
          _buildTabBar(),

          // Tab content
          _buildTabContent(),
        ],
      ),
      // Floating donate button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showDonateDialog(context);
        },
        icon: const Icon(Icons.favorite),
        label: Text(StringConstants.donate),
        backgroundColor: AppColors.secondary,
      ),
    );
  }

  /// Build app bar with cover
  Widget _buildAppBar(NGOProvider ngoProvider) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.getCategoryColor(widget.ngo.category),
                AppColors.getCategoryColor(
                  widget.ngo.category,
                ).withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.favorite,
              size: 80,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
      actions: [
        // Share button
        IconButton(
          key: _shareButtonKey,
          icon: const Icon(Icons.share),
          onPressed: _shareNgo,
        ),
        // Favorite button
        IconButton(
          icon: Icon(
            ngoProvider.isFavorite(widget.ngo.id)
                ? Icons.bookmark
                : Icons.bookmark_border,
          ),
          onPressed: () {
            ngoProvider.toggleFavorite(widget.ngo.id);
          },
        ),
      ],
    );
  }

  /// Build header info
  Widget _buildHeaderInfo() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.getCategoryColor(widget.ngo.category),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      widget.ngo.getInitials(),
                      style: AppTextStyles.displaySmall(
                        context,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Name and location
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.ngo.organizationName,
                              style: AppTextStyles.headlineMedium(context),
                            ),
                          ),
                          if (widget.ngo.isVerified)
                            const Icon(
                              Icons.verified,
                              color: AppColors.primary,
                              size: 24,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            widget.ngo.getLocation() ?? 'India',
                            style: AppTextStyles.bodyMedium(
                              context,
                              color: AppTextStyles.getSecondaryTextColor(
                                context,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < widget.ngo.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            );
                          }),
                          const SizedBox(width: 4),
                          Text(
                            '(${widget.ngo.rating.toStringAsFixed(1)})',
                            style: AppTextStyles.bodySmall(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Category chip
            Chip(
              label: Text(widget.ngo.category),
              backgroundColor: AppColors.getCategoryColor(
                widget.ngo.category,
              ).withValues(alpha: 0.2),
              labelStyle: AppTextStyles.labelMedium(
                context,
                color: AppColors.getCategoryColor(widget.ngo.category),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build action buttons
  Widget _buildActionButtons() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (widget.ngo.phoneNumber != null)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _makePhoneCall(widget.ngo.phoneNumber!),
                  icon: const Icon(Icons.phone),
                  label: Text(StringConstants.call),
                ),
              ),
            if (widget.ngo.phoneNumber != null && widget.ngo.website != null)
              const SizedBox(width: 12),
            if (widget.ngo.website != null)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _openWebsite(widget.ngo.website!),
                  icon: const Icon(Icons.language),
                  label: const Text('Website'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Build statistics
  Widget _buildStatistics() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Donations',
                '${widget.ngo.totalDonations}',
                Icons.favorite,
                AppColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Campaigns',
                '${widget.ngo.activeCampaigns}',
                Icons.campaign,
                AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Volunteers',
                '${widget.ngo.totalVolunteers}',
                Icons.people,
                AppColors.success,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build stat card
  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.titleLarge(context, color: color)),
          Text(label, style: AppTextStyles.bodySmall(context)),
        ],
      ),
    );
  }

  /// Build tab bar
  Widget _buildTabBar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkCard
                  : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          labelColor: Colors.white,
          unselectedLabelColor:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
          tabs: const [
            Tab(text: StringConstants.about),
            Tab(text: StringConstants.campaigns),
            Tab(text: StringConstants.contact),
          ],
        ),
      ),
    );
  }

  /// Build tab content
  Widget _buildTabContent() {
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        children: [_buildAboutTab(), _buildCampaignsTab(), _buildContactTab()],
      ),
    );
  }

  /// Build about tab
  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Us', style: AppTextStyles.headlineSmall(context)),
          const SizedBox(height: 12),
          Text(
            widget.ngo.description ?? 'No description available',
            style: AppTextStyles.bodyLarge(context),
          ),
          const SizedBox(height: 24),
          Text('Impact', style: AppTextStyles.headlineSmall(context)),
          const SizedBox(height: 12),
          _buildImpactItem(
            'Total Amount Received',
            '₹${_formatAmount(widget.ngo.totalAmountReceived)}',
            Icons.currency_rupee,
          ),
          _buildImpactItem(
            'Total Donations',
            '${widget.ngo.totalDonations}',
            Icons.favorite,
          ),
          _buildImpactItem(
            'Active Campaigns',
            '${widget.ngo.activeCampaigns}',
            Icons.campaign,
          ),
          _buildImpactItem(
            'Volunteers',
            '${widget.ngo.totalVolunteers}',
            Icons.people,
          ),
        ],
      ),
    );
  }

  /// Build impact item
  Widget _buildImpactItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: AppTextStyles.bodyMedium(context)),
          ),
          Text(value, style: AppTextStyles.titleMedium(context)),
        ],
      ),
    );
  }

  /// Build campaigns tab
  Widget _buildCampaignsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.campaign,
            size: 64,
            color: AppTextStyles.getSecondaryTextColor(context),
          ),
          const SizedBox(height: 16),
          Text(
            'Campaigns Coming Soon',
            style: AppTextStyles.headlineSmall(context),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for active campaigns',
            style: AppTextStyles.bodyMedium(
              context,
              color: AppTextStyles.getSecondaryTextColor(context),
            ),
          ),
        ],
      ),
    );
  }

  /// Build contact tab
  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactItem(
            'Email',
            widget.ngo.email,
            Icons.email,
            () => _sendEmail(widget.ngo.email),
          ),
          const SizedBox(height: 12),
          if (widget.ngo.phoneNumber != null) ...[
            _buildContactItem(
              'Phone',
              widget.ngo.phoneNumber!,
              Icons.phone,
              () => _makePhoneCall(widget.ngo.phoneNumber!),
            ),
            const SizedBox(height: 12),
          ],
          if (widget.ngo.website != null) ...[
            _buildContactItem(
              'Website',
              widget.ngo.website!,
              Icons.language,
              () => _openWebsite(widget.ngo.website!),
            ),
            const SizedBox(height: 12),
          ],
          if (widget.ngo.address != null) ...[
            _buildContactItem(
              'Address',
              '${widget.ngo.address}, ${widget.ngo.getLocation()}',
              Icons.location_on,
              null,
            ),
          ],
        ],
      ),
    );
  }

  /// Build contact item
  Widget _buildContactItem(
    String label,
    String value,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(label, style: AppTextStyles.labelMedium(context)),
        subtitle: Text(value, style: AppTextStyles.bodyMedium(context)),
        trailing:
            onTap != null
                ? const Icon(Icons.arrow_forward_ios, size: 16)
                : null,
        onTap: onTap,
      ),
    );
  }

  /// Show donate dialog
  void _showDonateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Donate to ${widget.ngo.organizationName}'),
            content: const Text('Donation feature coming soon!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  /// Open the platform share sheet with the NGO's available details.
  Future<void> _shareNgo() async {
    final renderObject = _shareButtonKey.currentContext?.findRenderObject();
    final shareOrigin =
        renderObject is RenderBox
            ? renderObject.localToGlobal(Offset.zero) & renderObject.size
            : null;

    await SharePlus.instance.share(
      ShareParams(
        text: buildNgoShareMessage(widget.ngo),
        sharePositionOrigin: shareOrigin,
      ),
    );
  }

  /// Make phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  /// Send email
  Future<void> _sendEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  /// Open website
  Future<void> _openWebsite(String website) async {
    String url = website;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Format amount
  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)}Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }
}

/// Interview Tip:
/// "NGO Detail Screen showcases:
/// 1. Expandable app bar with cover
/// 2. Tabbed content (About/Campaigns/Contact)
/// 3. Quick action buttons (call, website)
/// 4. Statistics display
/// 5. URL launcher integration
/// 6. Floating action button for donations"
