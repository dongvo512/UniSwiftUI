/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Cart : Mappable {
	var id : String?
	var totalPrice : Int?
	var cartDetail : [CartDetail] = Array()
    var productsLimit:[CartDetail] = Array()
    var products:[CartDetail] = Array()
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		totalPrice <- map["totalPrice"]
		cartDetail <- map["cartDetail"]
        
        for item in cartDetail {
            
            if item.isLimit {
                
                self.productsLimit.append(item)
            }
            else{
                
                self.products.append(item)
            }
        }
	}
}

class CartDetail : NSObject ,Mappable {
    var idMenu : String?
    var quantity : Int = 0
    var quantityInStock: Int = 0
    var price : Int = 0
    var optional : String?
    var name : String = ""
    var strDescription : String = ""
    var imageURL : String?
    var isLimit:Bool = false

    override init() {
        
    }
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {

        idMenu <- map["idMenu"]
        isLimit <- map["isLimit"]
        quantity <- map["quantity"]
        quantityInStock <- map["quantityInStock"]
        price <- map["price"]
        optional <- map["optional"]
        name <- map["name"]
        strDescription <- map["description"]
        imageURL <- map["imageURL"]
        
        if let imgURL = imageURL {
            
            self.imageURL = imgURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        }
    }

}
