import Foundation

protocol LocalDataSourceProtocol{
    func getAllBands(completionHandler: @escaping ([BandDTO]) -> Void)
    func saveBand(band:BandDTO, completionHandler: @escaping (BandDTO) -> ())
    func deleteBands(completionHandler: @escaping () -> ())
    func deleteSpecificBand(bandId: [UUID], completionHandler: @escaping ([UUID]) -> ())
    func associateAlbum(bandId: UUID, album: AlbumDTO, completionHandler: @escaping ([BandDTO]) -> ())
    func deleteSpecificAlbum(bandId: UUID, album: AlbumDTO, completionHandler: @escaping ([BandDTO]) -> ())

}

struct LocalDataSource: LocalDataSourceProtocol{
   
    private let pController: PersistenceControllerProtocol = PersistenceController.shared
    
    func getAllBands(completionHandler: @escaping ([BandDTO]) -> Void) {
        pController.getAllBands(completionHandler: completionHandler)
    }
    
    func saveBand(band: BandDTO, completionHandler: @escaping (BandDTO) -> ()) {
        pController.saveBand(band: band, completionHandler: completionHandler)
    }
    
    func deleteBands(completionHandler: @escaping () -> ()) {
        pController.deleteBands(completionHandler: completionHandler)
    }
    
    func deleteSpecificBand(bandId: [UUID], completionHandler: @escaping ([UUID]) -> ()) {
        pController.deleteSpecificBand(bandId: bandId, completionHandler: completionHandler)
    }
    
    func associateAlbum(bandId: UUID, album: AlbumDTO, completionHandler: @escaping ([BandDTO]) -> ()){
        pController.associateAlbum(bandId: bandId, album: album, completionHandler: completionHandler)
    }
    
    func deleteSpecificAlbum(bandId: UUID, album: AlbumDTO, completionHandler: @escaping ([BandDTO]) -> ()) {
        pController.deleteSpecificAlbum(bandId: bandId, album: album, completionHandler: completionHandler)
        
    }
    
    
    
}
