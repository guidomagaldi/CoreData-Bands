import Foundation

struct AlbumDTO{
let name: String
}


extension AlbumDTO{
    init(domain: Album){
        self.name = domain.name
       
}
}

extension AlbumDTO{
    init(cd: CDAlbum) {
        self.name = cd.name!
        
    }
}
