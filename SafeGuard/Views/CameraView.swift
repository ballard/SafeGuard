////
////  CameraView.swift
////  SafeGuard
////
////  Created by ISLAZAREV on 24.06.2022.
////
//
//import SwiftUI
//import AVFoundation
//
//struct CameraView: View {
//    
//    @StateObject var camera = CameraModel()
//    
//    var body: some View {
//        ZStack {
//            Color.black
//                .ignoresSafeArea(.all, edges: .all)
//            
//            VStack {
//                
//                if camera.isTaken {
//                    HStack {
//                        
//                        Spacer()
//                        Button {
//                            
//                        } label: {
//                            Image(systemName: "arrow.triangle.2.circlepath.camera")
//                                .foregroundColor(.black)
//                                .padding()
//                                .background(Color.white)
//                                .clipShape(Circle())
//                        }
//                        .padding(.trailing, 10)
//                    }
//                }
//                
//                Spacer()
//                
//                HStack {
//                    
//                    if camera.isTaken {
//                        
//                        Button {
//                            
//                        } label: {
//                            Text("Save")
//                                .foregroundColor(.black)
//                                .fontWeight(.semibold)
//                                .padding(.vertical, 10)
//                                .padding(.horizontal, 20)
//                                .background(Color.white)
//                                .clipShape(Capsule())
//                        }
//                        .padding(.leading)
//                        Spacer()
//                    } else {
//                        Button {
//                            camera.isTaken.toggle()
//                        } label: {
//                            ZStack {
//                                Circle()
//                                    .fill(Color.white)
//                                    .frame(width: 65, height: 65)
//                                Circle()
//                                    .stroke(Color.white, lineWidth: 2)
//                                    .frame(width: 75, height: 75)
//                            }
//                        }
//                    }
//                }.frame(height: 75)
//            }
//        }
//        .onAppear {
//            camera.configure()
//        }
//    }
//}
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
