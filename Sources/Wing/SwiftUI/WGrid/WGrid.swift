//
//  WGrid.swift
//
//
//  Created by 周朋毅 on 2022/8/10.
//

import SwiftUI
import Algorithms

@available(iOS 13.0, OSX 10.15, *)
public struct WGrid<Data, Cell: View,
                        Header: View,
                    Footer: View>: View where Data: RandomAccessCollection, Data.Element: WSectional, Data.Element.SectionKey : Hashable, Data.Element.Items: RandomAccessCollection, Data.Element.Items.Element: Identifiable {
    private let axes: Axis.Set
    private let showIndicators: Bool
    private var layout: WGridLayout = WGridLayout(columns: 3, innerSpacing: 10, lineSpacing: 10)
    private var isScrollEnabled: Bool = true
    private var contentInsects: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    private let data: Data
    private let cell: (Data.Element.Items.Element) -> Cell
    private let header: (Data.Element.SectionKey) -> Header
    private let footer: (Data.Element.SectionKey) -> Footer
    private var headerView: AnyView? = nil
    private var footerView: AnyView? = nil
    
    
    public var body : some View {
        GeometryReader { geometry in
            Group {
                if !self.data.isEmpty || headerView != nil || footerView != nil {
                    if self.isScrollEnabled {
                        ScrollView(axes,
                                   showsIndicators: self.showIndicators) {
                            self.contentView(in: geometry)
                        }
                    } else {
                        self.contentView(in: geometry)
                    }
                }
            }
        }
    }

    private func contentView(in geometry: GeometryProxy) -> some View {
        Group {
            if axes == .vertical {
                if #available(iOS 14.0, *) {
                    LazyVStack(spacing: 0) {
                        verticalContentView(in: geometry)
                    }
                } else {
                    VStack(spacing: 0) {
                        verticalContentView(in: geometry)
                    }
                }
            } else {
                
            }
        }
    }
    private func verticalContentView(in geometry: GeometryProxy) -> some View  {
        Group {
            if let headerView = headerView {
                headerView
            }
            ForEach(self.data, id: \.key) { section in
                VStack(spacing: 0) {
                    header(section.key)
                        .frame(width: geometry.frame(in: .local).width)
                    sectionView(for: section.items, in: geometry)
                    footer(section.key)
                        .frame(width: geometry.frame(in: .local).width)
                }
            }
            if let footerView = footerView {
                footerView
            }
        }
    }
    private func chunkSection(_ sectionItems: Data.Element.Items, by size: Int) -> [[Data.Element.Items.Element]] {
        return sectionItems.chunks(ofCount: layout.columns).map(Array.init)
    }
    
    private func sectionView(for items: Data.Element.Items, in geometry: GeometryProxy) -> some View {
        Group {
            if layout.columns == 1 {
                ForEach(items) { item in
                    cell(item)
                        .frame(maxWidth: .infinity)
                }
            } else {
                VStack(spacing: layout.lineSpacing) {
                    ForEach(0..<chunkSection(items, by: layout.columns).count, id: \.self) { index in
                        rowView(for: chunkSection(items, by: layout.columns)[index], in: geometry)
                    }
                }
            }
        }
        .padding(contentInsects)
    }
    
    private func rowView(for elements: [Data.Element.Items.Element], in geometry: GeometryProxy) -> some View {
        HStack(spacing: layout.innerSpacing) {
            if layout.spareSpace || elements.count == layout.columns {
                spareSpaceRowView(for: elements, in: geometry)
            } else {
                stretchingRowView(for: elements, in: geometry)
            }
        }
    }
    
    private func spareSpaceRowView(for elements: [Data.Element.Items.Element], in geometry: GeometryProxy) -> some View {
        Group {
            ForEach(elements) { element in
                cell(element)
                    .frame(maxWidth: .infinity)
            }
            if elements.count < layout.columns {
                ForEach(0..<(layout.columns - elements.count), id: \.self) { _ in
                    Color.clear
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
    private func stretchingRowView(for elements: [Data.Element.Items.Element], in geometry: GeometryProxy) -> some View {
        Group {
            ForEach(0..<elements.count - 1) { index in
                cell(elements[index])
                    .frame(width: widthForItem(for: elements, in: geometry))
            }
            if let last = elements.last {
                cell(last)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func widthForItem(for elements: [Data.Element.Items.Element], in proxy: GeometryProxy) -> CGFloat {
        let width = proxy.frame(in: .global).width
        return (width  - CGFloat((layout.columns - 1)) * layout.innerSpacing - contentInsects.leading - contentInsects.trailing).cgFloat / layout.columns.cgFloat
    }

}

public extension WGrid {
    
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
public extension WGrid {
    
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

public extension WGrid {
    init<Items>(_ items: Items,
                @ViewBuilder cell: @escaping (Data.Element.Items.Element) -> Cell) where Items: RandomAccessCollection, Items.Element: Identifiable,
    Header == EmptyView, Footer == EmptyView,
    Data == Array<WSection<Items>>  {
        self.init(.vertical,
                  showIndicators: true,
                  data: [WSection<Items>(items: items)],
                  cell: cell)
    }
}

public extension WGrid {
    func layout(_ layout: WGridLayout) -> Self {
        var newSelf = self
        newSelf.layout = layout
        return newSelf
    }
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
}


public extension WGrid {
    func headerView<HeaderView: View>(@ViewBuilder _ headerView: ()->HeaderView) -> Self {
        var newSelf = self
        newSelf.headerView = AnyView(headerView())
        return newSelf
    }
    func footerView<FooterView: View>(@ViewBuilder _ footerView: ()->FooterView) -> Self {
        var newSelf = self
        newSelf.footerView = AnyView(footerView())
        return newSelf
    }
}
