sealed class SplashState {
  const SplashState();
}

class Success extends SplashState {
  const Success();
}

class UnderMaintenance extends SplashState {
  const UnderMaintenance({required this.message, this.details});

  final String message;
  final String? details;
}

class ForceUpdate extends SplashState {
  const ForceUpdate({required this.message, this.details});

  final String message;
  final String? details;
}
