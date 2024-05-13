/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

enum DisableType {
    case out_off_stock
    case limit_2_main_dish
    case none
}

extension Product {
    
    func getPrice() -> Int {
        
        if let item = self.items.first {
            return item.price
        }
        else{
            return self.price ?? 0
        }
    }
}

class Product : NSObject, Mappable, Identifiable {
    
    var disableType:DisableType = .none
	var id : String?
	var quantity : Int = 0
    var selectedQuantity : Int = 1
	var price : Int?  
	var status : String?
	var isPreOrder : Bool = false
    var menu: String = S.emptyDefault
	var dateSale : String?
	var createdAt : String?
	var updatedAt : String?
	var product : ProductInfo?
    var items : [Items] = Array()
    var type : TypeProduct?
    var itemSelected : Items?
    var priceName : String = S.empty

    var isLimitedProduct:Bool = false
    
    var points : Double = 0.0
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {

		id <- map["id"]
		quantity <- map["quantity"]
		price <- map["price"]
		status <- map["status"]
        menu <- map["menu"]
		isPreOrder <- map["isPreOrder"]
		dateSale <- map["dateSale"]
		createdAt <- map["createdAt"]
		updatedAt <- map["updatedAt"]
		product <- map["product"]
        items <- map["items"]
        type <- map["type"]
        
        if let type = self.type{
            
            self.priceName = "\(type.price.formatnumber()) đ"
            self.price = type.price
        }
        else if self.items.count > 0{
            
            self.priceName = self.getNameFromItem(item: items, menu: self.menu)
            
        }
	}

   
    private func getNameFromItem(item:[Items], menu:String) -> String{
        
        let sortedPrice = item.sorted {
            $0.price < $1.price
        }
        
        self.items = sortedPrice;
        
        for item in sortedPrice {
            
            if (menu == AppMenu.TODAY_MENU){
                
                item.name = "\(item.price.formatnumber()) đ"
            }
        }
        
        if sortedPrice.count == 1, let fistItem = sortedPrice.first{
            
            return "\(fistItem.price.formatnumber()) đ"
        }
        else if sortedPrice.count >= 2, let fistItem = sortedPrice.first, let lastItem = sortedPrice.last{
            
            return "\(fistItem.price.formatnumber()) - \(lastItem.price.formatnumber()) đ"
        }
        else{
            
            return "0 đ"
        }
        
    }
}

/*
 "type": {
         "id": "403b6b79-1a60-4fdb-b8bc-2acf4c1b794c",
         "name": "Combo 40k",
         "price": 40000,
         "createdAt": "2023-05-12T08:32:15.000Z",
         "updatedAt": "2023-05-12T08:32:15.000Z"
       }
 */
struct TypeProduct : Mappable {
    var id : String?
    var name : String = ""
    var price : Int = 0
   
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        price <- map["price"]
    }
}

struct ProductInfo : Mappable {
    var id : String?
    var name : String?
    var description : String?
    var imageURL : String?
    var isActive : Bool?
    var type : String?
    var createdAt : String?
    var updatedAt : String?
    var isLimit:Bool = false

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        isLimit <- map["isLimit"]
        description <- map["description"]
        imageURL <- map["imageURL"]
        
        if let imgURL = imageURL {
            
            self.imageURL = imgURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        }
        
        isActive <- map["isActive"]
        type <- map["type"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
       // items <- map["items"]
    }

}

struct ExpiredTime : Mappable {
    var expirePreOrderFrom : String?
    var expirePreOrderTo : String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        expirePreOrderFrom <- map["expirePreOrderFrom"]
        expirePreOrderTo <- map["expirePreOrderTo"]
    }
}

class Items : NSObject, Mappable {
    var id : String?
    var name : String = ""
    var quantity : Int = 0
    var price : Int = 0
    var isLimit : Bool = false
    var isDisable : Bool = false
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {

        id <- map["id"]
        isLimit <- map["isLimit"]
        name <- map["name"]
        price <- map["price"]
        quantity <- map["quantity"]
    }

}

extension Product {
    
    func isOutOfStock() -> Bool{
        
        if self.items.count == 0 {
            
            if self.quantity <= 0 {
                
                return true
            }
            else{
                
                return false
            }
        }
        else{
            
            for item in self.items {
                
                if item.quantity > 0 {
                    
                    return false
                }
            }
            
            return true
        }
    }
}
