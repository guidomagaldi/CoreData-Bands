import Foundation

struct BandDTO{
    let id:  UUID
    let name: String
    let members: [ArtistDTO]
    let albums: [AlbumDTO]
}

extension BandDTO{
    init(domain: Band){
        self.id = domain.id
    self.name = domain.name
        self.members = domain.members.map{ ArtistDTO(domain: $0) }
        self.albums = domain.albums.map{AlbumDTO(domain: $0)}
    }
}

extension BandDTO {
    init(cd: CDBand) {
        self.id = cd.id ?? UUID()
        self.name = cd.name!
        let retrievedArray = cd.members?.allObjects ?? []
        let retrievedAlbumsArray = cd.albums?.allObjects ?? []
        
        //pasamos de NSSet a array
        let cdArtistsArray = retrievedArray.compactMap{ currentAny in
            currentAny as? CDArtist
        }
        
        let cdAlbumArray = retrievedAlbumsArray.compactMap{ currentAny in
            currentAny as? CDAlbum
        }
        //Nuevo Array con map y le asignamos a ArtistsDTO inicializado con cd
        //Es decir lo transformamos de CDArtist a ArtistDto
        self.members = cdArtistsArray.map {  ArtistDTO(cd: $0) }
        self.albums = cdAlbumArray.map {AlbumDTO(cd: $0)}
        
    }
}
