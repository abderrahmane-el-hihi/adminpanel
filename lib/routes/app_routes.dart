import 'package:flutter/material.dart';
import '../presentation/hr_management_dashboard/hr_management_dashboard.dart';
import '../presentation/sales_performance_dashboard/sales_performance_dashboard.dart';
import '../presentation/executive_overview_dashboard/executive_overview_dashboard.dart';
import '../presentation/operations_monitoring_dashboard/operations_monitoring_dashboard.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String hrManagementDashboard = '/hr-management-dashboard';
  static const String salesPerformanceDashboard =
      '/sales-performance-dashboard';
  static const String executiveOverviewDashboard =
      '/executive-overview-dashboard';
  static const String operationsMonitoringDashboard =
      '/operations-monitoring-dashboard';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const HrManagementDashboard(),
    hrManagementDashboard: (context) => const HrManagementDashboard(),
    salesPerformanceDashboard: (context) => const SalesPerformanceDashboard(),
    executiveOverviewDashboard: (context) => const ExecutiveOverviewDashboard(),
    operationsMonitoringDashboard: (context) =>
        const OperationsMonitoringDashboard(),
    // TODO: Add your other routes here
  };
}
