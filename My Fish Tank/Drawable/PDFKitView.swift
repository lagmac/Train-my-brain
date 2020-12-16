//
//  PDFKitView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 11/12/20.
//

import SwiftUI
import PDFKit

struct PDFKitView: View
{
    var url: URL
    var body: some View
    {
        PDFKitRepresentedView(url)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable
{
    let url: URL
    
    init(_ url: URL)
    {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType
    {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>)
    {
        // Update the view.
    }
}
