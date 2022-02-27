import Foundation

protocol SaveBandUseCaseProtocol {
    func execute(band:Band, completionHandler:@escaping (Band) -> ())
}

struct SaveBandUseCase: SaveBandUseCaseProtocol{
    
    private let repository: ArtistRepositoryProtocol = ArtistRepository()
    
    func execute(band: Band, completionHandler:@escaping (Band) -> ()) {
        repository.saveBand(band: band, completionHandler: completionHandler)
    }
    
    
}
