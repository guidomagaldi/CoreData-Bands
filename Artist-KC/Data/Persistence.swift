//
//  Persistence.swift
//  Artist-KC
//
//  Created by Guido Mola on 22/02/2022.
//

import CoreData

protocol PersistenceControllerProtocol{
    func getAllBands(completionHandler: @escaping([BandDTO]) -> Void)
    func saveBand(band:BandDTO, completionHandler: @escaping(BandDTO) -> ())
    func deleteBands(completionHandler: @escaping () -> ())
    func deleteSpecificBand(bandId: [UUID], completionHandler: @escaping ([UUID]) -> ())
    func associateAlbum(bandId: UUID, album: AlbumDTO, completionHandler: @escaping ([BandDTO]) -> ())
    func deleteSpecificAlbum(bandId: UUID, album: AlbumDTO, completionHandler: @escaping ([BandDTO]) -> ())
    
    
    
}

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Artist_KC")
        if inMemory {
            //dev null apunta a la nada
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        //Esto va despues de load persistent Controller
        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }
}

extension PersistenceController:PersistenceControllerProtocol{
    
    
    
    func getAllBands(completionHandler: @escaping ([BandDTO]) -> Void) {
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = nil
            
            var retrievedBands : [CDBand] = []
            
            do {
                retrievedBands = try privateMOC.fetch(request)
            } catch  {
                print("F:\(error)")
                completionHandler([])
            }
            
            let transformedDtosB = retrievedBands.map { BandDTO(cd: $0) }
            completionHandler(transformedDtosB)
            
        }
        //nothing yet
    }
    
    func saveBand(band:BandDTO, completionHandler:@escaping (BandDTO) -> ()){
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = nil
            
            let newBand = CDBand(context: privateMOC)
            newBand.name = band.name
            newBand.id = band.id
            
            band.members.forEach{ currentArtistDto in
                let newArtist = CDArtist(context: privateMOC)
                
                newArtist.name = currentArtistDto.name
                newArtist.birthDate = currentArtistDto.birthDate
                
                newArtist.addToBelongs(newBand)
            }
            
            band.albums.forEach { currentAlbumDto in
                let newAlbum = CDAlbum(context: privateMOC)
                newAlbum.name = currentAlbumDto.name
                newAlbum.addToHasThis(newBand)
                
            }
            
            do {
                try privateMOC.save()
            } catch  {
                print("F: \(error)")
                
            }
            
            completionHandler(band)
        }
    }
    
    func deleteBands(completionHandler: @escaping () -> ()){
        container.performBackgroundTask { privateMOC in
            let request : NSFetchRequest<NSFetchRequestResult> = CDBand.fetchRequest()
            request.predicate = nil
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try privateMOC.execute(deleteRequest)
            } catch{
                print("F: \(error)")
            }
            
            completionHandler()
            
        }
    }
    
    func deleteSpecificBand(bandId: [UUID], completionHandler: @escaping ([UUID]) -> ()){
        container.performBackgroundTask { privateMOC in
            let request : NSFetchRequest<NSFetchRequestResult> = CDBand.fetchRequest()
            request.predicate = NSPredicate(format: "id IN %@", bandId)
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            deleteRequest.resultType = .resultTypeCount
            var count: NSBatchDeleteResult?
            
            do {
                try privateMOC.execute(deleteRequest)
            } catch{
                print("F: \(error)")
            }
            
            let result = count?.result as? Int ?? 1
            print("Band Deleted with ID: \(bandId)")
            completionHandler(bandId)
            
        }
    }
    
    
    
    func associateAlbum(bandId: UUID, album: AlbumDTO, completionHandler: @escaping ([BandDTO]) -> ()) {
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = NSPredicate(format: "id IN %@", [bandId] )

            do {
                
                let cdBand = try privateMOC.fetch(request).first!
                
                let newAlbum = CDAlbum(context: privateMOC)
                newAlbum.name = album.name
                cdBand.addToAlbums(newAlbum)
                try privateMOC.save()
                
                
            } catch  {
                print("F: \(error)")
                
            }
            
            let bandRequest = CDBand.fetchRequest()
            bandRequest.predicate = nil
            
            var retrievedBands : [CDBand] = []
            
            do {
                retrievedBands = try privateMOC.fetch(bandRequest)
            } catch  {
                print("F:\(error)")
                completionHandler([])
            }
            
            let transformedDtosB = retrievedBands.map { BandDTO(cd: $0) }
            completionHandler(transformedDtosB)
     
            
            
        }
    }
    
    func deleteSpecificAlbum(bandId: UUID, album: AlbumDTO, completionHandler: @escaping ([BandDTO]) -> ()) {
        container.performBackgroundTask { privateMOC in
            let request : NSFetchRequest<NSFetchRequestResult> = CDAlbum.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", "\(album)")
            print(request)
            do {
                
                
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
                deleteRequest.resultType = .resultTypeCount
                var count: NSBatchDeleteResult?
                
                do {
                    try privateMOC.execute(deleteRequest)
                } catch{
                    print("F: \(error)")
                }
                
                let result = count?.result as? Int ?? 1
                print("Album deleted with name: \(album)")
                
                let bandRequest = CDBand.fetchRequest()
                bandRequest.predicate = nil
                
                var retrievedBands : [CDBand] = []
                
                do {
                    retrievedBands = try privateMOC.fetch(bandRequest)
                } catch  {
                    print("F:\(error)")
                    completionHandler([])
                }
                
                let transformedDtosB = retrievedBands.map { BandDTO(cd: $0) }
                completionHandler(transformedDtosB)
         
            }
    }
    
    
    
}
}
