import Foundation

protocol AssociateAlbumUseCaseProtocol{
    func associateAlbum(bandId: UUID, album: Album, completionHandler: @escaping ([Band]) -> ())
}

struct AssociateAlbumUseCase: AssociateAlbumUseCaseProtocol{
    let repository: ArtistRepositoryProtocol = ArtistRepository()
    
    func associateAlbum(bandId: UUID, album: Album, completionHandler: @escaping ([Band]) -> ()) {
        repository.associateAlbum(bandId: bandId, album: album, completionHandler: completionHandler)
        
    }

}


