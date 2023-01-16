part of 'nlp_bloc.dart';

abstract class NlpState extends Equatable {
  const NlpState();

  @override
  List<Object> get props => [];
}

class NlpInitial extends NlpState {}

class NlpLoading extends NlpState {}

class NlpLoaded extends NlpState {
  final TreeNode treeNode;

  const NlpLoaded(this.treeNode);

  @override
  List<Object> get props => [treeNode];
}

class NlpError extends NlpState {
  final String message;

  const NlpError({required this.message});

  @override
  List<Object> get props => [message];
}
