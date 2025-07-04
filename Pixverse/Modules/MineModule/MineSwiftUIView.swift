//
//  MineSwiftUIView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 04.07.2025.
//

import SwiftUI



struct MineSwiftUIView: View {
    
    @ObservedObject var viewModel: MineViewModel
    
    @State private var selectedTab: VideoTab = .allVideos
    
    private var favoriteVideos: [VideoModel] {
        viewModel.allVideos.filter { $0.favorite }
    }

    var body: some View {
        if viewModel.allVideos.isEmpty {
            VStack {
                Image(systemName: "folder.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .foregroundStyle(Color.labelQuaternary)
                    .frame(width: 80, height: 80)
                    .background(
                        Circle()
                            .foregroundStyle(Color.backgroundTertiary)
                    )
                Text("It's empty here")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.labelPrimary)
                Text("Create your first generation")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.labelSecondary)
                Button {
                    TabBarManager.shared.selectTab(at: 0)
                } label: {
                    Text("Create")
                        .foregroundStyle(Color.accentSecondaryDark)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(LinearGradient(colors: [Color.accentPrimary, Color.accentSecondary], startPoint: .leading, endPoint: .trailing))
                        )
                    
                }
                .padding(.horizontal, 16)

            }
            .frame(maxWidth: .infinity)
            .background(Color.background)
        } else {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    tabButton(title: "All videos (\(viewModel.allVideos.count))", isSelected: selectedTab == .allVideos) {
                        selectedTab = .allVideos
                    }
                    tabButton(title: "My favorites (\(favoriteVideos.count))", isSelected: selectedTab == .favorites) {
                        selectedTab = .favorites
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(groupedVideos(), id: \.key) { date, videos in
                            Text(date)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.horizontal)

                            ForEach(videos, id: \.pathToFiles) { video in
                                VideoCard(video: video)
                                    .environmentObject(viewModel)
                            }
                        }
                        VStack{}
                            .frame(height: 116)
                            .background(Color.background)
                    }
                    .padding(.bottom, 16)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.background)
        }
        
    }

    private func tabButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.footnote)
                .foregroundColor(isSelected ? .white : .gray)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(isSelected ? Color.white.opacity(0.1) : Color.clear)
                .cornerRadius(8)
        }
    }

    private func groupedVideos() -> [(key: String, value: [VideoModel])] {
        let selected = selectedTab == .allVideos ? viewModel.allVideos : favoriteVideos
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        let grouped = Dictionary(grouping: selected) { video in
            formatter.string(from: video.date ?? Date.distantPast)
        }
        
        let sortedGroups = grouped.sorted { $0.key > $1.key }
        
        let finalGroups = sortedGroups.map { (key, videos) in
            let sortedVideos = videos.sorted { $0.id?.uuidString ?? "" < $1.id?.uuidString ?? "" }
            return (key: key, value: sortedVideos)
        }
        return finalGroups
    }
}

enum VideoTab {
    case allVideos
    case favorites
}


struct VideoCard: View {
    @EnvironmentObject var viewModel: MineViewModel
    let video: VideoModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .frame(height: 180)
                .overlay(
                    Group {
                        if let image = VideoLoader.generateThumbnailSUI(from: video.pathToFiles ?? "") {
                                 Image(uiImage: image)
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                             } else {
                                 ZStack {
                                     Color.gray
                                     Text("No preview")
                                         .foregroundColor(.white)
                                 }
                             }
                    }
                )
                .cornerRadius(12)

            Image(systemName: video.favorite ? "bookmark.fill" : "bookmark")
                .padding(10)
                .background(Color.black.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white)
                .padding(10)
                .onTapGesture {
                    video.favorite.toggle()
                    if let index = CoreManager.shared.posts.firstIndex(where: { $0.id == video.id }) {
                        CoreManager.shared.posts[index].updateData(pathToVideo: nil, status: nil, favorite: video.favorite)
                    }
                }
        }
        .onTapGesture {
            viewModel.presenter?.itemIsSelect(model: video)
        }
        .padding(.horizontal)
    }
}
