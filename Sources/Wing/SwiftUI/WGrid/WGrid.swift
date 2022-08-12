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
                        Footer: View,
                        GridHeaderView: View>: View where Data: RandomAccessCollection, Data.Element: WSectional, Data.Element.SectionKey : Hashable, Data.Element.Items: RandomAccessCollection, Data.Element.Items.Element: Identifiable {
    private let axes: Axis.Set
    private let showIndicators: Bool
    private var layout: WGridLayout = WGridLayout(columns: 3, innerSpacing: 10, lineSpacing: 10)
    private var isScrollEnabled: Bool = true
    private var contentInsects: UIEdgeInsets = .zero

    private let data: Data
    private let cell: (Data.Element.Items.Element) -> Cell
    private let header: (Data.Element.SectionKey) -> Header
    private let footer: (Data.Element.SectionKey) -> Footer
    private var gridHeaderView: GridHeaderView? = nil

  
    public var body : some View {
      GeometryReader { geometry in
        Group {
          if !self.data.isEmpty || gridHeaderView != nil {
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
                VStack(spacing: 0) {
                    if let gridHeaderView = gridHeaderView {
                        gridHeaderView
                    }
                    ForEach(self.data, id: \.key) { section in
                        VStack(spacing: 0) {
                            header(section.key)
                                .frame(width: geometry.frame(in: .local).width)
                            sectionView(for: section.items)
                            footer(section.key)
                                .frame(width: geometry.frame(in: .local).width)
                        }
                    }
                }
            } else {
                
            }
        }
        .padding(.leading, contentInsects.left)
        .padding(.trailing, contentInsects.right)
        .padding(.top, contentInsects.top)
        .padding(.bottom, contentInsects.bottom)
   }
    private func chunkSection(_ sectionItems: Data.Element.Items, by size: Int) -> [[Data.Element.Items.Element]] {
        return sectionItems.chunks(ofCount: layout.columns).map(Array.init)
    }
    
    private func sectionView(for items: Data.Element.Items) -> some View {
        Group {
            if layout.columns == 1 {
                ForEach(items) { item in
                    cell(item)
                        .maxWidth(.infinity)
                }
            } else {
                VStack(spacing: layout.lineSpacing) {
                    ForEach(0..<chunkSection(items, by: layout.columns).count, id: \.self) { index in
                        rowView(for: chunkSection(items, by: layout.columns)[index])
                    }
                }
            }
        }
    }
    
    private func rowView(for elements: [Data.Element.Items.Element]) -> some View {
        HStack(spacing: layout.innerSpacing) {
            ForEach(elements) { element in
                cell(element)
                    .maxWidth(.infinity)
            }
            if elements.count < layout.columns {
                ForEach(0..<(layout.columns - elements.count), id: \.self) { _ in
                    Color.clear
                        .maxWidth(.infinity)
                }
            }
        }
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
    func contentInsets(_ insets: UIEdgeInsets) -> Self {
        var newSelf = self
        newSelf.contentInsects = insets
        return newSelf
    }
}


public extension WGrid {
    func gridHeaderView(@ViewBuilder gridHeaderView: ()->GridHeaderView) -> Self {
        var newSelf = self
        newSelf.gridHeaderView = gridHeaderView()
        return newSelf
    }
}
