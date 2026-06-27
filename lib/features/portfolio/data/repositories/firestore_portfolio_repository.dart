import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/portfolio_content.dart';
import '../../domain/repositories/portfolio_repository.dart';

/// Busca o conteúdo do portfólio em um único documento no Firestore.
///
/// Estrutura esperada no Firestore:
///   coleção: "portfolio"
///   documento: "content"
///   campos: name, role, location, summary, skills (array),
///            experiences (array de maps), projects (array de maps),
///            contacts (array de maps)
class FirestorePortfolioRepository implements PortfolioRepository {
  final FirebaseFirestore _firestore;

  FirestorePortfolioRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static const _collection = 'portfolio';
  static const _documentId = 'content';

  @override
  Future<PortfolioContent> getPortfolioContent() async {
    final snapshot =
        await _firestore.collection(_collection).doc(_documentId).get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception(
        'Documento "$_documentId" não encontrado na coleção "$_collection".',
      );
    }

    return PortfolioContent.fromJson(snapshot.data()!);
  }
}
