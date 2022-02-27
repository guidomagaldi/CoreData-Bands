import Foundation

protocol DeleteAllBandsUseCaseProtocol{
    func deleteBands(completionHandler: @escaping () -> ())
}

struct DeleteAllBandsUseCase: DeleteAllBandsUseCaseProtocol{
    
    private let repository: ArtistRepositoryProtocol = ArtistRepository()

    
    func deleteBands(completionHandler: @escaping () -> ()) {
        repository.deleteBands(completionHandler: completionHandler)
        
    }
    
    
}
