import Foundation

protocol DeleteBandUseCaseProtocol{
    func deleteSpecificBand(bandId: [UUID], completionHandler: @escaping ([UUID]) -> ())
    
}

struct DeleteBandUseCase: DeleteBandUseCaseProtocol{
    private let repository: ArtistRepositoryProtocol = ArtistRepository()
    func deleteSpecificBand(bandId: [UUID], completionHandler: @escaping ([UUID]) -> ()) {
        repository.deleteSpecificBand(bandId: bandId, completionHandler: completionHandler)
    }
    
  
    
    
}
