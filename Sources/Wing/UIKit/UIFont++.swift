//
//  UIFont++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

/*
Copperplate ["Copperplate-Light", "Copperplate", "Copperplate-Bold"]
Apple SD Gothic Neo ["AppleSDGothicNeo-Thin", "AppleSDGothicNeo-Light", "AppleSDGothicNeo-Regular", "AppleSDGothicNeo-Bold", "AppleSDGothicNeo-SemiBold", "AppleSDGothicNeo-UltraLight", "AppleSDGothicNeo-Medium"]
Thonburi ["Thonburi", "Thonburi-Light", "Thonburi-Bold"]
Gill Sans ["GillSans-Italic", "GillSans-SemiBold", "GillSans-UltraBold", "GillSans-Light", "GillSans-Bold", "GillSans", "GillSans-SemiBoldItalic", "GillSans-BoldItalic", "GillSans-LightItalic"]
Marker Felt ["MarkerFelt-Thin", "MarkerFelt-Wide"]
Hiragino Maru Gothic ProN ["HiraMaruProN-W4"]
Courier New ["CourierNewPS-ItalicMT", "CourierNewPSMT", "CourierNewPS-BoldItalicMT", "CourierNewPS-BoldMT"]
Kohinoor Telugu ["KohinoorTelugu-Regular", "KohinoorTelugu-Medium", "KohinoorTelugu-Light"]
Avenir Next Condensed ["AvenirNextCondensed-Heavy", "AvenirNextCondensed-MediumItalic", "AvenirNextCondensed-Regular", "AvenirNextCondensed-UltraLightItalic", "AvenirNextCondensed-Medium", "AvenirNextCondensed-HeavyItalic", "AvenirNextCondensed-DemiBoldItalic", "AvenirNextCondensed-Bold", "AvenirNextCondensed-DemiBold", "AvenirNextCondensed-BoldItalic", "AvenirNextCondensed-Italic", "AvenirNextCondensed-UltraLight"]
Tamil Sangam MN ["TamilSangamMN", "TamilSangamMN-Bold"]
Helvetica Neue ["HelveticaNeue-UltraLightItalic", "HelveticaNeue-Medium", "HelveticaNeue-MediumItalic", "HelveticaNeue-UltraLight", "HelveticaNeue-Italic", "HelveticaNeue-Light", "HelveticaNeue-ThinItalic", "HelveticaNeue-LightItalic", "HelveticaNeue-Bold", "HelveticaNeue-Thin", "HelveticaNeue-CondensedBlack", "HelveticaNeue", "HelveticaNeue-CondensedBold", "HelveticaNeue-BoldItalic"]
Times New Roman ["TimesNewRomanPS-ItalicMT", "TimesNewRomanPS-BoldItalicMT", "TimesNewRomanPS-BoldMT", "TimesNewRomanPSMT"]
Georgia ["Georgia-BoldItalic", "Georgia-Italic", "Georgia", "Georgia-Bold"]
Sinhala Sangam MN ["SinhalaSangamMN-Bold", "SinhalaSangamMN"]
Arial Rounded MT Bold ["ArialRoundedMTBold"]
Kailasa ["Kailasa-Bold", "Kailasa"]
Kohinoor Devanagari ["KohinoorDevanagari-Regular", "KohinoorDevanagari-Light", "KohinoorDevanagari-Semibold"]
Kohinoor Bangla ["KohinoorBangla-Regular", "KohinoorBangla-Semibold", "KohinoorBangla-Light"]
Noto Sans Oriya ["NotoSansOriya-Bold", "NotoSansOriya"]
Chalkboard SE ["ChalkboardSE-Bold", "ChalkboardSE-Light", "ChalkboardSE-Regular"]
Noto Sans Kannada ["NotoSansKannada-Bold", "NotoSansKannada-Light", "NotoSansKannada-Regular"]
Apple Color Emoji ["AppleColorEmoji"]
PingFang TC ["PingFangTC-Regular", "PingFangTC-Thin", "PingFangTC-Medium", "PingFangTC-Semibold", "PingFangTC-Light", "PingFangTC-Ultralight"]
Geeza Pro ["GeezaPro-Bold", "GeezaPro"]
Damascus ["DamascusBold", "DamascusLight", "Damascus", "DamascusMedium", "DamascusSemiBold"]
Noteworthy ["Noteworthy-Bold", "Noteworthy-Light"]
Avenir ["Avenir-Oblique", "Avenir-HeavyOblique", "Avenir-Heavy", "Avenir-BlackOblique", "Avenir-BookOblique", "Avenir-Roman", "Avenir-Medium", "Avenir-Black", "Avenir-Light", "Avenir-MediumOblique", "Avenir-Book", "Avenir-LightOblique"]
Kohinoor Gujarati ["KohinoorGujarati-Light", "KohinoorGujarati-Bold", "KohinoorGujarati-Regular"]
Mishafi ["DiwanMishafi"]
Academy Engraved LET ["AcademyEngravedLetPlain"]
Party LET ["PartyLetPlain"]
Futura ["Futura-CondensedExtraBold", "Futura-Medium", "Futura-Bold", "Futura-CondensedMedium", "Futura-MediumItalic"]
Arial Hebrew ["ArialHebrew-Bold", "ArialHebrew-Light", "ArialHebrew"]
Farah ["Farah"]
Mukta Mahee ["MuktaMahee-Light", "MuktaMahee-Bold", "MuktaMahee-Regular"]
Noto Sans Myanmar ["NotoSansMyanmar-Regular", "NotoSansMyanmar-Bold", "NotoSansMyanmar-Light"]
Arial ["Arial-BoldMT", "Arial-BoldItalicMT", "Arial-ItalicMT", "ArialMT"]
Chalkduster ["Chalkduster"]
Kefa ["Kefa-Regular"]
Hoefler Text ["HoeflerText-Italic", "HoeflerText-Black", "HoeflerText-Regular", "HoeflerText-BlackItalic"]
Optima ["Optima-ExtraBlack", "Optima-BoldItalic", "Optima-Italic", "Optima-Regular", "Optima-Bold"]
Galvji ["Galvji-Bold", "Galvji"]
Palatino ["Palatino-Italic", "Palatino-Roman", "Palatino-BoldItalic", "Palatino-Bold"]
Malayalam Sangam MN ["MalayalamSangamMN-Bold", "MalayalamSangamMN"]
Al Nile ["AlNile", "AlNile-Bold"]
Lao Sangam MN ["LaoSangamMN"]
Bradley Hand ["BradleyHandITCTT-Bold"]
Hiragino Mincho ProN ["HiraMinProN-W3", "HiraMinProN-W6"]
PingFang HK ["PingFangHK-Medium", "PingFangHK-Thin", "PingFangHK-Regular", "PingFangHK-Ultralight", "PingFangHK-Semibold", "PingFangHK-Light"]
Helvetica ["Helvetica-Oblique", "Helvetica-BoldOblique", "Helvetica", "Helvetica-Light", "Helvetica-Bold", "Helvetica-LightOblique"]
Courier ["Courier-BoldOblique", "Courier-Oblique", "Courier", "Courier-Bold"]
Cochin ["Cochin-Italic", "Cochin-Bold", "Cochin", "Cochin-BoldItalic"]
Trebuchet MS ["TrebuchetMS-Bold", "TrebuchetMS-Italic", "Trebuchet-BoldItalic", "TrebuchetMS"]
Devanagari Sangam MN ["DevanagariSangamMN", "DevanagariSangamMN-Bold"]
Rockwell ["Rockwell-Italic", "Rockwell-Regular", "Rockwell-Bold", "Rockwell-BoldItalic"]
Snell Roundhand ["SnellRoundhand", "SnellRoundhand-Bold", "SnellRoundhand-Black"]
Zapf Dingbats ["ZapfDingbatsITC"]
Bodoni 72 ["BodoniSvtyTwoITCTT-Bold", "BodoniSvtyTwoITCTT-BookIta", "BodoniSvtyTwoITCTT-Book"]
Verdana ["Verdana-Italic", "Verdana", "Verdana-Bold", "Verdana-BoldItalic"]
American Typewriter ["AmericanTypewriter-CondensedBold", "AmericanTypewriter-Condensed", "AmericanTypewriter-CondensedLight", "AmericanTypewriter", "AmericanTypewriter-Bold", "AmericanTypewriter-Semibold", "AmericanTypewriter-Light"]
Avenir Next ["AvenirNext-Medium", "AvenirNext-DemiBoldItalic", "AvenirNext-DemiBold", "AvenirNext-HeavyItalic", "AvenirNext-Regular", "AvenirNext-Italic", "AvenirNext-MediumItalic", "AvenirNext-UltraLightItalic", "AvenirNext-BoldItalic", "AvenirNext-Heavy", "AvenirNext-Bold", "AvenirNext-UltraLight"]
Baskerville ["Baskerville-SemiBoldItalic", "Baskerville-SemiBold", "Baskerville-BoldItalic", "Baskerville", "Baskerville-Bold", "Baskerville-Italic"]
Khmer Sangam MN ["KhmerSangamMN"]
Didot ["Didot-Bold", "Didot", "Didot-Italic"]
Savoye LET ["SavoyeLetPlain"]
Bodoni Ornaments ["BodoniOrnamentsITCTT"]
Symbol ["Symbol"]
Charter ["Charter-BlackItalic", "Charter-Bold", "Charter-Roman", "Charter-Black", "Charter-BoldItalic", "Charter-Italic"]
Menlo ["Menlo-BoldItalic", "Menlo-Bold", "Menlo-Italic", "Menlo-Regular"]
Noto Nastaliq Urdu ["NotoNastaliqUrdu", "NotoNastaliqUrdu-Bold"]
Bodoni 72 Smallcaps ["BodoniSvtyTwoSCITCTT-Book"]
DIN Alternate ["DINAlternate-Bold"]
Papyrus ["Papyrus-Condensed", "Papyrus"]
Hiragino Sans ["HiraginoSans-W3", "HiraginoSans-W6", "HiraginoSans-W7"]
PingFang SC ["PingFangSC-Medium", "PingFangSC-Semibold", "PingFangSC-Light", "PingFangSC-Ultralight", "PingFangSC-Regular", "PingFangSC-Thin"]
Myanmar Sangam MN ["MyanmarSangamMN", "MyanmarSangamMN-Bold"]
Apple Symbols ["AppleSymbols"]
Zapfino ["Zapfino"]
Bodoni 72 Oldstyle ["BodoniSvtyTwoOSITCTT-BookIt", "BodoniSvtyTwoOSITCTT-Book", "BodoniSvtyTwoOSITCTT-Bold"]
Euphemia UCAS ["EuphemiaUCAS", "EuphemiaUCAS-Italic", "EuphemiaUCAS-Bold"]
DIN Condensed ["DINCondensed-Bold"]
*/

import Foundation
import UIKit

public extension UIFont {

    //  create font with subscript, eg: UIFont[12]
    static subscript(fontSize: CGFloat) -> UIFont {
        get { return UIFont.systemFont(ofSize: fontSize) }
    }

    //  create bold font with subscript, eg: UIFont[bold: 12]
    static subscript(bold fontSize: CGFloat) -> UIFont {
        get { return UIFont.boldSystemFont(ofSize: fontSize) }
    }

    //get fontAttributes of fontDescriptor
    var fontAttributes: [UIFontDescriptor.AttributeName : Any] {
        get { return self.fontDescriptor.fontAttributes }
    }

    // font is bold
    var isBold: Bool {
        get { return self.fontDescriptor.symbolicTraits.contains(.traitBold) }
    }
    // get bold font with current font attributes eg:UIFont[12].bold
    var bold: UIFont {
        get {
            if self.isBold  { return self }
            let fontDescriptor = self.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.bold]])
            return UIFont(descriptor: fontDescriptor, size: 0)
        }
    }

    // get bold weight of current font
    var fontWeight: CGFloat {
        get {
            guard let traits = self.fontDescriptor.fontAttributes[UIFontDescriptor.AttributeName.traits] as? [UIFontDescriptor.TraitKey : Any],
                let weight = traits[UIFontDescriptor.TraitKey.weight] as? NSNumber else {
                    return 0.0
            }
            return CGFloat(weight.floatValue)
        }
    }

    /// create font with UIFont.TextStyle , size , transform
    /// - Parameters:
    ///   - style: style
    ///   - size: font size
    ///   - matrix: font transform that will apply to font default .identity
    static func fontWithStyle(_ style: UIFont.TextStyle,
                              size: CGFloat,
                              matrix: CGAffineTransform = .identity) -> UIFont {

        var fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        fontDescriptor = fontDescriptor.withMatrix(matrix)
        return UIFont(descriptor: fontDescriptor, size: size)
    }


    /// create font with font family , font weight, font size , transform
    /// - Parameter familyName: font family
    /// - Parameter weight: font weight
    /// - Parameter size: font size
    /// - Parameter matrix: font transform
    static func fontWithFamily(_ familyName: String? = nil,
                               weight: UIFont.Weight = .regular,
                               size: CGFloat,
                               matrix: CGAffineTransform = .identity) -> UIFont {
        var fontDescriptor = UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor
        fontDescriptor = fontDescriptor.withMatrix(matrix)
        if familyName != nil {
            fontDescriptor = fontDescriptor.withFamily(familyName!)
        }
        return UIFont(descriptor: fontDescriptor, size: 0)
    }


    /// create font with font name , font size , transform  ps: font name is font family followed with font weight, it contains font weight attribute
    /// - Parameters:
    ///   - name: font name
    ///   - size: font size
    ///   - matrix: transform
    static func fontWithName(_ name: String? = nil,
                             size: CGFloat,
                             matrix: CGAffineTransform = .identity) -> UIFont {
        var fontDescriptor: UIFontDescriptor
        if name != nil {
            fontDescriptor = UIFontDescriptor(name: name!, size: size)
        } else {
            fontDescriptor = UIFontDescriptor()
            fontDescriptor = fontDescriptor.withSize(size)
        }
        fontDescriptor = fontDescriptor.withMatrix(matrix)
        return UIFont(descriptor: fontDescriptor, size: 0)
    }


}
