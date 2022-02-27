import Foundation

struct Album: Hashable{
    let name: String
}


    
    


extension Album{
    init(dto: AlbumDTO){
        self.name = dto.name
    }
  
}
