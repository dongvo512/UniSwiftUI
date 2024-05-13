/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

class ProductBill : NSObject,Mappable {
	var id : String?
	var orderDate : String?
	var totalPrice : Int = 0
	var status : String?
    var code : String = ""
	var userEmail : String?
	var userId : String?
	var completedBy : String?
	var completedAt : String?
	var userPhone : String?
	var createdAt : String?
	var expireDate : String?
	var updatedAt : String?
	var orderDetails : [OrderDetails] = Array()
	var cart : CartBill?
    var branch : Branch?
    
	required init?(map: Map) {

	}

	 func mapping(map: Map) {

        branch <- map["branch"]
		id <- map["id"]
        code <- map["code"]
		orderDate <- map["orderDate"]
		totalPrice <- map["totalPrice"]
		status <- map["status"]
		userEmail <- map["userEmail"]
		userId <- map["userId"]
		completedBy <- map["completedBy"]
		completedAt <- map["completedAt"]
		userPhone <- map["userPhone"]
		createdAt <- map["createdAt"]
		expireDate <- map["expireDate"]
		updatedAt <- map["updatedAt"]
		orderDetails <- map["orderDetails"]
		cart <- map["cart"]
         
         if let orderDetail = self.orderDetails.first, let idBill = self.id {
             orderDetail.idBill = idBill
         }
	}
}

struct CartBill : Mappable {
    var id : String?
    var totalPrice : Int?
    var dateSale : String?
    var isPreOrder : Bool?
    var status : String?
    var paymentDate : String?
    var createdAt : String?
    var updatedAt : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        totalPrice <- map["totalPrice"]
        dateSale <- map["dateSale"]
        isPreOrder <- map["isPreOrder"]
        status <- map["status"]
        paymentDate <- map["paymentDate"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }

}

class OrderDetails : NSObject, Mappable {
    var idBill : String?
    var id : String?
    var productItem : String?
    var productName : String = ""
    var productDescription : String?
    var optional : String?
    var productImage : String?
    var price : Int = 0
    var quantity : Int = 0
    var createdAt : String?
    var updatedAt : String?

    required init?(map: Map) {

    }

     func mapping(map: Map) {

        id <- map["id"]
        productItem <- map["productItem"]
        productName <- map["productName"]
        productDescription <- map["productDescription"]
        optional <- map["optional"]
        price <- map["price"]
        quantity <- map["quantity"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        productImage <- map["productImage"]
    }

}
