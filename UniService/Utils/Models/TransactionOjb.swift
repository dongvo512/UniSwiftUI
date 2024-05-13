/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct TransactionOjb : Mappable, Identifiable {
	var id : String?
	var type : String?
    var status : String?
	var userId : String?
	var studentId : String?
	var point : Int = 0
	var transactionId : String?
	var relationId : String?
	var createdAt : String?
	var updatedAt : String?

	init?(map: Map) {

	}

    init() {
        
    }
    
	mutating func mapping(map: Map) {

		id <- map["id"]
		type <- map["type"]
        status <- map["status"]
		userId <- map["userId"]
		studentId <- map["studentId"]
		point <- map["point"]
		transactionId <- map["transactionId"]
		relationId <- map["relationId"]
		createdAt <- map["createdAt"]
		updatedAt <- map["updatedAt"]
	}

}

extension TransactionOjb {
    
    var pointDisplay:String {
        
        if type == TransactionKeyType.tranfer_receive.key {
            if point > 0 {
                return "+\(point.formatnumber()) đ"
            }
            else{
                return "\(point.formatnumber()) đ"
            }
        }
        else{
            if type == TransactionKeyType.deposit.key {
                return "+\(point.formatnumber()) đ"
            }
            else{
                return "-\(point.formatnumber()) đ"
            }
        }
       
    }
    
    var strImg:String{
        switch type {
        case TransactionKeyType.purchase.key:
            return "ic_transaction_buy"
        case TransactionKeyType.deposit.key:
            return "ic_transaction_deposit"
        case TransactionKeyType.tranfer_receive.key:
            return "ic_transfer"
        case TransactionKeyType.vexere.key:
            return "ic_vexere"
        case TransactionKeyType.vending_machine.key:
            return "ic_vending_machine"
        default:
            return "ic_transaction_buy"
        }
    }
    
    var name:String {
        switch type {
        case TransactionKeyType.purchase.key:
            return "purchase".localized()
        case TransactionKeyType.deposit.key:
            return "deposit".localized()
        case TransactionKeyType.tranfer_receive.key:
            return "send/receive".localized()
        case TransactionKeyType.vexere.key:
            return "vexere".localized()
        case TransactionKeyType.vending_machine.key:
            return "vending_machine".localized()
        default:
            return "purchase".localized()
        }
    }
}

extension TransactionOjb: Equatable {
    static func == (lhs: TransactionOjb, rhs: TransactionOjb) -> Bool {
        lhs.id == rhs.id
    }
}
