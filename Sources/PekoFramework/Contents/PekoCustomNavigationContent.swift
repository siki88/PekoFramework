//
//  PekoNavigationContent.swift
//
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
public struct PekoCustomNavigationContent<Content: View>: View {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    @EnvironmentObject private var pekoConfigurations: PekoConfigurations
    
    @State private var centerTitle: String?
    @State private var centerImage: Image?
    @State private var leftImage: Image?
    @State private var rightImage: Image?
    
    @State private var paddingTop: CGFloat = 0
    
    @State private var dividerColor: Color? = nil
    
    @State private var disableScroll: Bool = false
    @State private var disableGeometryReader: Bool = false
    @State private var disableBottomTabbarView = false
    
    private var leftButtonTapped: (() -> Void)?
    private var rightButtonTapped: (() -> Void)?
    private var refreshableAction: (() -> Void)? = nil
    
    private var content: () -> Content
    
    @State private var orientation = UIDevice.current.orientation
    
    // MARK: - Lifecycle
    
    public init(
        centerTitle: String? = nil,
        centerImage: Image? = nil,
        leftImage: Image? = nil,
        rightImage: Image? = nil,
        paddingTop: CGFloat = 56,
        dividerColor: Color? = nil,
        disableScroll: Bool = false,
        disableGeometryReader: Bool = false,
        disableBottomTabbarView: Bool = false,
        content: @escaping () -> Content,
        leftButtonTapped: (() -> Void)? = nil,
        rightButtonTapped: (() -> Void)? = nil,
        refreshableAction: (() -> Void)? = nil
    ){
        self.centerTitle = centerTitle
        self.centerImage = centerImage
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.paddingTop = paddingTop
        self.dividerColor = dividerColor
        self.disableScroll = disableScroll
        self.disableGeometryReader = disableGeometryReader
        self.disableBottomTabbarView = disableBottomTabbarView
        self.leftButtonTapped = leftButtonTapped
        self.rightButtonTapped = rightButtonTapped
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
            .safeAreaInset(edge: .top) {
                VStack(spacing: 0) {
                    ZStack {
                        HStack {
                            if let leftImage {
                                leftImage
                                    .onTapGesture {
                                        leftButtonTapped?()
                                    }
                            } else {
                                Spacer()
                            }
                            Spacer()
                            if let rightImage {
                                rightImage
                                    .onTapGesture {
                                        rightButtonTapped?()
                                    }
                            } else {
                                Spacer()
                            }
                        }
                        if centerImage != nil || centerTitle != nil {
                            HStack {
                                Spacer()
                                if let centerImage {
                                    centerImage
                                } else if let centerTitle {
                                    
                                    #warning("TUDU")
                                    
                                    Label(
                                        text: centerTitle,
                                        font: .system(size: 17),
                                        bold: true,
                                        color: .black,
                                        alignment: .center
                                    )
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    
                    if let dividerColor {
                        Divider()
                            .frame(height: 1)
                            .background(dividerColor)
                    }
                }
                .background(Color(UIColor.systemBackground))
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


