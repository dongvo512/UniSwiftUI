//
//  LanguageService.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import Foundation

class LanguageService: NSObject {
    
    static let shared = LanguageService()
    var currentLanguage:String = Lang.vi
    
    override private init() {
        super.init()
        
        self.getLanguage()
    }
    
    private func getLanguage() {
        
        let appLanguage = Locale.preferredLanguages[0]
    
        if let currLang = LocaleStorageService.shared.getLanguageCurr(){

            self.currentLanguage = currLang
        } else {

            var languageCode = ""

            if appLanguage == Lang.vi || appLanguage == Lang.viVN {

                languageCode = Lang.vi
            }
            else{

                languageCode = Lang.en
            }

            self.currentLanguage = languageCode
        }
        
        self.changeLanguage(language: self.currentLanguage)
    }
    
    func changeLanguage(language: String) {
       
        self.currentLanguage = language
        
        LocaleStorageService.shared.saveLanguageCurr(language: self.currentLanguage)
    }
}
