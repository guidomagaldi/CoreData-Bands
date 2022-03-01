import Foundation


class ContentViewModel: ObservableObject{
    @Published  var bands: [Band] = []
   
    
    private  let getAllBands: GetAllBandsUseCaseProtocol = GetAllBandsUseCase()
    private let saveBand: SaveBandUseCaseProtocol = SaveBandUseCase()
    private let deleteAllBands: DeleteAllBandsUseCaseProtocol = DeleteAllBandsUseCase()
    private let deleteBand: DeleteBandUseCaseProtocol = DeleteBandUseCase()
    private let associateAlbumWithBand: AssociateAlbumUseCaseProtocol = AssociateAlbumUseCase()
    private let deleteAlbum: DeleteAlbumUseCaseProtocol = DeleteAlbumUseCase()
    
    
    func getSavedArtists(){
        getAllBands.execute { [weak self] retrievedBands in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = retrievedBands
            }
            
        }
    }
    
    func saveBand(band: Band){
        saveBand.execute(band: band) { [weak self] newBandData in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands.append(newBandData)
            }
        }
    }
    
    func removeAllBands(){
        deleteAllBands.deleteBands {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = []
            }
        }
        
    }
    
    func deleteBand(bandId: [UUID]){
        deleteBand.deleteSpecificBand(bandId: bandId, completionHandler: {bandasRemovidas in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.bands = self.bands.filter{ !bandasRemovidas.contains($0.id) }
                
          print("Items deleted: \(bandasRemovidas)")
            }
        })
    }
    
    func associateAlbum(bandId: UUID, album: Album){
        associateAlbumWithBand.associateAlbum(bandId: bandId, album: album) { retrievedBands in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = retrievedBands
                
            }
    }
}
    
    func deleteSpecificAlbum(bandId: UUID, album: Album){
        deleteAlbum.deleteSpecificAlbum(bandId: bandId, album: album) { retrievedBands in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = retrievedBands
        }
        }
    }
}
