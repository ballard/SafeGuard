//
//  ContentView.swift
//  SafeGuard
//
//  Created by ISLAZAREV on 22.06.2022.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @EnvironmentObject var camera: CameraManager
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            FrameView()
                .environmentObject(camera)
                .edgesIgnoringSafeArea(.all)
            //Controls
            ZStack {
                Button {
                    if camera.isRecording {
                        camera.stopRecording()
                    } else {
                        camera.startRecording()
                    }
                    
                } label: {
                    Image(systemName: "video.circle")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .opacity(camera.isRecording ? 0 : 1)
                        .padding(12)
                        .frame(width: 60, height: 60)
                        .background {
                            Circle().stroke(camera.isRecording ? .clear : .black)
                        }.padding(6)
                        .background {
                            Circle().fill(camera.isRecording ? .red : .white)
                        }
                }
                
                // Preview Button
                
                Button {
                    camera.showPreview.toggle()
                } label: {
                    Label {
                        Image(systemName: "chevron.right")
                            .font(.callout)
                    } icon: {
                        Text("Preview")
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background {
                        Capsule()
                            .fill(.white)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                
            }
            .frame(maxHeight:.infinity ,alignment: .bottom)
            .padding(.top, 10)
            .padding(.bottom, 30)
            
        }
        .onAppear {
            camera.configure()
        }
        .overlay {
            if let url = camera.recordedUrl, camera.showPreview {
                Preview(url: url, showPreview: $camera.showPreview)
                    .transition(.move(edge: .trailing))
                
            }
        }.animation(.easeInOut, value: camera.showPreview)
        .preferredColorScheme(.dark)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Preview: View {
    var url: URL
    
    @Binding var showPreview: Bool
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            VideoPlayer(player: AVPlayer(url: url))
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .overlay(alignment: .topLeading) {
                    Button {
                        showPreview.toggle()
                    } label: {
                        Label {
                            Text("Back")
                        } icon: {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundColor(.white )
                    }
                    .padding(.leading)
                    .padding(.top, 22)
                }
            
            
        }
    }
    
}
