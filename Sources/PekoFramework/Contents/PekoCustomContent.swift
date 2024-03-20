//
//  PekoCustomContent.swift
//
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
public struct PekoCustomContent<Content: View>: View {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    @EnvironmentObject private var pekoConfigurations: PekoConfigurations
    
    @State private var paddingTop: CGFloat = 0
    
    @State private var disableScroll: Bool = false
    @State private var disableGeometryReader: Bool = false
    @State private var disableBottomTabbarView = false
    
    private var refreshableAction: (() -> Void)? = nil
    
    private var content: () -> Content
    
    @State private var orientation = UIDevice.current.orientation
    
    // MARK: - Lifecycle
    
    public init(
        paddingTop: CGFloat = 0,
        disableScroll: Bool = false,
        disableGeometryReader: Bool = false,
        disableBottomTabbarView: Bool = false,
        content: @escaping () -> Content,
        refreshableAction: (() -> Void)? = nil
    ){
        self.paddingTop = paddingTop
        self.disableScroll = disableScroll
        self.disableGeometryReader = disableGeometryReader
        self.disableBottomTabbarView = disableBottomTabbarView
        self.refreshableAction = refreshableAction
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    if disableGeometryReader {
                        isLandscapeView()
                            .padding(.top, paddingTop)
                    } else {
                        if orientation.isLandscape {
                            isLandscapeView()
                                .padding(.top, paddingTop)
                        } else {
                            isPortraitView()
                                .padding(.top, paddingTop)
                        }
                    }
                }
            }
        }
        .detectOrientation($orientation)
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        .onAppear {
            if disableBottomTabbarView {
                pekoConfigurations.bottomTabbarViewVisible = false
            }
        }
        .onDisappear {
            if disableBottomTabbarView {
                pekoConfigurations.bottomTabbarViewVisible = true
            }
        }
        .ignoresSafeArea(edges: .all)
        .navigationBarHidden(true)
    }
    
    private func isPortraitView() -> some View {
        GeometryReader { geometry in
            if let refreshableAction {
                ScrollView(showsIndicators: false) {
                    content()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .refreshable {
                    refreshableAction()
                }
                .scrollDisabled(disableScroll)
            } else {
                ScrollView(showsIndicators: false) {
                    content()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .scrollDisabled(disableScroll)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private func isLandscapeView() -> some View {
        ZStack {
            if let refreshableAction {
                ScrollView(showsIndicators: false) {
                    content()
                }
                .refreshable {
                    refreshableAction()
                }
                .scrollDisabled(disableScroll)
            } else {
                ScrollView(showsIndicators: false) {
                    content()
                }
                .scrollDisabled(disableScroll)
            }
        }
    }
}
