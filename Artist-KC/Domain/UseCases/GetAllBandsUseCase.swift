import Foundation


protocol GetAllBandsUseCaseProtocol {
    func execute(completionHandler: @escaping ([Band]) -> Void)
}

//struct GetAllBandsUseCaseMock: GetAllBandsUseCaseProtocol{
//    func execute(completionHandler: ([Band]) -> Void) {
//        let artist = [Artist(name: "Juan", birthDate: Date()),
//                      Artist(name: "Guido", birthDate: Date())
//                      ]
//        let band = Band(name: "Rockeritos", members: artist, id: UUID())
//        completionHandler([band])
//    }
//}


struct GetAllBandsUseCase: GetAllBandsUseCaseProtocol{
    
    private let repository: ArtistRepositoryProtocol = ArtistRepository()
    
    func execute(completionHandler: @escaping ([Band]) -> Void) {
         repository.getAllBands(completionHandler: completionHandler)
    }
    
    
}
