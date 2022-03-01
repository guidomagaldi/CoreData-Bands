import Foundation

protocol ArtistRepositoryProtocol{
    func getAllBands(completionHandler: @escaping ([Band]) -> Void)
    func saveBand(band:Band, completionHandler:@escaping (Band) -> ())
    func deleteBands(completionHandler: @escaping () -> ())
    func deleteSpecificBand(bandId: [UUID], completionHandler: @escaping ([UUID]) -> ())
    func associateAlbum(bandId: UUID, album: Album, completionHandler: @escaping ([Band]) -> ())
    func deleteSpecificAlbum(bandId: UUID, album: Album, completionHandler: @escaping ([Band]) -> ()) 

    
}

struct ArtistRepository: ArtistRepositoryProtocol{
    
    private var localDataSource: LocalDataSourceProtocol = LocalDataSource()
    
    func getAllBands(completionHandler: @escaping ([Band]) -> ()) {
        localDataSource.getAllBands(completionHandler: { bandsDtos in
            let domainBands = bandsDtos.map { currentBandDto in
                Band(dto: currentBandDto)
            }
            completionHandler(domainBands)
        }
        )
    }
    
    
    func saveBand(band: Band, completionHandler: @escaping (Band) -> ()) {
        localDataSource.saveBand(band: BandDTO(domain: band), completionHandler: { bandDto in
            completionHandler( Band(dto: bandDto))
        })
    }
    func deleteBands(completionHandler: @escaping () -> ()) {
        localDataSource.deleteBands(completionHandler: completionHandler)
    }
    
    func deleteSpecificBand(bandId: [UUID], completionHandler: @escaping ([UUID]) -> ()) {
        localDataSource.deleteSpecificBand(bandId: bandId, completionHandler: completionHandler)    }
    
    func associateAlbum(bandId: UUID, album: Album, completionHandler: @escaping ([Band]) -> ()){
        localDataSource.associateAlbum(bandId: bandId, album: AlbumDTO(domain: album),  completionHandler: { bandsDtos in
            let domainBands = bandsDtos.map { currentBandDto in
                Band(dto: currentBandDto)
            }
            completionHandler(domainBands)
        }

        )
}
    
    func deleteSpecificAlbum(bandId: UUID, album: Album, completionHandler: @escaping ([Band]) -> ()) {
        localDataSource.deleteSpecificAlbum(bandId: bandId, album: AlbumDTO(domain: album),  completionHandler: { bandsDtos in
            let domainBands = bandsDtos.map { currentBandDto in
                Band(dto: currentBandDto)
            }
            completionHandler(domainBands)
        }
                                            
                                            )}
    }

