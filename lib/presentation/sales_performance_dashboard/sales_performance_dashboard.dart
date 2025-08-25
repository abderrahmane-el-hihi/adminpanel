import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/pipeline_funnel_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/sales_filters_widget.dart';
import './widgets/sales_kpi_card_widget.dart';
import './widgets/sales_leaderboard_widget.dart';
import './widgets/top_opportunities_widget.dart';

class SalesPerformanceDashboard extends StatefulWidget {
  const SalesPerformanceDashboard({super.key});

  @override
  State<SalesPerformanceDashboard> createState() =>
      _SalesPerformanceDashboardState();
}

class _SalesPerformanceDashboardState extends State<SalesPerformanceDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isConnected = true;
  String _selectedTerritory = 'All';
  String _selectedRep = 'All';
  String _selectedPeriod = 'This Month';
  String _leaderboardPeriod = 'This Month';

  // Mock data for sales performance
  final List<Map<String, dynamic>> _kpiData = [
    {
      'title': 'Current Revenue',
      'value': '\$2.4M',
      'change': '+12.5%',
      'isPositive': true,
      'target': '\$2.8M',
      'sparklineData': [1.8, 2.0, 1.9, 2.2, 2.1, 2.3, 2.4],
    },
    {
      'title': 'Pipeline Value',
      'value': '\$8.7M',
      'change': '+8.3%',
      'isPositive': true,
      'target': '\$9.2M',
      'sparklineData': [7.2, 7.8, 8.1, 8.0, 8.3, 8.5, 8.7],
    },
    {
      'title': 'Conversion Rate',
      'value': '24.8%',
      'change': '-2.1%',
      'isPositive': false,
      'target': '28.0%',
      'sparklineData': [28.0, 26.5, 25.8, 26.2, 25.1, 24.9, 24.8],
    },
    {
      'title': 'Avg Deal Size',
      'value': '\$45.2K',
      'change': '+15.7%',
      'isPositive': true,
      'target': '\$48.0K',
      'sparklineData': [38.5, 41.2, 42.8, 44.1, 43.9, 44.8, 45.2],
    },
  ];

  final List<Map<String, dynamic>> _pipelineData = [
    {
      'stage': 'Lead',
      'value': '1,250,000',
      'deals': [
        {
          'client': 'Sarah Johnson',
          'company': 'TechCorp Solutions',
          'value': '125,000',
          'probability': 25,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
        {
          'client': 'Michael Chen',
          'company': 'Global Industries',
          'value': '89,500',
          'probability': 30,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
        {
          'client': 'Emily Rodriguez',
          'company': 'Innovation Labs',
          'value': '156,000',
          'probability': 20,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
      ],
    },
    {
      'stage': 'Qualified',
      'value': '2,180,000',
      'deals': [
        {
          'client': 'David Wilson',
          'company': 'Enterprise Systems',
          'value': '245,000',
          'probability': 45,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
        {
          'client': 'Lisa Thompson',
          'company': 'Digital Dynamics',
          'value': '178,500',
          'probability': 50,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
      ],
    },
    {
      'stage': 'Proposal',
      'value': '1,890,000',
      'deals': [
        {
          'client': 'Robert Martinez',
          'company': 'Future Tech Inc',
          'value': '320,000',
          'probability': 70,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
        {
          'client': 'Jennifer Lee',
          'company': 'Smart Solutions',
          'value': '195,000',
          'probability': 65,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
      ],
    },
    {
      'stage': 'Negotiation',
      'value': '1,450,000',
      'deals': [
        {
          'client': 'James Anderson',
          'company': 'Mega Corp',
          'value': '450,000',
          'probability': 85,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
      ],
    },
    {
      'stage': 'Closed Won',
      'value': '2,400,000',
      'deals': [
        {
          'client': 'Amanda Davis',
          'company': 'Success Enterprises',
          'value': '380,000',
          'probability': 100,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
        {
          'client': 'Kevin Brown',
          'company': 'Victory Solutions',
          'value': '275,000',
          'probability': 100,
          'clientPhoto':
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> _topOpportunities = [
    {
      'client': 'Alexandra Smith',
      'company': 'Global Tech Solutions',
      'value': '450,000',
      'probability': 85,
      'lastContact': '2 hours ago',
      'phone': '+1-555-0123',
      'email': 'alexandra.smith@globaltech.com',
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
    {
      'client': 'Marcus Johnson',
      'company': 'Enterprise Dynamics',
      'value': '320,000',
      'probability': 75,
      'lastContact': '1 day ago',
      'phone': '+1-555-0124',
      'email': 'marcus.johnson@entdynamics.com',
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
    {
      'client': 'Rachel Williams',
      'company': 'Innovation Partners',
      'value': '285,000',
      'probability': 70,
      'lastContact': '3 hours ago',
      'phone': '+1-555-0125',
      'email': 'rachel.williams@innovpartners.com',
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
    {
      'client': 'Daniel Garcia',
      'company': 'Future Systems Inc',
      'value': '195,000',
      'probability': 65,
      'lastContact': '5 hours ago',
      'phone': '+1-555-0126',
      'email': 'daniel.garcia@futuresys.com',
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
    {
      'client': 'Sophie Chen',
      'company': 'Digital Innovations',
      'value': '175,000',
      'probability': 60,
      'lastContact': '1 day ago',
      'phone': '+1-555-0127',
      'email': 'sophie.chen@diginnovations.com',
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
  ];

  final List<Map<String, dynamic>> _salesReps = [
    {
      'name': 'Sarah Mitchell',
      'territory': 'North America',
      'revenue': '485,000',
      'deals': 12,
      'targetProgress': 96.8,
      'achievements': ['Top Performer', 'Deal Closer'],
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
    {
      'name': 'Alex Rodriguez',
      'territory': 'Europe',
      'revenue': '420,000',
      'deals': 9,
      'targetProgress': 84.2,
      'achievements': ['New Client', 'Quota Crusher'],
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
    {
      'name': 'Emma Thompson',
      'territory': 'Asia Pacific',
      'revenue': '395,000',
      'deals': 11,
      'targetProgress': 78.9,
      'achievements': ['Deal Closer'],
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
    {
      'name': 'Michael Davis',
      'territory': 'Latin America',
      'revenue': '365,000',
      'deals': 8,
      'targetProgress': 73.1,
      'achievements': ['New Client'],
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
    {
      'name': 'Jessica Wang',
      'territory': 'North America',
      'revenue': '340,000',
      'deals': 10,
      'targetProgress': 68.5,
      'achievements': ['Top Performer'],
      'photo':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
    },
  ];

  final List<String> _territories = [
    'All',
    'North America',
    'Europe',
    'Asia Pacific',
    'Latin America'
  ];
  final List<String> _salesRepsList = [
    'All',
    'Sarah Mitchell',
    'Alex Rodriguez',
    'Emma Thompson',
    'Michael Davis',
    'Jessica Wang'
  ];
  final List<String> _periods = [
    'This Month',
    'This Quarter',
    'This Year',
    'Last Month',
    'Last Quarter'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Sales Performance',
        isConnected: _isConnected,
        actions: [
          IconButton(
            onPressed: _refreshData,
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: colorScheme.onSurface,
              size: 24,
            ),
            tooltip: 'Refresh data',
          ),
          IconButton(
            onPressed: _exportData,
            icon: CustomIconWidget(
              iconName: 'file_download',
              color: colorScheme.onSurface,
              size: 24,
            ),
            tooltip: 'Export data',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filters
            SalesFiltersWidget(
              selectedTerritory: _selectedTerritory,
              selectedRep: _selectedRep,
              selectedPeriod: _selectedPeriod,
              territories: _territories,
              salesReps: _salesRepsList,
              periods: _periods,
              onTerritoryChanged: (territory) {
                setState(() {
                  _selectedTerritory = territory;
                });
              },
              onRepChanged: (rep) {
                setState(() {
                  _selectedRep = rep;
                });
              },
              onPeriodChanged: (period) {
                setState(() {
                  _selectedPeriod = period;
                });
              },
              onResetFilters: () {
                setState(() {
                  _selectedTerritory = 'All';
                  _selectedRep = 'All';
                  _selectedPeriod = 'This Month';
                });
              },
            ),
            // Tab bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Team Performance'),
                ],
                labelColor: colorScheme.primary,
                unselectedLabelColor:
                    colorScheme.onSurface.withValues(alpha: 0.6),
                indicatorColor: colorScheme.primary,
                dividerColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 2.h),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildTeamPerformanceTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 2),
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuickActions,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        child: CustomIconWidget(
          iconName: 'add',
          color: colorScheme.onPrimary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // KPI Cards
          SizedBox(
            height: 18.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              itemCount: _kpiData.length,
              itemBuilder: (context, index) {
                final kpi = _kpiData[index];
                return SalesKpiCardWidget(
                  title: kpi['title'] as String,
                  value: kpi['value'] as String,
                  change: kpi['change'] as String,
                  isPositive: kpi['isPositive'] as bool,
                  target: kpi['target'] as String,
                  sparklineData: (kpi['sparklineData'] as List).cast<double>(),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
          // Pipeline and Opportunities
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pipeline Funnel (60% width)
                Expanded(
                  flex: 6,
                  child: PipelineFunnelWidget(
                    funnelData: _pipelineData,
                    onDealMoved: _handleDealMoved,
                  ),
                ),
                SizedBox(width: 2.w),
                // Top Opportunities (40% width)
                Expanded(
                  flex: 4,
                  child: TopOpportunitiesWidget(
                    opportunities: _topOpportunities,
                    onOpportunityTapped: _handleOpportunityTapped,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          // Quick Actions
          QuickActionsWidget(
            onActionTapped: _handleQuickAction,
          ),
          SizedBox(height: 10.h), // Bottom padding for FAB
        ],
      ),
    );
  }

  Widget _buildTeamPerformanceTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Sales Leaderboard
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: SalesLeaderboardWidget(
              salesReps: _salesReps,
              selectedPeriod: _leaderboardPeriod,
              onPeriodChanged: (period) {
                setState(() {
                  _leaderboardPeriod = period;
                });
              },
            ),
          ),
          SizedBox(height: 10.h), // Bottom padding for FAB
        ],
      ),
    );
  }

  void _refreshData() {
    // Simulate data refresh
    setState(() {
      _isConnected = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sales data refreshed successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _exportData() {
    // Simulate data export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exporting sales report...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleDealMoved(int stageIndex, Map<String, dynamic> deal) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deal moved to ${_pipelineData[stageIndex]['stage']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleOpportunityTapped(Map<String, dynamic> opportunity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildOpportunityDetails(opportunity),
    );
  }

  Widget _buildOpportunityDetails(Map<String, dynamic> opportunity) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 60.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 10.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          // Client info
          Row(
            children: [
              Container(
                width: 15.w,
                height: 15.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: opportunity['photo'] != null
                    ? ClipOval(
                        child: CustomImageWidget(
                          imageUrl: opportunity['photo'] as String,
                          width: 15.w,
                          height: 15.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Text(
                          (opportunity['client'] as String)
                              .substring(0, 1)
                              .toUpperCase(),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      opportunity['client'] as String,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      opportunity['company'] as String,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          // Deal details
          Row(
            children: [
              Expanded(
                child: _buildDetailCard(
                  context,
                  'Deal Value',
                  '\$${opportunity['value']}',
                  'attach_money',
                  colorScheme.primary,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildDetailCard(
                  context,
                  'Probability',
                  '${opportunity['probability']}%',
                  'trending_up',
                  AppTheme.successLight,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'call',
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text('Call'),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'email',
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  label: const Text('Email'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
    BuildContext context,
    String title,
    String value,
    String iconName,
    Color color,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: color,
            size: 24,
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String action) {
    String message = '';
    switch (action) {
      case 'add_deal':
        message = 'Opening new deal form...';
        break;
      case 'log_call':
        message = 'Opening call log...';
        break;
      case 'schedule_meeting':
        message = 'Opening calendar...';
        break;
      case 'send_proposal':
        message = 'Opening proposal template...';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: QuickActionsWidget(
          onActionTapped: (action) {
            Navigator.pop(context);
            _handleQuickAction(action);
          },
        ),
      ),
    );
  }
}
