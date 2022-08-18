//
//  WList.swift
//  
//
//  Created by 周朋毅 on 2022/8/17.
//

import SwiftUI
import Algorithms

@available(iOS 13.0, OSX 10.15, *)
public struct WList<Data, Cell: View,
                        Header: View,
                        Footer: View>: View where Data: RandomAccessCollection, Data.Element: WSectional, Data.Element.SectionKey : Hashable, Data.Element.Items: RandomAccessCollection, Data.Element.Items.Element: Identifiable {
    public enum SeparatorStyle {
        case none
        case singleLine
    }
    private let axes: Axis.Set
    private let showIndicators: Bool
    private var isScrollEnabled: Bool = true
    private var contentInsects: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

    private let data: Data
    private let cell: (Data.Element.Items.Element) -> Cell
    private let header: (Data.Element.SectionKey) -> Header
    private let footer: (Data.Element.SectionKey) -> Footer
    private var headerView: AnyView? = nil
    private var footerView: AnyView? = nil
    private var separatorStyle: SeparatorStyle = .none

  
    public var body : some View {
        Group {
          if !self.data.isEmpty || headerView != nil || footerView != nil {
              if self.isScrollEnabled {
                ScrollView(axes,
                           showsIndicators: self.showIndicators) {
                  contentView
                }
              } else {
                  contentView
              }
            }
        }
    }
    private var contentView: some View {
        Group {
            if #available(iOS 14.0, *) {
                LazyVStack(spacing: 0) {
                    verticalContentView()
                }
            } else {
                VStack(spacing: 0) {
                    verticalContentView()
                }
            }
        }
   }
    private func verticalContentView() -> some View {
        Group {
            if let headerView = headerView {
                headerView
            }
            ForEach(self.data, id: \.key) { section in
                VStack(spacing: 0) {
                    header(section.key)
                        .frame(maxWidth: .infinity)
                    sectionContentView(for: section.items)
                    footer(section.key)
                        .frame(maxWidth: .infinity)
                }
            }
            if let footerView = footerView {
                footerView
            }

        }
    }
    private func sectionContentView(for items: Data.Element.Items) -> some View {

        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
            VStack(spacing: 0) {
                cell(item)
                    .frame(maxWidth: .infinity)
                if index < items.count - 1 {
                    Divider()
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(contentInsects)
    }

}

public extension WList {
    
    init(_ axes: Axis.Set = .vertical,
         showIndicators: Bool = true,
         data: Data,
         @ViewBuilder cell: @escaping (Data.Element.Items.Element) -> Cell,
         @ViewBuilder header: @escaping (Data.Element.SectionKey) -> Header,
         @ViewBuilder footer: @escaping (Data.Element.SectionKey) -> Footer) {
        self.axes = axes
        self.showIndicators = showIndicators
        self.data = data
        self.cell = cell
        self.header = header
        self.footer = footer
    }

    init(_ axes: Axis.Set = .vertical,
         showIndicators: Bool = true,
         data: Data,
         @ViewBuilder cell: @escaping (Data.Element.Items.Element) -> Cell) where Header == EmptyView, Footer == EmptyView {
        self.init(axes,
                  showIndicators: showIndicators,
                  data: data,
                  cell: cell,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() })
    }

    init(_ axes: Axis.Set = .vertical,
         showIndicators: Bool = true,
         data: Data,
         @ViewBuilder cell: @escaping (Data.Element.Items.Element) -> Cell,
         @ViewBuilder header: @escaping (Data.Element.SectionKey) -> Header) where Footer == EmptyView {
        self.init(axes,
                  showIndicators: showIndicators,
                  data: data,
                  cell: cell,
                  header: header,
                  footer: { _ in EmptyView() })
    }

    init(_ axes: Axis.Set = .vertical,
         showIndicators: Bool = true,
         data: Data,
         @ViewBuilder cell: @escaping (Data.Element.Items.Element) -> Cell,
         @ViewBuilder footer: @escaping (Data.Element.SectionKey) -> Footer) where Header == EmptyView {
        self.init(axes,
                  showIndicators: showIndicators,
                  data: data,
                  cell: cell,
                  header: { _ in EmptyView() },
                  footer: footer)
    }
    
}

// init from [[]]
public extension WList {
    
    init<Items>(_ axes: Axis.Set = .vertical,
                showIndicators: Bool = true,
                data: Items,
                @ViewBuilder cell: @escaping (Items.Element.Element) -> Cell,
                @ViewBuilder header: @escaping () -> Header,
                @ViewBuilder footer: @escaping () -> Footer) where Items: RandomAccessCollection, Items.Element: RandomAccessCollection, Items.Element.Element: Identifiable, Data == Array<WSection<Items.Element>> {
        self.init(axes,
                  showIndicators: showIndicators,
                  data: data.map({WSection(items: $0)}),
                  cell: cell) { _ in
            header()
        } footer: { _ in
            footer()
        }

    }

    init<Items>(_ axes: Axis.Set = .vertical,
                showIndicators: Bool = true,
                data: Items,
                @ViewBuilder cell: @escaping (Items.Element.Element) -> Cell) where Items: RandomAccessCollection, Items.Element: RandomAccessCollection, Items.Element.Element: Identifiable, Data == Array<WSection<Items.Element>>, Header == EmptyView, Footer == EmptyView {
        self.init(axes,
                  showIndicators: showIndicators,
                  data: data,
                  cell: cell,
                  header: {EmptyView()},
                  footer: {EmptyView()})
            
    }

    init<Items>(_ axes: Axis.Set = .vertical,
                showIndicators: Bool = true,
                data: Items,
                @ViewBuilder cell: @escaping (Items.Element.Element) -> Cell,
                @ViewBuilder header: @escaping () -> Header) where Items: RandomAccessCollection, Items.Element: RandomAccessCollection, Items.Element.Element: Identifiable, Data == Array<WSection<Items.Element>>, Footer == EmptyView {
        self.init(axes,
                  showIndicators: showIndicators,
                  data: data,
                  cell: cell,
                  header: header,
                  footer: {EmptyView()})
            
    }
    init<Items>(_ axes: Axis.Set = .vertical,
                showIndicators: Bool = true,
                data: Items,
                @ViewBuilder cell: @escaping (Items.Element.Element) -> Cell,
                @ViewBuilder footer: @escaping () -> Footer) where Items: RandomAccessCollection, Items.Element: RandomAccessCollection, Items.Element.Element: Identifiable, Data == Array<WSection<Items.Element>>, Header == EmptyView {
        self.init(axes,
                  showIndicators: showIndicators,
                  data: data,
                  cell: cell,
                  header: {EmptyView()},
                  footer: footer)
            
    }

}

// init from []
public extension WList {
    init<Items>(_ items: Items,
                @ViewBuilder cell: @escaping (Items.Element) -> Cell) where Items: RandomAccessCollection, Items.Element: Identifiable,
    Header == EmptyView, Footer == EmptyView,
    Data == Array<WSection<Items>>  {
        self.init(.vertical,
                  showIndicators: true,
                  data: [items],
                  cell: cell)
    }

}

// init from [[WListItem]]
public extension WList {
    init<Items>(_ items: Items) where Items: RandomAccessCollection, Items.Element: RandomAccessCollection, Items.Element.Element == WListItem,
    Header == EmptyView, Footer == EmptyView, Cell == WListCell,
    Data == Array<WSection<Items.Element>>  {
        self.init(.vertical,
                  showIndicators: true,
                  data: items,
                  cell: { item in
            WListCell(item: item)
        })
    }
}

public extension WList {
    func isScrollEnabled(_ enabled: Bool) -> Self {
        var newSelf = self
        newSelf.isScrollEnabled = enabled
        return newSelf
    }
    func contentInsets(_ insets: EdgeInsets) -> Self {
        var newSelf = self
        newSelf.contentInsects = insets
        return newSelf
    }
    func separatorStyle(_ style: SeparatorStyle) -> Self {
        var newSelf = self
        newSelf.separatorStyle = style
        return newSelf
    }
}


public extension WList {
    func headerView<HeaderView: View>(@ViewBuilder headerView: ()->HeaderView) -> Self {
        var newSelf = self
        newSelf.headerView = AnyView(headerView())
        return newSelf
    }
    func footerView<FooterView: View>(@ViewBuilder footerView: ()->FooterView) -> Self {
        var newSelf = self
        newSelf.footerView = AnyView(footerView())
        return newSelf
    }

}
