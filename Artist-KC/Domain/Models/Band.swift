import Foundation

struct Band{
    let name: String
    let members: [Artist]
    var id: UUID
    var albums: [Album]
}

extension Band: Identifiable{
    
}

extension Band{
    init(dto: BandDTO){
        self.id = dto.id
        self.name = dto.name
        self.members = dto.members.map{
            Artist(dto: $0)}
        self.albums = dto.albums.map{ Album(dto: $0)
            //
        }
    }
}


extension Band{
    func bandName() -> String {
        return name
    }
    
    func bandId() -> UUID {
        return id
    }
    
    
    func bandMembers() -> String{
        let memberNames = members.map { currentMember in
            currentMember.name
        }
        let formattedMemberNames = memberNames.joined(separator: ", ")
        return formattedMemberNames
    }
    
    func bandAlbums() -> String{
        let albumNames = albums.map { currentAlbum in
            currentAlbum.name
        }
        let formattedAlbums = albumNames.joined(separator: ", ")
        return formattedAlbums
    }
}


