import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';
import 'package:imdumb/core/widgets/molecules/empty_state.dart';
import 'package:imdumb/core/widgets/molecules/error_state.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_credits_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_detail_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_images_usecase.dart';
import 'package:imdumb/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:imdumb/features/movie_detail/presentation/widgets/cast_section.dart';
import 'package:imdumb/features/movie_detail/presentation/widgets/images_carousel_app_bar.dart';
import 'package:imdumb/features/movie_detail/presentation/widgets/empty_images_app_bar.dart';
import 'package:imdumb/features/movie_detail/presentation/widgets/movie_detail_background_image.dart';
import 'package:imdumb/features/movie_detail/presentation/widgets/movie_info_section.dart';
import 'package:imdumb/features/movie_detail/presentation/widgets/recommendation_modal.dart';
import 'package:imdumb/main.dart';

@RoutePage()
class MovieDetailScreen extends StatefulWidget implements AutoRouteWrapper {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc(
        fetchMovieDetailUsecase: getIt<FetchMovieDetailUsecase>(),
        fetchMovieImagesUsecase: getIt<FetchMovieImagesUsecase>(),
        fetchMovieCreditsUsecase: getIt<FetchMovieCreditsUsecase>(),
        movieId: movieId,
      )..add(const FetchMovieDetailEvent()),
      child: this,
    );
  }
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showRecommendationModal() {
    final state = context.read<MovieDetailBloc>().state;
    final movieDetail = state.movieDetail;

    if (movieDetail == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RecommendationModal(
        movieDetail: movieDetail,
        commentController: _commentController,
        onConfirm: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('¡Recomendación enviada con éxito!'),
              backgroundColor: context.appColor.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          _commentController.clear();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state.status == MovieDetailStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MovieDetailStatus.failure) {
            return ErrorState(
              errorMessage: state.errorMessage ?? 'Error al cargar el detalle',
              onRetry: () {
                context.read<MovieDetailBloc>().add(
                  const FetchMovieDetailEvent(),
                );
              },
            );
          }

          final movieDetail = state.movieDetail;
          if (movieDetail == null) {
            return const EmptyState(message: 'No hay información disponible');
          }

          return Stack(
            children: [
              MovieDetailBackgroundImage(movieDetail: movieDetail),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      movieDetail.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.router.pop();
                      },
                    ),
                    floating: true,
                    pinned: true,
                    expandedHeight: context.screenHeight * 0.4,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: state.images.isNotEmpty
                        ? FlexibleSpaceBar(
                            background: ImagesCarouselAppBar(
                              images: state.images,
                            ),
                          )
                        : FlexibleSpaceBar(
                            background: EmptyImagesAppBar(
                              movieDetail: movieDetail,
                            ),
                          ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MovieInfoSection(movieDetail: movieDetail),
                          CastSection(casts: state.casts),
                          80.spaceh,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showRecommendationModal,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Recomendar'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
