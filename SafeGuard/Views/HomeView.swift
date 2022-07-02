////
////  HomeView.swift
////  SafeGuard
////
////  Created by ISLAZAREV on 24.06.2022.
////
//
//import SwiftUI
//
//struct HomeView: View {
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            //Controls
//            ZStack {
//                Button {
//                    
//                } label: {
//                    Image(systemName: "video.circle")
//                        .resizable()
//                        .renderingMode(.template)
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(.black)
//                        .padding(12)
//                        .frame(width: 60, height: 60)
//                        .background {
//                            Circle().stroke(.black)
//                        }.padding(6)
//                        .background {
//                            Circle().fill(.white)
//                        }
//                }
//
//                // Preview Button
//
//                Button {
//
//                } label: {
//                    Label {
//                        Image(systemName: "chevron.right")
//                            .font(.callout)
//                    } icon: {
//                        Text("Preview")
//                    }
//                    .foregroundColor(.black)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 8)
//                    .background {
//                        Capsule()
//                            .fill(.white)
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .trailing)
//                .padding(.trailing)
//
//            }
//            .frame(maxHeight:.infinity ,alignment: .bottom)
//            .padding(.bottom, 10)
//            .padding(.bottom, 30)
//
//        }
//        .preferredColorScheme(.dark)
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
