//
//  ContentView.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import SwiftUI
import CoreData
import Combine

struct PreviewScreenView: View
{
    @ObservedObject private var viewModel = PreviewViewModel()
    
    let fileManager = FileManager()
    
    var body: some View
    {
        NavigationView
        {
            GeometryReader
            { geometry in
                ScrollView(.horizontal, showsIndicators: false, content:
                {
                    HStack
                    {
                        ForEach(viewModel.imgArray)
                        { pimg in
                            if let link = pimg.link
                            {
                                AsyncImage(url: URL(string: link))
                                { img in
                                    img.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width-50, height: geometry.size.height-100, alignment: .center)
                                        .cornerRadius(20.0)
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(.gray, lineWidth: 1))
                                        .padding(.all, 8)
                                } placeholder: {
                                    Text("Loading...")
                                        .frame(width: geometry.size.width, height: geometry.size.height-100, alignment: .center)
                                }
                            }
                        }
                    }
                })
                .padding(20)
                .toolbar
                {
                    ToolbarItem(placement: .navigationBarLeading)
                    {
                        Button("미리보기", action:
                        {
                            self.viewModel.addImage(url: (self.viewModel.imgArray.count) >= K.images.count ? "https://source.unsplash.com/random" : K.images[self.viewModel.imgArray.count])
                            print("Count: \(self.viewModel.imgArray.count)")
                            self.viewModel.save()
                            self.viewModel.getAllImages()
                        })
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 50.0)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing)
                    {
                        Button("삭제", action:
                        {
                            self.deleteAll()
                        })
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 50.0)
                    }
                }
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .onAppear
        {
            viewModel.getAllImages()
        }
    }
    
    func deleteAll()
    {
        for img in viewModel.imgArray
        {
            print(img.link)
            PreviewImageContainer.shared.viewContext.delete(img)
        }
        viewModel.save()
        self.viewModel.getAllImages()
    }
    
    /// 한 번에 탭을 연타 했을 때 너무 빨리 추가되지 않도록 debounce 0.2초 추가
    func setBindings()
    {
        self.viewModel.$imgArray
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .sink
            { (updatedArray:[PreviewImage]) in
                self.viewModel.imgArray = updatedArray
                print("Count: \(self.viewModel.imgArray.count)")
                self.viewModel.save()
                self.viewModel.getAllImages()
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack
        {
            PreviewScreenView()
                .environment(\.managedObjectContext, PreviewImageContainer.shared.viewContext)
        }
    }
}
