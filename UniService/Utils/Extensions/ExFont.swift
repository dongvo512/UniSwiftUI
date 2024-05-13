//
//  ExFont.swift
//  UniService
//
//  Created by Admin on 12/01/2024.
//

import Foundation
import SwiftUI

extension Font {
    
    // Regular W400
    static func paragraph1Regular () -> Font{
        return .custom(AppFont.APP_FONT_REGULAR, fixedSize: 16)
    }

    static func paragraph2Regular () -> Font{
        return .custom(AppFont.APP_FONT_REGULAR, fixedSize: 14)
    }

    static func captionRegular () -> Font{
        return .custom(AppFont.APP_FONT_REGULAR, fixedSize: 12)
    }

    static func overLineRegular () -> Font{
        return .custom(AppFont.APP_FONT_REGULAR, fixedSize: 10)
    }
    
    // Medium W600
    static func display1Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 96)
    }

    static func display2Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 80)
    }

    static func display3Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 64)
    }

    static func heading1Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 56)
    }

    static func heading2Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 36)
    }

    static func heading3Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 36)
    }

    static func heading4Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 20)
    }

    static func heading5Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 16)
    }

    static func subTitle1Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 20)
    }

    static func subTitle2Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 16)
    }
    
    static func paragraph1Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 16)
    }
    
    static func paragraph2Medium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 14)
    }
    
    static func captionMedium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 12)
    }
    
    static func overLineMedium () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 10)
    }
    
    
    // Bold W800
    static func display1Bold () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 96)
    }
    
    static func display2Bold () -> Font{
        return .custom(AppFont.APP_FONT_MEDIUM, fixedSize: 80)
    }
    
    static func display3Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 64)
    }
    
    static func heading1Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 56)
    }
    
    static func heading2Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 36)
    }
    
    static func heading3Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 36)
    }
    
    static func heading4Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 20)
    }
    
    static func heading5Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 14)
    }
    
    static func heading6Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 18)
    }
    
    static func subTitle1Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 20)
    }
    
    static func bigTitleBold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 22)
    }
    
    static func subTitle2Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 16)
    }
    
    static func subTitle3Bold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 12)
    }
    
    static func numBold () -> Font{
        return .custom(AppFont.APP_FONT_BOLD, fixedSize: 9)
    }
}
