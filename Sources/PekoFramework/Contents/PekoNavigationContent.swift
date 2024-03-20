//
//  PekoNavigationContent.swift
//
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
public struct PekoNavigationContent<NavigationContent: View, Content: View>: View {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    @EnvironmentObject private var pekoConfigurations: PekoConfigurations
    
    @State private var paddingTop: CGFloat = 0
    
    @State private var dividerColor: Color? = nil
    
    @State private var disableScroll: Bool = false
    @State private var disableGeometryReader: Bool = false
    @State private var disableBottomTabbarView = false
    
    private var refreshableAction: (() -> Void)? = nil
    
    private var navigationContent: () -> (NavigationContent)
    private var content: () -> Content
    
    @State private var orientation = UIDevice.current.orientation
    
    // MARK: - Lifecycle
    
    public init(
        paddingTop: CGFloat = 0,
        dividerColor: Color? = nil,
        disableScroll: Bool = false,
        disableGeometryReader: Bool = false,
        disableBottomTabbarView: Bool = false,
        navigationContent: @escaping () -> NavigationContent,
        content: @escaping () -> Content,
        refreshableAction: (() -> Void)? = nil
    ){
        self.paddingTop = paddingTop
        self.dividerColor = dividerColor
        self.disableScroll = disableScroll
        self.disableGeometryReader = disableGeometryReader
        self.disableBottomTabbarView = disableBottomTabbarView
        self.refreshableAction = refreshableAction
        self.navigationContent = navigationContent
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
            .safeAreaInset(edge: .top) {
                if let dividerColor {
                    VStack(spacing: .zero) {
                        navigationContent()
                        Divider()
                            .frame(height: 1)
                            .background(dividerColor)
                    }
                    .background(Color(UIColor.systemBackground))
                } else {
                    navigationContent()
                        .background(Color(UIColor.systemBackground))
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


