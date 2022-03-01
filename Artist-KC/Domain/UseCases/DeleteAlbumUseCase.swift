import Foundation

protocol DeleteAlbumUseCaseProtocol{
    func deleteSpecificAlbum(bandId: UUID, album: Album, completionHandler: @escaping ([Band]) -> ())
}

struct DeleteAlbumUseCase:DeleteAlbumUseCaseProtocol{
    let repository: ArtistRepositoryProtocol = ArtistRepository()
    
    func deleteSpecificAlbum(bandId: UUID, album: Album, completionHandler: @escaping ([Band]) -> ()) {
        repository.deleteSpecificAlbum(bandId: bandId, album: album, completionHandler: completionHandler)
        
    }
    
    
    
        //
    }
    
    

