final class MaintenanceConfig {
  const MaintenanceConfig({
    required this.isInMaintenanceMode,
    required this.message,
    this.details,
  });

  factory MaintenanceConfig.empty() => const MaintenanceConfig(
    isInMaintenanceMode: false,
    message: '',
    details: '',
  );

  final bool isInMaintenanceMode;
  final String message;
  final String? details;
}
