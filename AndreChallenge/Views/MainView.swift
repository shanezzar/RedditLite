//
//  MainView.swift
//  AndreChallenge
//
//  Created by Shanezzar Sharon on 24/11/2021.
//

import SwiftUI

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct MainView: View {
    
    // MARK:- variables
    @ObservedObject var networkModel = NetworkModel.shared
    
    @State var search: String = ""
    
    @State var showError: Bool = false
    
    // MARK:- views
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 42, alignment: .center)
                    
                    Spacer()
                    
                    Text("Welcome")
                        .foregroundColor(.titleColor)
                        .font(Font.custom(CustomFont.sofiaProSemiBold, size: 23))
                }
                .padding(.horizontal, 32)
                .padding(.top, 8)
                
                HStack {
                    Spacer()
                    
                    TextField("Search topic here...", text: $search)
                        .foregroundColor(.titleColor)
                        .font(Font.custom(CustomFont.sofiaProMedium, size: 16))
                        .keyboardType(.webSearch)
                        .frame(height: 50, alignment: .center)
                    
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                HStack {
                                    Spacer()
                                    
                                    Button("Done") {
                                        haptic()
                                        hideKeyboard()
                                    }
                                }
                            }
                        }
                        .onChange(of: search) { newValue in
                            networkModel.fetchData(topic: search)
                        }
                    
                    Button(action: {
                        haptic()
                        search = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(search == "" ? 0 : 1)
                            .frame(width: 12, height: 12)
                            .foregroundColor(.bodyColor)
                            .padding()
                    }
                    
                    Button {
                        haptic()
                        hideKeyboard()
                        networkModel.fetchData(topic: search)
                    } label: {
                        Image("search-icon")
                            .padding()
                    }
                }
                .padding(.horizontal, 24)
                
                if networkModel.isLoading {
                    PlaceholderView(type: .loading)
                }
                else if showError {
                    PlaceholderView(type: .error(message: networkModel.error))
                }
                else {
                    if networkModel.reddits.count > 0 {
                        List {
                            ForEach(networkModel.reddits, id: \.self) { reddit in
                                RedditView(reddit: reddit)
                            }
                            .listRowSeparatorTint(.clear)
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(PlainListStyle())
                        .listRowSeparator(.hidden)
                        .refreshable {
                            haptic()
                            SoundModel.shared.playRefresh()
                            networkModel.fetchData(topic: search)
                        }
                    }
                    else {
                        PlaceholderView(type: .noData)
                    }
                }
                
                Spacer()
                
                    .navigationBarTitle("")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
            .task {
                if networkModel.reddits.count == 0 {
                    networkModel.fetchData(topic: search)
                }
            }
            .onChange(of: networkModel.error) { newValue in
                showError = !newValue.isEmpty ? true : false
            }
            
        }
        
    }
    
}
