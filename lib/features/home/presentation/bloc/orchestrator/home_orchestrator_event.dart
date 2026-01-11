part of 'home_orchestrator_bloc.dart';

abstract class HomeOrchestratorEvent extends Equatable {
  const HomeOrchestratorEvent();

  @override
  List<Object> get props => [];
}

class LoadAllHomeDataEvent extends HomeOrchestratorEvent {
  const LoadAllHomeDataEvent();
}
