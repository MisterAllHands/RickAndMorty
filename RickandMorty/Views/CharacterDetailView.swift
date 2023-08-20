//
//  CharacterDetailView.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 18/08/2023.
//

import SwiftUI



struct CharacterDetailView: View {
    
    let character: Character
        
    @State private var characterImage: UIImage? = nil

    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor_app")
                    .ignoresSafeArea()
                ScrollView {
                    //The Image section
                    VStack {
                        if let image = characterImage{
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 148, height: 148)
                                .cornerRadius(16)
                        }
                        characterName
                        characterStatus
                    }
                    //Character Info
                    characterInfo
                    
                    //Character Origin
                    characterOrigin
                    
                    //Episodes
                    characterEpisodes
                    
                    Spacer()
                }
                .onAppear{
                    loadImage()
                }

            }
        }.toolbarRole(.editor)
            .navigationBarTitleDisplayMode(.inline)
    }
}



struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let character = Character(id: 1, name: "", status: .alive, species: "", type: "", gender: .male, origin: Origin(name: "", url: ""), location: SinleLocation(name: "", url: ""), image: "", episode: [], url: "", created: "")
        CharacterDetailView(character: character)
    }
}



//MARK: - Extensions

extension CharacterDetailView {
    
    
    private var characterName: some View {
        
        Text(character.name)
        .font(
        Font.custom("Kanit-SemiBold", size: 22)
        .weight(.bold)
        )
        .foregroundColor(.white)
        .padding(.top, 24)  //Manage the space here from the top
    }
    
    private var characterStatus: some View {
        
        Text("\(character.status.rawValue)")
          .font(
            Font.custom("Kanit-ExtraLight", size: 16)
              .weight(.medium)
          )
          .multilineTextAlignment(.trailing)
          .foregroundColor(Color(red: 0.28, green: 0.77, blue: 0.04))
          .padding(.top, 1)
    }
    
    private var characterInfo: some View {
        
        //Info Section
        VStack(alignment: .leading) {
            HStack {
                Text("Info")
                .font(
                Font.custom("Kanit-ExtraLight", size: 17)
                .weight(.semibold)
                )
                .foregroundColor(.white)
                .padding(.top, 24)
                .padding(.horizontal, 24)
                Spacer()
            }
            
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Text("Species:")
                      .font(
                        Font.custom("Kanit-ExtraLight", size: 16)
                          .weight(.medium)
                      )
                      .foregroundColor(Color(red: 0.77, green: 0.79, blue: 0.81))
                      .frame(width: 64.9201, alignment: .topLeading)
                      .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Text(character.species)
                      .font(
                        Font.custom("Kanit-ExtraLight", size: 16)
                          .weight(.medium)
                      )
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(.white)
                      .padding(.horizontal, 16)
                                        
                }
                
                HStack(spacing: 16) {
                    Text("Type:")
                      .font(
                        Font.custom("Kanit-ExtraLight", size: 16)
                          .weight(.medium)
                      )
                      .foregroundColor(Color(red: 0.77, green: 0.79, blue: 0.81))
                      .frame(width: 64.9201, alignment: .topLeading)
                      .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    
                    Text(character.displayType)
                      .font(
                        Font.custom("Kanit-ExtraLight", size: 16)
                          .weight(.medium)
                      )
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(.white)
                      .padding(.horizontal, 16)
                    
                    
                }
                
                HStack(spacing: 16) {
                    Text("Gender:")
                      .font(
                        Font.custom("Kanit-ExtraLight", size: 16)
                          .weight(.medium)
                      )
                      .foregroundColor(Color(red: 0.77, green: 0.79, blue: 0.81))
                      .frame(width: 64.9201, alignment: .topLeading)
                      .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Text("\(character.gender.rawValue)")
                      .font(
                        Font.custom("Kanit-ExtraLight", size: 16)
                          .weight(.medium)
                      )
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(.white)
                      .padding(.horizontal, 16)
                    
                    
                }
            }
            .foregroundColor(.clear)
            .frame(height: 124)
            .background(.white.opacity(0.2))// Upadate your colour accordingly
            .cornerRadius(16)
            .padding(.horizontal, 24)
            
            
        }
    }
    
    private var characterOrigin: some View {
        
        
        //Origin Section
        VStack(alignment: .leading) {
            HStack {
                Text("Origin")
                .font(
                Font.custom("Kanit-ExtraLight", size: 17)
                .weight(.semibold)
                )
                .foregroundColor(.white)
                .padding(.top, 24)
                .padding(.horizontal, 24)
                Spacer()
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Rectangle()
                        .frame(width: 64, height: 64)
                        .background(Color(red: 0.1, green: 0.11, blue: 0.16))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .overlay {
                            Image("earth")
                            
                        }
                    
                    VStack(spacing: 8) {
                        Text(character.origin.name)
                        .font(
                        Font.custom("Kanit-SemiBold", size: 17)
                        .weight(.semibold)
                        )
                        .foregroundColor(.white)
                        
                        // Body Small
                        Text("Planet")
                          .font(
                            Font.custom("Kanit-SemiBold", size: 15)
                          )
                          .foregroundColor(Color(red: 0.28, green: 0.77, blue: 0.04))
                    }
                    Spacer()
                }
            }
            .foregroundColor(.clear)
            .frame(height: 80)
            .background(.white.opacity(0.2))// Upadate your colour accordingly
            //.background(Color(red: 0.15, green: 0.16, blue: 0.22))
            .cornerRadius(16)
            .padding(.horizontal, 24)
        }
    }
    var characterEpisodes: some View {
        VStack {
            HStack {
                Text("Episodes")
                    .font(
                        Font.custom("Kanit-ExtraLight", size: 17)
                            .weight(.semibold)
                    )
                    .foregroundColor(.white)
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                Spacer()
            }
            
        //Episode
            VStack {
                ForEach(character.episode, id: \.id) { episode in
                    VStack(alignment: .leading, spacing: 16) {
                        Text(episode.name)
                            .font(
                                Font.custom("Kanit-ExtraLight", size: 17)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)

                        HStack {
                            if let season = extractSeasonNumber(from: episode.episode) {
                                Text("Season \(season), Episode \(episode.episode)")
                            } else {
                                Text("Episode \(episode.episode)")
                            }
                        }.font(Font.custom("Kanit-ExtraLight", size: 13)
                            .weight(.medium))
                         .foregroundColor(Color(red: 0.28, green: 0.77, blue: 0.04))

                        Spacer()

                        Text(episode.air_date)
                                .font(
                                    Font.custom("Kanit-ExtraLight", size: 12)
                                        .weight(.medium)
                                )
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.58, green: 0.6, blue: 0.61))
                                .padding(.horizontal, 16)
                    }
                    .padding(.leading)
                    .foregroundColor(.clear)
                    .frame(width: 360, height: 86)
                    .background(.white.opacity(0.2))
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 4)
                }
            }
        }
    }

    
    //Extract season number: S1E1 to Season: 1, Episode: 1
    func extractSeasonNumber(from episodeString: String) -> Int? {
        
        let seasonPattern = #"S(\d{2})E\d{2}"#
        let regex = try? NSRegularExpression(pattern: seasonPattern, options: [])
        if let match = regex?.firstMatch(in: episodeString, options: [], range: NSRange(location: 0, length: episodeString.utf16.count)) {
            if let seasonRange = Range(match.range(at: 1), in: episodeString), let seasonNumber = Int(episodeString[seasonRange]) {
                return seasonNumber
            }
        }
        return nil
    }
    
    func loadImage() {
        // Assuming character.image is a URL or filename as a String
        if let imageURL = URL(string: character.image) {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        characterImage = image
                    }
                }
            }.resume()
        }
    }
}
