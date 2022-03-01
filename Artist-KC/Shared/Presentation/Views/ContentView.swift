//
//  ContentView.swift
//  Artist-KC
//
//  Created by Guido Mola on 22/02/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    
    let bandNames: [String] = [
        "Dire Straits",
        "Incubus",
        "Queen",
        "Rolling"
    ]
    
    let memberNames: [String] = [
        "Freddy Mercury",
        "Mick Jagger",
        "James Hetfield",
        "Mark Nofler"
    ]
    
    let albumNames: [String] = [
        "Album test 1",
        "Album test 2",
        "Album test 3"
    ]
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.bands) { band in
                    NavigationLink("\(band.bandName())") {
                        List{
                            NavigationLink("Ver Albums"){
                                List {
                                    ForEach(band.albums, id: \.self){  album in
                                        Text("\(album.name)")
                                        
                                    }.onDelete(perform:  { index in
                                        deleteAlbums(band: band , offsets: index, id: band.id)
                                    })
                                   
                    .toolbar {
                                                ToolbarItem {
                                                    Button {
                                                        addAlbum(bandId: band.bandId())
                                                        
                                                    } label: {
                                                        Image(systemName: "plus")
                                                    }
                                                }
                                            
                                            }
                                }.navigationBarTitle("Albumes de \(band.name)")
                            }
                            NavigationLink("Ver Integrantes", destination: Text("\(band.bandMembers())"))
                        }
                    }
                }
                .onDelete(perform: deleteItems)
              
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
        .onAppear{
            viewModel.getSavedArtists()
        }
    }
    
    private func addItem() {
        
//              viewModel.removeAllBands()
        withAnimation {
            let albums = [Album(name: "Album de prueba"),
                          Album(name: "Album dos"),
                          Album(name: "Album 3")]
            let artists = Artist(name: "Juan", birthDate: Date())
            let newBand = Band(name: "Banda X", members: [artists], id: UUID(), albums: albums)

            viewModel.saveBand(band: newBand)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            
            let bandsToRemove =
            offsets.map { viewModel.bands[$0].id}
            print(bandsToRemove)
           
     viewModel.deleteBand(bandId: bandsToRemove)
        }
    }
    
    private func deleteAlbums(band: Band, offsets: IndexSet, id: UUID) {
        withAnimation {
            
            let albumsToremove = offsets.map { retrievedAlbums in
                let albums = band.albums[retrievedAlbums]
            
                viewModel.deleteSpecificAlbum(bandId: band.id, album: albums)
              
//            viewModel.deleteBand(bandId: bandsToRemove)
        }
    }
    }
    
    private func addAlbum(bandId: UUID) {
        let album = "album al azar"
        viewModel.associateAlbum(bandId: bandId, album: Album(name: album))
        
        
    }
    

  
    
    
    
    
    
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    //struct ContentView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    //    }
    //}
}
